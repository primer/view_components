import {controller, target} from '@github/catalyst'
import '@oddbird/popover-polyfill'
import type {IncludeFragmentElement} from '@github/include-fragment-element'
import AnchoredPositionElement from '../../anchored_position'
import {observeMutationsUntilConditionMet} from '../../utils'
import {ActionMenuFocusZoneStack} from './action_menu_focus_zone_stack'
import {ClipboardCopyElement} from '@github/clipboard-copy-element'

type SelectVariant = 'none' | 'single' | 'multiple' | null
type SelectedItem = {
  label: string | null | undefined
  value: string | null | undefined
  element: Element
}

@controller
export class ActionMenuElement extends HTMLElement {
  @target includeFragment: IncludeFragmentElement
  @target overlay: AnchoredPositionElement
  @target list: HTMLElement

  #abortController: AbortController
  #originalLabel = ''
  #inputName = ''
  #invokerBeingClicked = false
  #intersectionObserver: IntersectionObserver
  #focusZoneStack: ActionMenuFocusZoneStack

  static validItemRoles = ['menuitem', 'menuitemcheckbox', 'menuitemradio']
  static validSelectors = ActionMenuElement.validItemRoles.map(role => `[role="${role}"]`)
  static menuItemSelectors = ActionMenuElement.validSelectors.map(selector => `:not([hidden]) > ${selector}`)

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

