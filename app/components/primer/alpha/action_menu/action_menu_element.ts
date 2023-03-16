const popoverSelector = (() => {
  try {
    document.querySelector(':open')
    return ':open'
  } catch {
    return '.\\:open'
  }
})()

type SelectVariant = 'single' | 'multiple' | null

const menuItemSelector = '[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"]'

export class ActionMenuElement extends HTMLElement {
  #abortController: AbortController

  get selectVariant(): SelectVariant {
    return this.getAttribute('data-select-variant') as SelectVariant
  }

  set selectVariant(variant: SelectVariant) {
    if (variant) {
      this.setAttribute('data-select-variant', variant)
    } else {
      this.removeAttribute('variant')
    }
  }

  get popoverElement(): HTMLElement | null {
    return this.querySelector<HTMLElement>('[popover]')
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.addEventListener('focusout', this, {signal})
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    if (!this.popoverElement?.matches(popoverSelector)) return

    if (event.type === 'focusout' && !this.contains((event as FocusEvent).relatedTarget as Node)) {
      this.popoverElement?.hidePopover()
    } else if (
      (event instanceof KeyboardEvent &&
        event.type === 'keydown' &&
        !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
        event.key === 'Enter') ||
      (event instanceof MouseEvent && event.type === 'click')
    ) {
      const item = (event.target as Element).closest(menuItemSelector)
      if (!item) return
      if (this.selectVariant === 'multiple') {
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
      } else {
        if (this.selectVariant === 'single') {
          for (const checkedItem of this.querySelectorAll('[aria-checked]')) {
            if (checkedItem !== item) {
              checkedItem.setAttribute('aria-checked', 'false')
            }
          }
        }
        item.setAttribute('aria-checked', `${item.getAttribute('aria-checked') === 'false'}`)
        this.popoverElement?.hidePopover()
        event.preventDefault()
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
