import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'
// WORK IN PROGRESS - DO NOT USE

// Necessary to turn this file into an external module, which enables the Window
// interface modifications below.
export {}

class ActionMenuElement extends HTMLElement {
  #abortController: AbortController
  #firstCharactersOfItems: string[]
  #firstMenuItem: HTMLElement
  #lastMenuItem: HTMLElement

  get anchorAlign(): AnchorAlignment {
    return (this.getAttribute('data-anchor-align') || 'start') as AnchorAlignment
  }

  get anchorSide(): AnchorSide {
    return (this.getAttribute('data-anchor-side') || 'outside-bottom') as AnchorSide
  }

  get menu(): HTMLUListElement | null {
    return this.querySelector<HTMLUListElement>('[role="menu"]')
  }

  get trigger(): HTMLButtonElement | null {
    return this.querySelector<HTMLButtonElement>('button')
  }

  get #menuItems(): HTMLElement[] | null {
    if (!this.menu) return null

    return Array.from(
      this.menu.querySelectorAll<HTMLElement>('[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"]')
    )
  }

  set open(value: boolean) {
    if (value) {
      if (this.open) return
      if (!this.trigger || !this.menu) return

      this.setAttribute('open', '')
      this.trigger.setAttribute('aria-expanded', 'true')
      this.menu.removeAttribute('hidden')
      this.menu.style.visibility = 'hidden'

      this.#updatePosition()

      this.menu.style.visibility = 'visible'
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.trigger?.setAttribute('aria-expanded', 'false')
      this.#menuEl && this.#menuEl.hidden = true

      // TODO: Do this without a setTimeout
      setTimeout(() => {
        if (document.activeElement === document.body) this.trigger?.focus()
      }, 1)
    }
  }

  get open(): boolean {
    return this.hasAttribute('open')
  }

  connectedCallback() {
    if (!this.trigger) return

    // THIS IS TEMPORARY AND SHOULD BE REPLACED BY PRIMER CSS CLASS
    const style = document.createElement('style')
    style.innerHTML = `
        action-menu {
          position: relative;
        }
        action-menu ul {
          position: absolute;
          width: 160px;
          background-color: var(--color-canvas-overlay);
          z-index: 1000000;
          border: $border-width $border-style var(--color-border-default);
          border-radius: $border-radius;
          box-shadow: var(--color-shadow-large);
        }
    `
    document.querySelector('body')?.appendChild(style)

    this.#addEvents()
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  show() {
    this.open = true
  }

  hide() {
    this.open = false
  }

  #addEvents() {
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    if (!this.trigger || !this.menu) return
    this.trigger.addEventListener('keydown', this.buttonKeydown.bind(this), {signal})
    this.trigger.addEventListener('click', this.buttonClick.bind(this), {signal})

    this.#firstCharactersOfItems = []
    if (this.#menuItems) {
      for (const menuItem of this.#menuItems) {
        if (menuItem.textContent) {
          this.#firstCharactersOfItems.push(menuItem.textContent.trim()[0].toLowerCase())
        }

        menuItem.addEventListener('keydown', this.menuItemKeydown.bind(this), {signal})
        menuItem.addEventListener('click', this.menuItemClick.bind(this), {signal})
        menuItem.addEventListener('mouseover', this.menuItemMouseover.bind(this), {signal})

        if (!this.#firstMenuItem) {
          this.#firstMenuItem = menuItem
        }
        this.#lastMenuItem = menuItem
      }
    }

    window.addEventListener('mousedown', this.backgroundMousedown.bind(this), true)
  }

  setFocusToMenuItem(newMenuItem: HTMLElement) {
    if (!this.#menuItems) return

    for (const item of this.#menuItems) {
      if (item === newMenuItem) {
        item.tabIndex = 0
        newMenuItem.focus()
      } else {
        item.tabIndex = -1
      }
    }
  }

  setFocusToPreviousMenuItem(currentMenuItem: HTMLElement) {
    if (!this.#menuItems) return

    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#firstMenuItem) {
      newMenuItem = this.#lastMenuItem
    } else {
      index = this.#menuItems.indexOf(currentMenuItem)
      newMenuItem = this.#menuItems[index - 1]
    }

    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusToNextMenuItem(currentMenuItem: HTMLElement) {
    if (!this.#menuItems) return

    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#lastMenuItem) {
      newMenuItem = this.#firstMenuItem
    } else {
      index = this.#menuItems.indexOf(currentMenuItem)
      newMenuItem = this.#menuItems[index + 1]
    }
    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusByFirstCharacter(currentMenuItem: HTMLElement, character: string) {
    if (!this.#menuItems) return

    let start = null
    let index = null

    if (character.length > 1) {
      return
    }

    character = character.toLowerCase()

    // Get start index for search based on position of currentMenuItem
    start = this.#menuItems.indexOf(currentMenuItem) + 1
    if (start >= this.#menuItems.length) {
      start = 0
    }

    // Check remaining slots in the menu
    index = this.#firstCharactersOfItems.indexOf(character, start)

    // If character is not found in remaining slots, check from beginning
    if (index === -1) {
      index = this.#firstCharactersOfItems.indexOf(character, 0)
    }

    // If match is found
    if (index > -1) {
      this.setFocusToMenuItem(this.#menuItems[index])
    }
  }

  #updatePosition() {
    if (!this.trigger || !this.menu) return

    const float = this.menu
    const anchor = this.trigger
    const {top, left} = getAnchoredPosition(float, anchor, {side: this.anchorSide, align: this.anchorAlign})

    float.style.top = `${top}px`
    float.style.left = `${left}px`
  }

  // Menu event handlers
  buttonKeydown(event: KeyboardEvent) {
    const key = event.key
    let flag = false

    switch (key) {
      case ' ':
      case 'Enter':
      case 'ArrowDown':
      case 'Down':
        this.show()
        this.setFocusToMenuItem(this.#firstMenuItem)
        flag = true
        break

      case 'Esc':
      case 'Escape':
        this.hide()
        flag = true
        break

      case 'Up':
      case 'ArrowUp':
        this.show()
        this.setFocusToMenuItem(this.#lastMenuItem)
        flag = true
        break

      default:
        break
    }

    if (flag) {
      event.stopPropagation()
      event.preventDefault()
    }
  }

  buttonClick(event: MouseEvent) {
    if (this.open) {
      this.hide()
    } else {
      this.show()
      this.setFocusToMenuItem(this.#firstMenuItem)
    }

    event.stopPropagation()
    event.preventDefault()
  }

  menuItemKeydown(event: KeyboardEvent) {
    const currentTarget = event.currentTarget
    const key = event.key
    let flag = false

    function isPrintableCharacter(str: string) {
      return str.length === 1 && str.match(/\S/)
    }

    if (event.ctrlKey || event.altKey || event.metaKey) {
      return
    }

    if (event.shiftKey) {
      if (isPrintableCharacter(key)) {
        this.setFocusByFirstCharacter(currentTarget as HTMLElement, key)
        flag = true
      }

      if (event.key === 'Tab') {
        this.trigger?.focus()
        this.hide()
        flag = true
      }
    } else {
      switch (key) {
        case ' ':
        case 'Enter':
          this.hide()
          break

        case 'Esc':
        case 'Escape':
          this.hide()
          flag = true
          break

        case 'Up':
        case 'ArrowUp':
          this.setFocusToPreviousMenuItem(currentTarget as HTMLElement)
          flag = true
          break

        case 'ArrowDown':
        case 'Down':
          this.setFocusToNextMenuItem(currentTarget as HTMLElement)
          flag = true
          break

        case 'Home':
        case 'PageUp':
          this.setFocusToMenuItem(this.#firstMenuItem)
          flag = true
          break

        case 'End':
        case 'PageDown':
          this.setFocusToMenuItem(this.#lastMenuItem)
          flag = true
          break

        case 'Tab':
          this.hide()
          break

        default:
          if (isPrintableCharacter(key)) {
            this.setFocusByFirstCharacter(currentTarget as HTMLElement, key)
            flag = true
          }
          break
      }
    }

    if (flag) {
      event.stopPropagation()
      event.preventDefault()
    }
  }

  menuItemClick() {
    this.hide()
  }

  menuItemMouseover(event: MouseEvent) {
    // eslint-disable-next-line @typescript-eslint/no-extra-semi
    ;(event.currentTarget as HTMLButtonElement).focus()
  }

  backgroundMousedown(event: MouseEvent) {
    if (!this) return

    if (!this.contains(event.target as Node)) {
      if (this.open) {
        this.hide()
      }
    }
  }
}

if (!window.customElements.get('action-menu')) {
  window.ActionMenuElement = ActionMenuElement
  window.customElements.define('action-menu', ActionMenuElement)
}

declare global {
  interface Window {
    ActionMenuElement: typeof ActionMenuElement
  }
}
