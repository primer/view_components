type SelectVariant = 'single' | 'multiple' | null

const menuItemSelector = '[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"]'

function isPrintableCharacter(str: string) {
  return str.length === 1 && str.match(/\S/)
}

export class ActionMenuElement extends HTMLElement {
  #abortController: AbortController
  #previouslyFocusedElement: Element | null = null
  #shouldTryLoadingFragment = true

  get selectVariant(): SelectVariant {
    return this.getAttribute('data-select-variant') as SelectVariant
  }

  get menu(): HTMLUListElement | null {
    return this.querySelector<HTMLUListElement>('[role="menu"]')
  }

  get popoverElement(): HTMLElement | null {
    return this.querySelector<HTMLElement>('[popover]')
  }

  get menuItems(): HTMLElement[] {
    return Array.from(this.menu?.querySelectorAll<HTMLElement>(menuItemSelector) ?? [])
  }

  get includeFragmentLoadingItem(): HTMLElement | null {
    return this.querySelector<HTMLElement>(`[data-target~="action-menu.includeFragmentLoadingItem"]`)
  }

  connectedCallback() {
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.popoverElement?.addEventListener('beforetoggle', this, {signal})
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    const target = event.target
    const isMenuItem = target instanceof HTMLElement && target.matches(menuItemSelector)
    if (event.type === 'beforetoggle' && (event as BeforeToggleEvent).newState === 'open') {
      if (this.includeFragmentLoadingItem) {
        this.includeFragmentLoadingItem.tabIndex = 0
        this.includeFragmentLoadingItem.focus()
      }
      this.#previouslyFocusedElement = document.activeElement
    } else if (event.type === 'beforetoggle' && (event as BeforeToggleEvent).newState === 'closed') {
      // TODO: Do this without a setTimeout
      setTimeout(() => {
        // There are some actions that may move focus to another part of the page intentionally.
        // For example: "Quote Reply" in the comment options moves focus to the comment box.
        // This only moves focus to the trigger if it's not managed in another way.
        if (document.activeElement === document.body && this.#previouslyFocusedElement instanceof HTMLElement) {
          this.#previouslyFocusedElement.focus()
        }
      }, 1)
    } else if (!isMenuItem && event.type === 'keydown') {
      this.buttonKeydown(event as KeyboardEvent)
    } else if (isMenuItem && event.type === 'keydown') {
      this.menuItemKeydown(event as KeyboardEvent)
    } else if (isMenuItem && event.type === 'click') {
      this.menuItemClick(event as MouseEvent)
    } else if (isMenuItem && event.type === 'mouseover') {
      this.menuItemMouseover(event as MouseEvent)
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
    let newMenuItem: HTMLElement
    let index = null

    if (currentMenuItem === this.menuItems[0]) {
      newMenuItem = this.menuItems.at(-1)!
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

    if (currentMenuItem === this.menuItems.at(-1)) {
      newMenuItem = this.menuItems[0]
    } else {
      index = this.menuItems.indexOf(currentMenuItem)
      newMenuItem = this.menuItems[index + 1]
    }
    this.setFocusToMenuItem(newMenuItem)

    return newMenuItem
  }

  setFocusByFirstCharacter(currentMenuItem: HTMLElement, character: string) {
    if (!this.menuItems) return
    if (character.length > 1) return

    character = character.toLowerCase()

    // Get start index for search based on position of currentMenuItem
    let start = this.menuItems.indexOf(currentMenuItem) + 1
    if (start >= this.menuItems.length) {
      start = 0
    }

    // Check remaining slots in the menu
    for (const menuItem of this.menuItems.slice(start).concat(this.menuItems.slice(0, start))) {
      if (menuItem.textContent?.trim()[0].toLowerCase() === character) {
        this.setFocusToMenuItem(menuItem)
        return
      }
    }
  }

  // Menu event handlers
  buttonKeydown(event: KeyboardEvent) {
    switch (event.key) {
      case ' ':
      case 'Enter':
      case 'ArrowDown':
      case 'Down':
        this.popoverElement?.showPopover()
        this.setFocusToMenuItem(this.menuItems[0])
        break

      case 'Esc':
      case 'Escape':
        this.popoverElement?.hidePopover()
        break

      case 'Up':
      case 'ArrowUp':
        this.popoverElement?.showPopover()
        this.setFocusToMenuItem(this.menuItems.at(-1)!)
        break

      default:
        return
    }

    event.stopPropagation()
    event.preventDefault()
  }

  menuItemKeydown(event: KeyboardEvent) {
    const target = event.target
    const key = event.key
    let flag = false

    if (event.ctrlKey || event.altKey || event.metaKey) {
      return
    }

    if (event.shiftKey) {
      if (isPrintableCharacter(key)) {
        this.setFocusByFirstCharacter(target as HTMLElement, key)
        flag = true
      }

      if (event.key === 'Tab') {
        this.popoverElement?.hidePopover()
        flag = true
      }
    } else {
      switch (key) {
        case 'Enter':
          this.popoverElement?.hidePopover()
          break

        case 'Esc':
        case 'Escape':
          this.popoverElement?.hidePopover()
          flag = true
          break

        case 'Up':
        case 'ArrowUp':
          this.setFocusToPreviousMenuItem(target as HTMLElement)
          flag = true
          break

        case 'ArrowDown':
        case 'Down':
          this.setFocusToNextMenuItem(target as HTMLElement)
          flag = true
          break

        case 'Home':
        case 'PageUp':
          this.setFocusToMenuItem(this.menuItems[0])
          flag = true
          break

        case 'End':
        case 'PageDown':
          this.setFocusToMenuItem(this.menuItems.at(-1)!)
          flag = true
          break

        case 'Tab':
          this.popoverElement?.hidePopover()
          break

        default:
          if (isPrintableCharacter(key)) {
            this.setFocusByFirstCharacter(target as HTMLElement, key)
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
        for (const checkedItem of this.querySelectorAll('[aria-checked]')) {
          checkedItem.setAttribute('aria-checked', 'false')
        }
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        this.popoverElement?.hidePopover()
        break
      case 'multiple':
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        break
      default:
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        this.popoverElement?.hidePopover()
        break
    }
  }

  menuItemMouseover(event: MouseEvent) {
    ;(event.currentTarget as HTMLButtonElement).focus()
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
