import {controller, targets} from '@github/catalyst'
import {isActivation, isKeyboardActivation, isKeyboardActivationViaSpace} from '../../utils'

export type SelectVariant = 'none' | 'single' | 'multiple' | 'multiple_checkbox' | null
export type SelectedItem = {
  label: string | null | undefined
  value: string | null | undefined
  element: Element
}

export type ItemActivatedEvent = {
  item: HTMLElement
  checked: boolean
}

export type DialogItemActivatedEvent = ItemActivatedEvent & {
  dialog: HTMLElement
}

declare global {
  interface HTMLElementEventMap {
    itemActivated: CustomEvent<ItemActivatedEvent>
    dialogItemActivated: CustomEvent<DialogItemActivatedEvent>
  }
}

@controller
export class ActionListElement extends HTMLElement {
  @targets
  items: HTMLElement[]

  #abortController: AbortController
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

  get selectedItems(): SelectedItem[] {
    const selectedItems = this.querySelectorAll('[aria-checked=true]')
    const results: SelectedItem[] = []

    for (const selectedItem of selectedItems) {
      const labelEl = selectedItem.querySelector('.ActionListItem-label')

      results.push({
        label: labelEl?.textContent,
        value: selectedItem?.getAttribute('data-value'),
        element: selectedItem,
      })
    }

    return results
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())

    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.addEventListener('mousedown', this, {signal})

    this.#updateInput()
    this.softDisableItems()
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  softDisableItems() {
    const {signal} = this.#abortController

    for (const item of this.querySelectorAll('.ActionListContent')) {
      item.addEventListener('click', this.#potentiallyDisallowActivation.bind(this), {signal})
      item.addEventListener('keydown', this.#potentiallyDisallowActivation.bind(this), {signal})
    }
  }

  // returns true if activation was prevented
  #potentiallyDisallowActivation(event: Event): boolean {
    if (!isActivation(event)) return false

    const item = (event.target as HTMLElement).closest('.ActionListContent')
    if (!item) return false

    if (item.getAttribute('aria-disabled')) {
      event.preventDefault()
      event.stopPropagation()
      event.stopImmediatePropagation()
      return true
    }

    return false
  }

  handleEvent(event: Event) {
    const eventIsActivation = isActivation(event)

    const item = (event.target as Element).closest('.ActionListContent')
    const targetIsItem = item !== null

    if (targetIsItem && eventIsActivation) {
      if (this.#potentiallyDisallowActivation(event)) return

      const dialogInvoker = item.closest('[data-show-dialog-id]')

      if (dialogInvoker) {
        const dialog = this.ownerDocument.getElementById(dialogInvoker.getAttribute('data-show-dialog-id') || '')

        if (dialog && this.contains(dialogInvoker)) {
          this.dispatchEvent(
            new CustomEvent('dialogItemActivated', {
              bubbles: true,
              detail: {
                item: item.parentElement,
                checked: this.isItemChecked(item.parentElement),
                dialog,
              },
            }),
          )

          return
        }
      }

      this.#activateItem(event, item)
      this.#handleItemActivated(item)

      // Pressing the space key on a button or link will cause the page to scroll unless preventDefault()
      // is called. While calling preventDefault() appears to have no effect on link navigation, it skips
      // form submission. The code below therefore only calls preventDefault() if the button has been
      // activated by the space key, and manually submits the form if the button is a submit button.
      if (isKeyboardActivation(event)) {
        if (isKeyboardActivationViaSpace(event)) {
          event.preventDefault()
        }

        if (item.getAttribute('type') === 'submit') {
          item.closest('form')?.submit()
        }
      }
    }
  }

  #handleItemActivated(item: Element) {
    if (this.#hasAnySelectBehavior) {
      const ariaChecked = item.getAttribute('aria-checked')
      const checked = ariaChecked !== 'true'

      if (this.selectVariant === 'single') {
        // Only check, never uncheck here. Single-select mode does not allow unchecking a checked item.
        if (checked) {
          item.setAttribute('aria-checked', 'true')
        }

        for (const checkedItem of this.querySelectorAll('[aria-checked]')) {
          if (checkedItem !== item) {
            checkedItem.setAttribute('aria-checked', 'false')
          }
        }
      } else {
        // multi-select mode allows unchecking a checked item
        item.setAttribute('aria-checked', `${checked}`)
      }

      this.#updateInput()
    }

    this.dispatchEvent(
      new CustomEvent('itemActivated', {
        bubbles: true,
        detail: {item: item.parentElement, checked: this.isItemChecked(item.parentElement)},
      }),
    )
  }

  #activateItem(event: Event, item: Element) {
    const eventWillActivateByDefault =
      (event instanceof MouseEvent && event.type === 'click') ||
      (event instanceof KeyboardEvent &&
        event.type === 'keydown' &&
        !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
        event.key === 'Enter')

    // if the event will result in activating the current item by default, i.e. is a
    // mouse click or keyboard enter, bail out
    if (eventWillActivateByDefault) return

    // otherwise, event will not result in activation by default, so we stop it and
    // simulate a click
    event.stopPropagation()
    const elem = item as HTMLElement
    elem.click()
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

  get #hasAnySelectBehavior(): boolean {
    return this.#hasSingleSelectBehavior || this.#hasMultiSelectBehavior
  }

  get #hasMultiSelectBehavior(): boolean {
    return this.selectVariant === 'multiple' || this.selectVariant === 'multiple_checkbox'
  }

  get #hasSingleSelectBehavior(): boolean {
    return this.selectVariant === 'single'
  }

  get #hasNoSelectBehavior(): boolean {
    return this.selectVariant === 'none'
  }

  getItemById(itemId: string): HTMLElement | null {
    return this.querySelector(`li[data-item-id="${itemId}"`)
  }

  isItemDisabled(item: Element | null): boolean {
    if (item) {
      return item.classList.contains('ActionListItem--disabled')
    } else {
      return false
    }
  }

  disableItem(item: Element | null) {
    if (item) {
      item.classList.add('ActionListItem--disabled')
      item.querySelector('.ActionListContent')!.setAttribute('aria-disabled', 'true')
    }
  }

  enableItem(item: Element | null) {
    if (item) {
      item.classList.remove('ActionListItem--disabled')
      item.querySelector('.ActionListContent')!.removeAttribute('aria-disabled')
    }
  }

  isItemHidden(item: Element | null): boolean {
    if (item) {
      return item.hasAttribute('hidden')
    } else {
      return false
    }
  }

  hideItem(item: Element | null) {
    if (item) {
      item.setAttribute('hidden', 'hidden')
    }
  }

  showItem(item: Element | null) {
    if (item) {
      item.removeAttribute('hidden')
    }
  }

  isItemChecked(item: Element | null) {
    if (item) {
      return item.querySelector('.ActionListContent')!.getAttribute('aria-checked') === 'true'
    } else {
      return false
    }
  }

  // returns true if any action was taken, false otherwise
  checkItem(item: Element | null) {
    if (item && this.#hasAnySelectBehavior) {
      const itemContent = item.querySelector('.ActionListContent')! as HTMLElement
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (!ariaChecked) {
        this.#handleItemActivated(itemContent)
      }
    }
  }

  // returns true if any action was taken, false otherwise
  uncheckItem(item: Element | null) {
    if (item && this.#hasAnySelectBehavior) {
      const itemContent = item.querySelector('.ActionListContent')! as HTMLElement
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (ariaChecked) {
        this.#handleItemActivated(itemContent)
      }
    }
  }
}

if (!window.customElements.get('action-list')) {
  window.ActionListElement = ActionListElement
  window.customElements.define('action-list', ActionListElement)
}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
