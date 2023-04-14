import '@github/include-fragment-element'

const popoverSelector = (() => {
  try {
    document.querySelector(':open')
    return ':open'
  } catch {
    return '.\\:open'
  }
})()

type SelectVariant = 'single' | 'multiple' | null

const menuItemSelectors = ['[role="menuitem"]', '[role="menuitemcheckbox"]', '[role="menuitemradio"]', '[role="none"]']

export class ActionMenuElement extends HTMLElement {
  #abortController: AbortController
  #originalLabel = ''

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

  get dynamicLabelPrefix(): string {
    const prefix = this.getAttribute('data-dynamic-label-prefix')
    if (!prefix) return ''
    return `${prefix}:`
  }

  set dynamicLabelPrefix(value: string) {
    this.setAttribute('data-dynamic-label', value)
  }

  get dynamicLabel(): boolean {
    return this.hasAttribute('data-dynamic-label')
  }

  set dynamicLabel(value: boolean) {
    this.toggleAttribute('data-dynamic-label', value)
  }

  get popoverElement(): HTMLElement | null {
    return this.querySelector<HTMLElement>('[popover]')
  }

  get invokerElement(): HTMLElement | null {
    const id = this.querySelector('[role=menu]')?.id
    if (!id) return null
    for (const el of this.querySelectorAll(`[aria-controls]`)) {
      if (el.getAttribute('aria-controls') === id) return el as HTMLElement
    }
    return null
  }

  get invokerLabel(): HTMLElement | null {
    if (!this.invokerElement) return null
    return this.invokerElement.querySelector('.Button-label')
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.addEventListener('focusout', this, {signal})
    this.#setDynamicLabel()
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
      const item = (event.target as Element).closest(menuItemSelectors.join(','))?.closest('li')
      if (!item) return
      const ariaChecked = item.getAttribute('aria-checked')
      const checked = ariaChecked !== 'true'
      item.setAttribute('aria-checked', `${checked}`)
      if (this.selectVariant === 'single') {
        const selector = menuItemSelectors.map(s => `li[aria-checked] ${s}`).join(',')
        for (const checkedItemContent of this.querySelectorAll(selector)) {
          const checkedItem = checkedItemContent.closest('li')!
          if (checkedItem !== item) {
            checkedItem.setAttribute('aria-checked', 'false')
          }
        }
        this.#setDynamicLabel()
      }
      event.preventDefault()
      this.popoverElement?.hidePopover()
    }
  }

  #setDynamicLabel() {
    if (!this.dynamicLabel) return
    const invokerLabel = this.invokerLabel
    if (!invokerLabel) return
    const selector = menuItemSelectors.map(s => `${s}[aria-checked=true] .ActionListItem-label`).join(',')
    const item = this.querySelector(selector)
    if (item && this.dynamicLabel) {
      this.#originalLabel ||= invokerLabel.textContent || ''
      const prefixSpan = document.createElement('span')
      prefixSpan.classList.add('color-fg-muted')
      const contentSpan = document.createElement('span')
      prefixSpan.textContent = this.dynamicLabelPrefix
      contentSpan.textContent = item.textContent || ''
      invokerLabel.replaceChildren(prefixSpan, contentSpan)
    } else {
      invokerLabel.textContent = this.#originalLabel
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
