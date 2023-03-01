import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'
import type IncludeFragmentElement from '@github/include-fragment-element'

type SelectVariant = 'single' | 'multiple' | null

class ActionMenuElement extends HTMLElement {
  #abortController: AbortController
  #firstCharactersOfItems: string[]
  #firstMenuItem: HTMLElement
  #lastMenuItem: HTMLElement
  #shouldTryLoadingFragment = true

  get selectVariant(): SelectVariant {
    return this.getAttribute('data-select-variant') as SelectVariant
  }

  get menu(): HTMLUListElement | null {
    return this.querySelector<HTMLUListElement>('[role="menu"]')
  }

  get trigger(): HTMLButtonElement | null {
    return this.querySelector<HTMLButtonElement>('button')
  }

  get overlay(): HTMLDivElement | null {
    return this.querySelector<HTMLDivElement>('.Overlay')
  }

  get menuItems(): HTMLElement[] | null {
    if (!this.menu) return null

    return Array.from(
      this.menu.querySelectorAll<HTMLElement>('[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"]'),
    )
  }

  get includeFragment(): IncludeFragmentElement | null {
    return this.querySelector<IncludeFragmentElement>(`[data-target~="action-menu.includeFragment"]`)
  }

  get includeFragmentLoadingItem(): HTMLElement | null {
    return this.querySelector<HTMLElement>(`[data-target~="action-menu.includeFragmentLoadingItem"]`)
  }

  get open() {
    return this.hasAttribute('open')
  }

  set open(value: boolean) {
    const initialBodyWidth = document.body.clientWidth

    const observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (initialBodyWidth !== entry.contentRect.width && this.open) {
          this.#updatePosition()
        }
      }
    })

    if (value) {
      if (this.open) return
      if (!this.trigger || !this.menu) return

      this.setAttribute('open', '')
      this.trigger.setAttribute('aria-expanded', 'true')
      this.overlay?.removeAttribute('hidden')
      this.menu.style.visibility = 'hidden'

      this.#updatePosition()
      // If the window width is changed when the menu is open,
      // this keeps the menu aligned to the button
      observer.observe(document.body)

      this.menu.style.visibility = 'visible'

      if (this.includeFragmentLoadingItem) {
        this.includeFragmentLoadingItem.tabIndex = 0
        this.includeFragmentLoadingItem.focus()
      }
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.trigger?.setAttribute('aria-expanded', 'false')
      this.overlay && this.overlay.setAttribute('hidden', 'true')
      observer.unobserve(document.body)

      // TODO: Do this without a setTimeout
      setTimeout(() => {
        // There are some actions that may move focus to another part of the page intentionally.
        // For example: "Quote Reply" in the comment options moves focus to the comment box.
        // This only moves focus to the trigger if it's not managed in another way.
        if (document.activeElement === document.body) this.trigger?.focus()
      }, 1)
    }
  }

  connectedCallback() {
    if (!this.trigger) return

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

  #clearSelectedItems() {
    for (const item of this.querySelectorAll('[aria-checked]')) {
      item.setAttribute('aria-checked', 'false')
    }
  }

  #addEvents() {
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    if (!this.trigger || !this.menu) return
    this.trigger.addEventListener('keydown', this.buttonKeydown.bind(this), {signal})

    if (this.hasAttribute('preload')) {
      this.trigger.addEventListener('mouseenter', this.loadHTMLFragment.bind(this), {signal})
      this.trigger.addEventListener('focus', this.loadHTMLFragment.bind(this), {signal})
    }

    this.#firstCharactersOfItems = []

    this.#addEventsToMenuItems(signal)

    if (this.includeFragment) {
      this.includeFragment.addEventListener('load', this.handleIncludeFragmentLoaded.bind(this))
    }

    window.addEventListener('mousedown', this.backgroundMousedown.bind(this), true)
  }

  #addEventsToMenuItems(signal: AbortSignal) {
    if (!this.menuItems) return

    for (const menuItem of this.menuItems) {
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

  setFocusToMenuItem(newMenuItem: HTMLElement) {
    if (!this.menuItems) return

    for (const item of this.menuItems) {
      if (item === newMenuItem) {
        item.tabIndex = 0
        newMenuItem.focus()
      } else {
        item.tabIndex = -1
      }
    }
}

  setFocusToPreviousMenuItem(currentMenuItem: HTMLElement) {
    if (!this.menuItems) return

    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#firstMenuItem) {
      newMenuItem = this.#lastMenuItem
    } else {
      index = this.menuItems.indexOf(currentMenuItem)
      newMenuItem = this.menuItems[index - 1]
    }

    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusToNextMenuItem(currentMenuItem: HTMLElement) {
    if (!this.menuItems) return

    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#lastMenuItem) {
      newMenuItem = this.#firstMenuItem
    } else {
      index = this.menuItems.indexOf(currentMenuItem)
      newMenuItem = this.menuItems[index + 1]
    }
    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusByFirstCharacter(currentMenuItem: HTMLElement, character: string) {
    if (!this.menuItems) return

    let start = null
    let index = null

    if (character.length > 1) {
      return
    }

    character = character.toLowerCase()

    // Get start index for search based on position of currentMenuItem
    start = this.menuItems.indexOf(currentMenuItem) + 1
    if (start >= this.menuItems.length) {
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
      this.setFocusToMenuItem(this.menuItems[index])
    }
  }

  #updatePosition() {
    if (!this.trigger || !this.menu) return

    const float = this.querySelector<HTMLElement>('[data-menu-overlay]') || this.menu
    const anchor = this.trigger
    const {top, left} = getAnchoredPosition(float, anchor, {side: this.anchorSide, align: this.anchorAlign})

    float.style.top = `${top}px`
    float.style.left = `${left}px`
  }

  // Menu event handlers
  buttonKeydown(event: KeyboardEvent) {
    // TODO: use data-hotkey
    // eslint-disable-next-line no-restricted-syntax
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

  menuItemKeydown(event: KeyboardEvent) {
    const currentTarget = event.currentTarget
    // eslint-disable-next-line no-restricted-syntax
    const key = event.key
    let flag = false

    function isPrintableCharacter(str: string) {
      return str.length === 1 && str.match(/\S/)
    }

    // eslint-disable-next-line no-restricted-syntax
    if (event.ctrlKey || event.altKey || event.metaKey) {
      return
    }

    if (event.shiftKey) {
      if (isPrintableCharacter(key)) {
        this.setFocusByFirstCharacter(currentTarget as HTMLElement, key)
        flag = true
      }

      // eslint-disable-next-line no-restricted-syntax
      if (event.key === 'Tab') {
        this.trigger?.focus()
        this.hide()
        flag = true
      }
    } else {
      switch (key) {
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

  menuItemClick(event: MouseEvent) {
    const item = event.currentTarget as HTMLButtonElement

    switch (this.selectVariant) {
      case 'single':
        this.#clearSelectedItems()
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        this.hide()
        break
      case 'multiple':
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        break
      default:
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        this.hide()
        break
    }
  }

  menuItemMouseover(event: MouseEvent) {
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

  handleIncludeFragmentLoaded() {
    const {signal} = this.#abortController
    this.#addEventsToMenuItems(signal)

    if (this.open) {
      this.setFocusToMenuItem(this.#firstMenuItem)
    }
  }

  async loadHTMLFragment(): Promise<string | undefined> {
    if (!this.#shouldTryLoadingFragment) return
    this.#shouldTryLoadingFragment = false
    try {
      const htmlFragment = await this.includeFragment?.load()
      return htmlFragment
    } catch (e) {
      //allow retries on failure
      this.#shouldTryLoadingFragment = true
      return
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
