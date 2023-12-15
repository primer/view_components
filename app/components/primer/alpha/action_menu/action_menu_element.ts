import {controller, target} from '@github/catalyst'
import '@oddbird/popover-polyfill'
import type {IncludeFragmentElement} from '@github/include-fragment-element'

type SelectVariant = 'none' | 'single' | 'multiple' | null
type SelectedItem = {
  label: string | null | undefined
  value: string | null | undefined
  element: Element
}

const validSelectors = ['[role="menuitem"]', '[role="menuitemcheckbox"]', '[role="menuitemradio"]']
const menuItemSelectors = validSelectors.map(selector => `:not([hidden]) > ${selector}`)

export type ItemActivatedEvent = {
  item: Element
  checked: boolean
}

declare global {
  interface HTMLElementEventMap {
    itemActivated: CustomEvent<ItemActivatedEvent>
  }
}

@controller
export class ActionMenuElement extends HTMLElement {
  @target
  includeFragment: IncludeFragmentElement

  #abortController: AbortController
  #originalLabel = ''
  #inputName = ''
  #invokerBeingClicked = false

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
    return (this.invokerElement?.popoverTargetElement as HTMLElement) || null
  }

  get invokerElement(): HTMLButtonElement | null {
    const id = this.querySelector('[role=menu]')?.id
    if (!id) return null
    for (const el of this.querySelectorAll(`[aria-controls]`)) {
      if (el.getAttribute('aria-controls') === id) {
        return el as HTMLButtonElement
      }
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
    this.addEventListener('focusout', this, {signal})
    this.addEventListener('mousedown', this, {signal})
    this.#setDynamicLabel()
    this.#updateInput()
    this.#softDisableItems()

    if (this.includeFragment) {
      this.includeFragment.addEventListener('include-fragment-replaced', this, {
        signal,
      })
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  #softDisableItems() {
    const {signal} = this.#abortController

    for (const item of this.querySelectorAll(validSelectors.join(','))) {
      item.addEventListener('click', this.#potentiallyDisallowActivation.bind(this), {signal})
      item.addEventListener('keydown', this.#potentiallyDisallowActivation.bind(this), {signal})
    }
  }

  // returns true if activation was prevented
  #potentiallyDisallowActivation(event: Event): boolean {
    if (!this.#isActivation(event)) return false

    const item = (event.target as HTMLElement).closest(menuItemSelectors.join(','))
    if (!item) return false

    if (item.getAttribute('aria-disabled')) {
      event.preventDefault()
      event.stopPropagation()
      event.stopImmediatePropagation()
      return true
    }

    return false
  }

  #isKeyboardActivation(event: Event): boolean {
    return this.#isKeyboardActivationViaEnter(event) || this.#isKeyboardActivationViaSpace(event)
  }

  #isKeyboardActivationViaEnter(event: Event): boolean {
    return (
      event instanceof KeyboardEvent &&
      event.type === 'keydown' &&
      !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
      event.key === 'Enter'
    )
  }

  #isKeyboardActivationViaSpace(event: Event): boolean {
    return (
      event instanceof KeyboardEvent &&
      event.type === 'keydown' &&
      !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
      event.key === ' '
    )
  }

  #isMouseActivation(event: Event): boolean {
    return event instanceof MouseEvent && event.type === 'click'
  }

  #isActivation(event: Event): boolean {
    return this.#isMouseActivation(event) || this.#isKeyboardActivation(event)
  }

  handleEvent(event: Event) {
    const targetIsInvoker = this.invokerElement?.contains(event.target as HTMLElement)
    const eventIsActivation = this.#isActivation(event)

    if (targetIsInvoker && event.type === 'mousedown') {
      this.#invokerBeingClicked = true
      return
    }

    // Prevent safari bug that dismisses menu on mousedown instead of allowing
    // the click event to propagate to the button
    if (event.type === 'mousedown') {
      event.preventDefault()
      return
    }

    if (targetIsInvoker && eventIsActivation) {
      this.#handleInvokerActivated(event)
      this.#invokerBeingClicked = false
      return
    }

    if (event.type === 'focusout') {
      if (this.#invokerBeingClicked) return

      // Give the browser time to focus the next element
      requestAnimationFrame(() => {
        if (!this.contains(document.activeElement) || document.activeElement === this.invokerElement) {
          this.#handleFocusOut()
        }
      })

      return
    }

    const item = (event.target as Element).closest(menuItemSelectors.join(','))
    const targetIsItem = item !== null

    if (targetIsItem && eventIsActivation) {
      if (this.#potentiallyDisallowActivation(event)) return

      const dialogInvoker = item.closest('[data-show-dialog-id]')

      if (dialogInvoker) {
        const dialog = this.ownerDocument.getElementById(dialogInvoker.getAttribute('data-show-dialog-id') || '')

        if (dialog && this.contains(dialogInvoker) && this.contains(dialog)) {
          this.#handleDialogItemActivated(event, dialog as HTMLDialogElement)
          return
        }
      }

      this.#activateItem(event, item)
      this.#handleItemActivated(item)

      // Pressing the space key on a button or link will cause the page to scroll unless preventDefault()
      // is called. While calling preventDefault() appears to have no effect on link navigation, it skips
      // form submission. The code below therefore only calls preventDefault() if the button has been
      // activated by the space key, and manually submits the form if the button is a submit button.
      if (this.#isKeyboardActivationViaSpace(event)) {
        event.preventDefault()

        if (item.getAttribute('type') === 'submit') {
          item.closest('form')?.submit()
        }
      }

      return
    }

    if (event.type === 'include-fragment-replaced') {
      this.#handleIncludeFragmentReplaced()
    }
  }

  #handleInvokerActivated(event: Event) {
    event.preventDefault()
    event.stopPropagation()

    if (this.#isOpen()) {
      this.#hide()
    } else {
      this.#show()
      this.#firstItem?.focus()
    }
  }

  #handleDialogItemActivated(event: Event, dialog: HTMLDialogElement) {
    this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = 'none'
    const dialog_controller = new AbortController()
    const {signal} = dialog_controller
    const handleDialogClose = () => {
      dialog_controller.abort()
      this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = ''
      if (this.#isOpen()) {
        this.#hide()
      }
      const activeElement = this.ownerDocument.activeElement
      const lostFocus = this.ownerDocument.activeElement === this.ownerDocument.body
      const focusInClosedMenu = this.contains(activeElement)
      if (lostFocus || focusInClosedMenu) {
        setTimeout(() => this.invokerElement?.focus(), 0)
      }
    }

    // At this point, the dialog is about to open. When it opens, all other popovers (incuding
    // this ActionMenu) will be closed. We listen to the toggle event here, which will fire when
    // the menu is closed and manually re-open it. When the menu is re-opened, it gets added to
    // the top of the popover stack. Only the item at the top of the stack will close when the
    // escape key is pressed, so we add another beforetoggle listener. When the escape key is
    // pressed, the listener is invoked, which manually closes the dialog. Closing the dialog
    // causes the dialog's close event to fire, which
    this.popoverElement?.addEventListener(
      'toggle',
      (toggleEvent: Event) => {
        if ((toggleEvent as ToggleEvent).newState === 'closed') {
          this.#show()
          this.popoverElement?.addEventListener(
            'beforetoggle',
            (beforeToggleEvent: Event) => {
              if ((beforeToggleEvent as ToggleEvent).newState === 'closed') {
                dialog.close()
              }
            },
            {signal},
          )
        }
      },
      {signal, once: true},
    )

    dialog.addEventListener('close', handleDialogClose, {signal})
    dialog.addEventListener('cancel', handleDialogClose, {signal})
  }

  #handleItemActivated(item: Element) {
    // Hide popover after current event loop to prevent changes in focus from
    // altering the target of the event. Not doing this specifically affects
    // <a> tags. It causes the event to be sent to the currently focused element
    // instead of the anchor, which effectively prevents navigation, i.e. it
    // appears as if hitting enter does nothing. Curiously, clicking instead
    // works fine.
    if (this.selectVariant !== 'multiple') {
      setTimeout(() => {
        if (this.#isOpen()) {
          this.#hide()
        }
      })
    }

    // The rest of the code below deals with single/multiple selection behavior, and should not
    // interfere with events fired by menu items whose behavior is specified outside the library.
    if (this.selectVariant !== 'multiple' && this.selectVariant !== 'single') return

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

      this.#setDynamicLabel()
    } else {
      // multi-select mode allows unchecking a checked item
      item.setAttribute('aria-checked', `${checked}`)
    }

    this.#updateInput()
    this.dispatchEvent(
      new CustomEvent('itemActivated', {
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

  #handleIncludeFragmentReplaced() {
    if (this.#firstItem) this.#firstItem.focus()
    this.#softDisableItems()
  }

  // Close when focus leaves menu
  #handleFocusOut() {
    this.#hide()
  }

  #show() {
    this.popoverElement?.showPopover()
  }

  #hide() {
    this.popoverElement?.hidePopover()
  }

  #isOpen() {
    return this.popoverElement?.matches(':popover-open')
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

  get #firstItem(): HTMLElement | null {
    return this.querySelector(menuItemSelectors.join(','))
  }

  get items(): HTMLElement[] {
    return Array.from(this.querySelectorAll(menuItemSelectors.join(',')))
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

  checkItem(item: Element | null) {
    if (item && (this.selectVariant === 'single' || this.selectVariant === 'multiple')) {
      const itemContent = item.querySelector('.ActionListContent')!
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (!ariaChecked) {
        this.#handleItemActivated(itemContent)
      }
    }
  }

  uncheckItem(item: Element | null) {
    if (item && (this.selectVariant === 'single' || this.selectVariant === 'multiple')) {
      const itemContent = item.querySelector('.ActionListContent')!
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (ariaChecked) {
        this.#handleItemActivated(itemContent)
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
