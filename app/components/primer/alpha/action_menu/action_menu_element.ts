import {controller, target, targets} from '@github/catalyst'
import '@oddbird/popover-polyfill'
import type {IncludeFragmentElement} from '@github/include-fragment-element'
import {isActivation} from '../../utils'
import {
  ActionListElement,
  DialogItemActivatedEvent,
  ItemActivatedEvent,
  SelectedItem,
  SelectVariant,
} from '../action_list/action_list_element'

@controller
export class ActionMenuElement extends HTMLElement {
  @target
  includeFragment: IncludeFragmentElement

  @targets
  lists: ActionListElement[]

  #abortController: AbortController
  #originalLabel = ''
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
    const result = []

    for (const list of this.lists) {
      result.push(...list.selectedItems)
    }

    return result
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())

    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('focusout', this, {signal})
    this.addEventListener('itemActivated', this, {signal})
    this.addEventListener('dialogItemActivated', this, {signal})

    this.#setDynamicLabel()

    if (this.includeFragment) {
      this.includeFragment.addEventListener('include-fragment-replaced', this, {
        signal,
      })
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    const targetIsInvoker = this.invokerElement?.contains(event.target as HTMLElement)
    const eventIsActivation = isActivation(event)

    if (targetIsInvoker && event.type === 'mousedown') {
      this.#invokerBeingClicked = true
      return
    }

    if (event.type === 'mousedown') {
      // Prevent safari bug that dismisses menu on mousedown instead of allowing
      // the click event to propagate to the button
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

    if (event.type === 'include-fragment-replaced') {
      this.#handleIncludeFragmentReplaced()
    } else if (event.type === 'itemActivated') {
      this.#handleItemActivated((event as CustomEvent<ItemActivatedEvent>).detail.item)
    } else if (event.type === 'dialogItemActivated') {
      this.#handleDialogItemActivated((event as CustomEvent<DialogItemActivatedEvent>).detail.dialog)
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

  #handleDialogItemActivated(dialog: HTMLElement) {
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
    // a modal <dialog> element will close all popovers
    setTimeout(() => this.#show(), 0)
    dialog.addEventListener('close', handleDialogClose, {signal})
    dialog.addEventListener('cancel', handleDialogClose, {signal})
  }

  #handleItemActivated(item: HTMLElement) {
    if (this.#hasSingleSelectBehavior) {
      for (const list of this.lists) {
        for (const possiblyCheckedItem of list.items) {
          if (possiblyCheckedItem !== item) {
            list.uncheckItem(possiblyCheckedItem)
          }
        }
      }

      this.#setDynamicLabel()
    }

    if (!this.#hasMultiSelectBehavior) {
      this.#hide()
    }
  }

  #handleIncludeFragmentReplaced() {
    if (this.#firstItem) this.#firstItem.focus()

    for (const list of this.lists) {
      list.softDisableItems()
    }
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

  get #firstItem(): HTMLElement | null {
    return this.querySelector('.ActionListContent')
  }

  getItemById(itemId: string): HTMLElement | null {
    for (const list of this.lists) {
      const item = list.getItemById(itemId)
      if (item) return item
    }

    return null
  }

  get #hasMultiSelectBehavior(): boolean {
    return this.selectVariant === 'multiple' || this.selectVariant === 'multiple_checkbox'
  }

  get #hasSingleSelectBehavior(): boolean {
    return this.selectVariant === 'single'
  }

  isItemDisabled(item: Element | null): boolean {
    return this.#findListFor(item)?.isItemDisabled(item) || false
  }

  disableItem(item: Element | null) {
    this.#findListFor(item)?.disableItem(item)
  }

  enableItem(item: Element | null) {
    this.#findListFor(item)?.enableItem(item)
  }

  isItemHidden(item: Element | null): boolean {
    return this.#findListFor(item)?.isItemHidden(item) || false
  }

  hideItem(item: Element | null) {
    this.#findListFor(item)?.hideItem(item)
  }

  showItem(item: Element | null) {
    this.#findListFor(item)?.showItem(item)
  }

  isItemChecked(item: Element | null) {
    return this.#findListFor(item)?.isItemChecked(item)
  }

  checkItem(item: Element | null) {
    this.#findListFor(item)?.checkItem(item)
  }

  uncheckItem(item: Element | null) {
    this.#findListFor(item)?.uncheckItem(item)
  }

  #findListFor(item: Element | null) {
    if (!item) return null

    for (const list of this.lists) {
      if (list.items.indexOf(item as HTMLElement) > -1) {
        return list
      }
    }

    return null
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
