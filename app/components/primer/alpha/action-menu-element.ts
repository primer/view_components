// WORK IN PROGRESS - DO NOT USE

// Necessary to turn this file into an external module, which enables the Window
// interface modifications below.
export {}

class ActionMenuElement extends HTMLElement {
  #abortController: AbortController

  // eslint-disable-next-line no-invalid-this
  #actionMenuEl: HTMLElement = this
  // eslint-disable-next-line no-invalid-this
  #buttonEl = this.querySelector<HTMLButtonElement>('button')
  // eslint-disable-next-line no-invalid-this
  #menuEl = this.querySelector<HTMLUListElement>('[role="menu"]')
  #menuItemEls: HTMLElement[] = []
  #firstMenuItem: HTMLElement
  #lastMenuItem: HTMLElement
  #firstCharactersOfItems: string[] = []
  // eslint-disable-next-line no-undef
  #allMenuItemEls: NodeListOf<HTMLElement> | null =
    // eslint-disable-next-line no-invalid-this
    this.#menuEl && this.#menuEl.querySelectorAll('[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"]')

  connectedCallback() {
    if (!this.#buttonEl) return

    this.addEvents()
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  private addEvents() {
    if (!this.#buttonEl || !this.#menuEl) return

    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.#buttonEl.addEventListener('keydown', this.buttonKeydown.bind(this), {signal})
    this.#buttonEl.addEventListener('click', this.buttonClick.bind(this), {signal})

    if (this.#allMenuItemEls) {
      for (let i = 0; i < this.#allMenuItemEls.length; i++) {
        const menuItem = this.#allMenuItemEls[i]
        this.#menuItemEls.push(menuItem)
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
    for (const item of this.#menuItemEls) {
      if (item === newMenuItem) {
        item.tabIndex = 0
        newMenuItem.focus()
      } else {
        item.tabIndex = -1
      }
    }
  }

  setFocusToFirstMenuItem() {
    this.setFocusToMenuItem(this.#firstMenuItem)
  }

  setFocusToLastMenuItem() {
    this.setFocusToMenuItem(this.#lastMenuItem)
  }

  setFocusToPreviousMenuItem(currentMenuItem: HTMLElement) {
    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#firstMenuItem) {
      newMenuItem = this.#lastMenuItem
    } else {
      index = this.#menuItemEls.indexOf(currentMenuItem)
      newMenuItem = this.#menuItemEls[index - 1]
    }

    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusToNextMenuItem(currentMenuItem: HTMLElement) {
    let newMenuItem = null
    let index = null

    if (currentMenuItem === this.#lastMenuItem) {
      newMenuItem = this.#firstMenuItem
    } else {
      index = this.#menuItemEls.indexOf(currentMenuItem)
      newMenuItem = this.#menuItemEls[index + 1]
    }
    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusByFirstCharacter(currentMenuItem: HTMLElement, character: string) {
    let start = null
    let index = null

    if (character.length > 1) {
      return
    }

    character = character.toLowerCase()

    // Get start index for search based on position of currentMenuItem
    start = this.#menuItemEls.indexOf(currentMenuItem) + 1
    if (start >= this.#menuItemEls.length) {
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
      this.setFocusToMenuItem(this.#menuItemEls[index])
    }
  }

  openPopup() {
    if (!this.#buttonEl || !this.#menuEl) return

    this.#buttonEl.setAttribute('aria-expanded', 'true')
    this.#menuEl?.removeAttribute('hidden')
  }

  closePopup() {
    if (!this.#buttonEl) return

    if (this.isOpen()) {
      this.#buttonEl.removeAttribute('aria-expanded')
      this.#menuEl?.setAttribute('hidden', 'hidden')
    }

    // TODO: Do this without a setTimeout
    setTimeout(() => {
      if (document.activeElement === document.body) this.#buttonEl?.focus()
    }, 1)
  }

  isOpen() {
    if (!this.#buttonEl) return

    return this.#buttonEl.getAttribute('aria-expanded') === 'true'
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
        this.openPopup()
        this.setFocusToFirstMenuItem()
        flag = true
        break

      case 'Esc':
      case 'Escape':
        this.closePopup()
        flag = true
        break

      case 'Up':
      case 'ArrowUp':
        this.openPopup()
        this.setFocusToLastMenuItem()
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
    if (this.isOpen()) {
      this.closePopup()
    } else {
      this.openPopup()
      this.setFocusToFirstMenuItem()
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
        this.#buttonEl?.focus()
        this.closePopup()
        flag = true
      }
    } else {
      switch (key) {
        case ' ':
        case 'Enter':
          this.closePopup()
          break

        case 'Esc':
        case 'Escape':
          this.closePopup()
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
          this.setFocusToFirstMenuItem()
          flag = true
          break

        case 'End':
        case 'PageDown':
          this.setFocusToLastMenuItem()
          flag = true
          break

        case 'Tab':
          this.closePopup()
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
    this.closePopup()
  }

  menuItemMouseover(event: MouseEvent) {
    // eslint-disable-next-line @typescript-eslint/no-extra-semi
    ;(event.currentTarget as HTMLButtonElement).focus()
  }

  backgroundMousedown(event: MouseEvent) {
    if (!this.#actionMenuEl) return

    if (!this.#actionMenuEl.contains(event.target as Node)) {
      if (this.isOpen()) {
        this.closePopup()
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