  // i.e. sub-menus
  get childPopoverElements(): HTMLElement[] {
    return Array.from(this.overlay.querySelectorAll('anchored-position')) as AnchoredPositionElement[]
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
    this.addEventListener('toggle', this, {signal, capture: true})
    this.#setDynamicLabel()
    this.#updateInput()
    this.#softDisableItems()

    if (this.includeFragment) {
      this.includeFragment.addEventListener('include-fragment-replaced', this, {
        signal,
      })
    }

    // The code below updates the menu (i.e. overlay) position whenever the invoker button
    // changes position within its scroll container.
    //
    // See: https://github.com/primer/view_components/issues/3175

    const scrollUpdater = () => {
      if (this.#isOpen()) {
        this.overlay?.update()
      }
    }

    this.#intersectionObserver = new IntersectionObserver(entries => {
      for (const entry of entries) {
        const elem = entry.target
        if (elem === this.invokerElement) {
          if (entry.isIntersecting) {
            // eslint-disable-next-line github/prefer-observers
            window.addEventListener('scroll', scrollUpdater, {capture: true})
          } else {
            window.removeEventListener('scroll', scrollUpdater, {capture: true})
          }
        }
      }
    })

    observeMutationsUntilConditionMet(
      this,
      () => Boolean(this.invokerElement),
      () => this.#intersectionObserver.observe(this.invokerElement!),
    )

    // If there's no include fragment, then no async fetching will occur and we can
    // mark the component as ready.
    if (!this.includeFragment) {
      this.setAttribute('data-ready', 'true')
    }

    const levelObserver = new MutationObserver(() => this.#updateLevels())
    levelObserver.observe(this, {childList: true, subtree: true})

    this.#updateLevels()

    this.#focusZoneStack = new ActionMenuFocusZoneStack()
  }

  #updateLevels() {
    let idx = 1

    for (const menu of this.querySelectorAll('[role=menu]')) {
      menu.setAttribute('data-level', idx.toString())
      idx++
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  #softDisableItems() {
    const {signal} = this.#abortController

    for (const item of this.querySelectorAll(ActionMenuElement.validSelectors.join(','))) {
      item.addEventListener('click', this.#potentiallyDisallowActivation.bind(this), {signal})
      item.addEventListener('keydown', this.#potentiallyDisallowActivation.bind(this), {signal})
    }
  }

  // returns true if activation was prevented
  #potentiallyDisallowActivation(event: Event): boolean {
    if (!this.#isActivation(event)) return false

    const item = (event.target as HTMLElement).closest(ActionMenuElement.menuItemSelectors.join(','))
    if (!item) return false

    if (item.getAttribute('aria-disabled')) {
      event.preventDefault()
      /* eslint-disable-next-line no-restricted-syntax */
      event.stopPropagation()
      /* eslint-disable-next-line no-restricted-syntax */
      event.stopImmediatePropagation()
      return true
    }

    return false
  }

  #isAnchorActivationViaSpace(event: Event): boolean {
    return (
      event.target instanceof HTMLAnchorElement &&
      event instanceof KeyboardEvent &&
      event.type === 'keydown' &&
      !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
      event.key === ' '
    )
  }

  #isClipboardActivationViaKeyboard(event: Event): boolean {
    return (
      event.target instanceof ClipboardCopyElement &&
      event instanceof KeyboardEvent &&
      event.type === 'keydown' &&
      !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
      (event.key === ' ' || event.key === 'Enter')
    )
  }

  #isActivation(event: Event): boolean {
    // Some browsers fire MouseEvents (Firefox) and others fire PointerEvents (Chrome). Activating an item via
    // enter or space counterintuitively fires one of these rather than a KeyboardEvent. Since PointerEvent
    // inherits from MouseEvent, it is enough to check for MouseEvent here.
    return (
      (event instanceof MouseEvent && event.type === 'click') ||
      this.#isAnchorActivationViaSpace(event) ||
      this.#isClipboardActivationViaKeyboard(event)
    )
  }

  handleEvent(event: Event) {
    const targetIsInvoker = this.invokerElement?.contains(event.target as HTMLElement)
    const eventIsActivation = this.#isActivation(event)

    if (event.type === 'toggle' && event instanceof ToggleEvent) {
      this.#handleToggleEvent(event)
      return
    }

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

    const item = (event.target as Element).closest(ActionMenuElement.menuItemSelectors.join(',')) as HTMLElement | null
    const targetIsItem = item !== null

    if (targetIsItem && eventIsActivation) {
      if (this.#potentiallyDisallowActivation(event)) return

      const dialogInvoker = item.closest('[data-show-dialog-id]')

      if (dialogInvoker) {
        const dialog = this.ownerDocument.getElementById(dialogInvoker.getAttribute('data-show-dialog-id') || '')

        if (dialog && this.contains(dialogInvoker)) {
          this.#handleDialogItemActivated(event, dialog)
          return
        }
      }

      // Pressing the space key on a link will cause the page to scroll unless preventDefault() is called.
      // We then click it manually to navigate.
      if (this.#isAnchorActivationViaSpace(event)) {
        event.preventDefault()
        item.click()
      }

      const subMenu = this.#subMenuForItem(item)

      if (subMenu) {
        // Prevent submitting a form when clicking on sub-menu items
        event.preventDefault()
        subMenu.showPopover()
        return
      }

      this.#handleItemActivated(item)

      return
    }

    if (event.type === 'include-fragment-replaced') {
      this.#handleIncludeFragmentReplaced()
      return
    }

    if (targetIsItem && event instanceof KeyboardEvent) {
      this.#handleItemKeyboardEvent(event, item)
    }
  }

  #handleItemKeyboardEvent(event: KeyboardEvent, item: HTMLElement) {
    switch (event.key) {
      case 'ArrowRight': {
        const subMenu = this.#subMenuForItem(item)
        subMenu?.showPopover()
        break
      }

      case 'ArrowLeft':
        if (item.closest('role[menu]') !== this.list) {
          const overlay = item.closest('anchored-position') as AnchoredPositionElement | null
          overlay?.hidePopover()
        }

        break
    }
  }

  #handleToggleEvent(event: ToggleEvent) {
    const subMenu = event.target as AnchoredPositionElement

    if (event.newState === 'open') {
      // allow tabbing away from primary menu, but trap focus in sub-menus
      const isPrimaryMenu = subMenu === this.overlay
      this.#focusZoneStack.push(subMenu, {trapFocus: !isPrimaryMenu})

      window.requestAnimationFrame(() => {
        const firstItem = subMenu.querySelector(ActionMenuElement.menuItemSelectors.join(',')) as HTMLElement | null
        firstItem?.focus()
      })
    } else {
      // Note that this will also cause focus to return to the invoker button, which is
      // desirable
      this.#focusZoneStack.pop(subMenu)
      const item = this.#itemForSubMenu(subMenu)
      if (item) item.focus()
    }
  }

  #handleInvokerActivated(event: Event) {
    event.preventDefault()
    /* eslint-disable-next-line no-restricted-syntax */
    event.stopPropagation()

    if (this.#isOpen()) {
      this.#hide()
    } else {
      this.#show()
    }
  }

  #handleDialogItemActivated(event: Event, dialog: HTMLElement) {
    if (this.contains(dialog)) {
      this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = 'none'
    }
    const dialog_controller = new AbortController()
    const {signal} = dialog_controller
    const handleDialogClose = () => {
      dialog_controller.abort()
      if (this.contains(dialog)) {
        this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = ''
        if (this.#isOpen()) {
          this.#hide()
        }
      }
      const activeElement = this.ownerDocument.activeElement
      const lostFocus = this.ownerDocument.activeElement === this.ownerDocument.body
      const focusInClosedMenu = this.contains(activeElement)
      const focusInDialog = dialog.contains(activeElement)
      if (lostFocus || focusInClosedMenu || focusInDialog) {
        setTimeout(() => {
          // if the activeElement has changed after a task, then it's likely
          // that other JS has tried to shift focus. We should respect that
          // focus shift as long as it's not back at the document.
          const newActiveElement = this.ownerDocument.activeElement
          if (newActiveElement === activeElement || newActiveElement === this.ownerDocument.body) {
            this.invokerElement?.focus()
          }
        }, 0)
      }
    }
    // a modal <dialog> element will close all popovers
    dialog.addEventListener('close', handleDialogClose, {signal})
    dialog.addEventListener('cancel', handleDialogClose, {signal})
  }

  #handleItemActivated(item: HTMLElement) {
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
        bubbles: true,
        detail: {item: item.parentElement, checked: this.isItemChecked(item.parentElement)},
      }),
    )
  }

  #handleIncludeFragmentReplaced() {
    this.#firstItem?.focus()
    this.#softDisableItems()

    // async items have loaded, so component is ready
    this.setAttribute('data-ready', 'true')
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

    for (const child of this.childPopoverElements) {
      child.hidePopover()
    }
  }

  #isOpen() {
    return this.popoverElement?.matches(':popover-open')
  }

  #setDynamicLabel() {
    if (this.selectVariant !== 'single') return
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
    return this.querySelector(ActionMenuElement.menuItemSelectors.join(','))
  }

  get items(): HTMLElement[] {
    return Array.from(this.querySelectorAll(ActionMenuElement.menuItemSelectors.join(',')))
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
      const itemContent = item.querySelector('.ActionListContent')! as HTMLElement
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (!ariaChecked) {
        this.#handleItemActivated(itemContent)
      }
    }
  }

  uncheckItem(item: Element | null) {
    if (item && (this.selectVariant === 'single' || this.selectVariant === 'multiple')) {
      const itemContent = item.querySelector('.ActionListContent')! as HTMLElement
      const ariaChecked = itemContent.getAttribute('aria-checked') === 'true'

      if (ariaChecked) {
        this.#handleItemActivated(itemContent)
      }
    }
  }

  #subMenuForItem(item: HTMLElement): AnchoredPositionElement | null {
    const popoverId = item.getAttribute('popovertarget')

    if (popoverId) {
      return this.querySelector(`[id="${popoverId}"]`) as AnchoredPositionElement
    }

    return null
  }

  #itemForSubMenu(subMenu: HTMLElement): HTMLElement | null {
    const anchorId = subMenu.getAttribute('anchor')

    if (anchorId) {
      return this.querySelector(`[id="${anchorId}"]`) as HTMLElement | null
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
