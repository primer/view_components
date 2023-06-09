import {controller, target} from '@github/catalyst'
import IncludeFragmentElement from '@github/include-fragment-element'

type SelectVariant = 'none' | 'single' | 'multiple' | null
type SelectedItem = {
  label: string | null | undefined
  value: string | null | undefined
  element: Element
}

const menuItemSelectors = ['[role="menuitem"]', '[role="menuitemcheckbox"]', '[role="menuitemradio"]']

@controller
export class ActionMenuElement extends HTMLElement {
  @target includeFragment: IncludeFragmentElement

  #abortController: AbortController
  #originalLabel = ''
  #inputName = ''

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

  get selectedItems(): SelectedItem[] {
    const selectedItems = this.querySelectorAll('[aria-checked=true]')
    const results: SelectedItem[] = []

    for (const selectedItem of selectedItems) {
      const labelEl = selectedItem.querySelector('.ActionListItem-label')

      results.push({
        label: labelEl?.textContent,
        value: selectedItem?.getAttribute('data-value'),
        element: selectedItem
      })
    }

    return results
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.addEventListener('focusout', this, {signal})
    this.#setDynamicLabel()
    this.#updateInput()

    if (this.includeFragment) {
      this.includeFragment.addEventListener('include-fragment-replaced', this, {signal})
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    if (event.target === this.invokerElement && this.#isActivationKeydown(event)) {
      if (this.#firstItem) {
        event.preventDefault()
        this.popoverElement?.showPopover()
        this.#firstItem.focus()
        return
      }
    }

    if (!this.popoverElement?.matches(':popover-open')) return

    if (event.type === 'include-fragment-replaced') {
      if (this.#firstItem) this.#firstItem.focus()
    } else if (this.#isActivationKeydown(event) || (event instanceof MouseEvent && event.type === 'click')) {
      // Hide popover after current event loop to prevent changes in focus from
      // altering the target of the event. Not doing this specifically affects
      // <a> tags. It causes the event to be sent to the currently focused element
      // instead of the anchor, which effectively prevents navigation, i.e. it
      // appears as if hitting enter does nothing. Curiously, clicking instead
      // works fine.
      if (this.selectVariant !== 'multiple') {
        setTimeout(() => this.popoverElement?.hidePopover())
      }

      if (this.selectVariant !== 'multiple' && this.selectVariant !== 'single') return

      const item = (event.target as Element).closest(menuItemSelectors.join(','))
      if (!item) return
      const ariaChecked = item.getAttribute('aria-checked')
      const checked = ariaChecked !== 'true'
      item.setAttribute('aria-checked', `${checked}`)
      if (this.selectVariant === 'single') {
        for (const checkedItem of this.querySelectorAll('[aria-checked]')) {
          if (checkedItem !== item) {
            checkedItem.setAttribute('aria-checked', 'false')
          }
        }
        this.#setDynamicLabel()
      }

      this.#updateInput()

      if (event instanceof KeyboardEvent && event.target instanceof HTMLButtonElement) {
        // prevent buttons from being clicked twice
        event.preventDefault()
      }
    }
  }

  #setDynamicLabel() {
    if (!this.dynamicLabel) return
    const invokerLabel = this.invokerLabel
    if (!invokerLabel) return
    this.#originalLabel ||= invokerLabel.textContent || ''
    const itemLabel = this.querySelector('[aria-checked=true] .ActionListItem-label')
    if (itemLabel && this.dynamicLabel) {
      const prefixSpan = document.createElement('span')
      prefixSpan.classList.add('color-fg-muted')
      const contentSpan = document.createElement('span')
      prefixSpan.textContent = this.dynamicLabelPrefix
      contentSpan.textContent = itemLabel.textContent || ''
      invokerLabel.replaceChildren(prefixSpan, contentSpan)
    } else {
      invokerLabel.textContent = this.#originalLabel
    }
  }

  #updateInput() {
    if (this.selectVariant === 'single') {
      const input = this.querySelector(`[data-list-inputs=true] input`) as HTMLInputElement | null
      if (!input) return

      const selectedItem = this.selectedItems[0]

      if (selectedItem) {
        input.value = (selectedItem.value || selectedItem.label || '').trim()
        input.removeAttribute('disabled')
      } else {
        input.setAttribute('disabled', 'disabled')
      }
    } else if (this.selectVariant !== 'none') {
      // multiple select variant
      const inputList = this.querySelector('[data-list-inputs=true]')
      if (!inputList) return

      const inputs = inputList.querySelectorAll('input')

      if (inputs.length > 0) {
        this.#inputName ||= (inputs[0] as HTMLInputElement).name
      }

      for (const selectedItem of this.selectedItems) {
        const newInput = document.createElement('input')
        newInput.setAttribute('data-list-input', 'true')
        newInput.type = 'hidden'
        newInput.autocomplete = 'off'
        newInput.name = this.#inputName
        newInput.value = (selectedItem.value || selectedItem.label || '').trim()

        inputList.append(newInput)
      }

      for (const input of inputs) {
        input.remove()
      }
    }
  }

  #isActivationKeydown(event: Event): boolean {
    return (
      event instanceof KeyboardEvent &&
      event.type === 'keydown' &&
      !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
      (event.key === 'Enter' || event.key === ' ')
    )
  }

  get #firstItem(): HTMLElement | null {
    return this.querySelector(menuItemSelectors.join(','))
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
