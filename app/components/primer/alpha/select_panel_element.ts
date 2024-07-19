import {getAnchoredPosition} from '@primer/behaviors'
import {controller, target} from '@github/catalyst'
import {announceFromElement, announce} from '../aria_live'
import {IncludeFragmentElement} from '@github/include-fragment-element'
import type {PrimerTextFieldElement} from 'lib/primer/forms/primer_text_field'
import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import '@oddbird/popover-polyfill'

type SelectVariant = 'none' | 'single' | 'multiple' | null
type SelectedItem = {
  label: string | null | undefined
  value: string | null | undefined
  inputName: string | null | undefined
  element: SelectPanelItem
}

const validSelectors = ['[role="option"]']
const menuItemSelectors = validSelectors.join(',')
const visibleMenuItemSelectors = validSelectors.map(selector => `:not([hidden]) > ${selector}`).join(',')

export type SelectPanelItem = HTMLLIElement

enum FetchStrategy {
  REMOTE,
  EVENTUALLY_LOCAL,
  LOCAL,
}

enum ErrorStateType {
  BODY,
  BANNER,
}

export type FilterFn = (item: SelectPanelItem, query: string) => boolean

const updateWhenVisible = (() => {
  const anchors = new Set<SelectPanelElement>()
  let resizeObserver: ResizeObserver | null = null
  function updateVisibleAnchors() {
    for (const anchor of anchors) {
      anchor.updateAnchorPosition()
    }
  }
  return (el: SelectPanelElement) => {
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('resize', updateVisibleAnchors)
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('scroll', updateVisibleAnchors)

    resizeObserver ||= new ResizeObserver(() => {
      for (const anchor of anchors) {
        anchor.updateAnchorPosition()
      }
    })
    resizeObserver.observe(el.ownerDocument.documentElement)
    el.addEventListener('dialog:close', () => {
      anchors.delete(el)
    })
    el.addEventListener('dialog:open', () => {
      anchors.add(el)
    })
  }
})()

@controller
export class SelectPanelElement extends HTMLElement {
  @target includeFragment: IncludeFragmentElement
  @target dialog: HTMLDialogElement
  @target filterInputTextField: HTMLInputElement
  @target remoteInput: HTMLElement
  @target list: HTMLElement
  @target ariaLiveContainer: HTMLElement
  @target noResults: HTMLElement
  @target fragmentErrorElement: HTMLElement
  @target bannerErrorElement: HTMLElement
  @target bodySpinner: HTMLElement

  filterFn?: FilterFn

  #dialogIntersectionObserver: IntersectionObserver
  #abortController: AbortController
  #originalLabel = ''
  #inputName = ''
  #selectedItems: Map<string, SelectedItem> = new Map()
  #loadingDelayTimeoutId: number | null = null
  #loadingAnnouncementTimeoutId: number | null = null

  get open(): boolean {
    return this.dialog.open
  }

  get selectVariant(): SelectVariant {
    return this.getAttribute('data-select-variant') as SelectVariant
  }

  get ariaSelectionType(): string {
    return this.selectVariant === 'multiple' ? 'aria-checked' : 'aria-selected'
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

  get dynamicAriaLabelPrefix(): string {
    const prefix = this.getAttribute('data-dynamic-aria-label-prefix')
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

  get invokerElement(): HTMLButtonElement | null {
    const id = this.querySelector('dialog')?.id
    if (!id) return null
    for (const el of this.querySelectorAll(`[aria-controls]`)) {
      if (el.getAttribute('aria-controls') === id) {
        return el as HTMLButtonElement
      }
    }
    return null
  }

  get closeButton(): HTMLButtonElement | null {
    return this.querySelector('button[data-close-dialog-id]')
  }

  get invokerLabel(): HTMLElement | null {
    if (!this.invokerElement) return null
    return this.invokerElement.querySelector('.Button-label')
  }

  get selectedItems(): SelectedItem[] {
    return Array.from(this.#selectedItems.values())
  }

  get align(): AnchorAlignment {
    return (this.getAttribute('anchor-align') || 'start') as AnchorAlignment
  }

  get side(): AnchorSide {
    return (this.getAttribute('anchor-side') || 'outside-bottom') as AnchorSide
  }

  updateAnchorPosition() {
    // If the selectPanel is removed from the screen on resize close the dialog
    if (this && this.offsetParent === null) {
      this.dialog.close()
    }

    if (this.invokerElement) {
      const {top, left} = getAnchoredPosition(this.dialog, this.invokerElement, {
        align: this.align,
        side: this.side,
        anchorOffset: 4,
      })
      this.dialog.style.top = `${top}px`
      this.dialog.style.left = `${left}px`
      this.dialog.style.bottom = 'auto'
      this.dialog.style.right = 'auto'
    }
  }

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mousedown', this, {signal})
    this.addEventListener('input', this, {signal})
    this.addEventListener('remote-input-success', this, {signal})
    this.addEventListener('remote-input-error', this, {signal})
    this.addEventListener('loadstart', this, {signal})
    this.#setDynamicLabel()
    this.#updateInput()
    this.#softDisableItems()
    updateWhenVisible(this)

    this.#waitForCondition(
      () => Boolean(this.remoteInput),
      () => {
        this.remoteInput.addEventListener('loadstart', this, {signal})
        this.remoteInput.addEventListener('loadend', this, {signal})
      },
    )

    this.#waitForCondition(
      () => Boolean(this.includeFragment),
      () => {
        this.includeFragment.addEventListener('include-fragment-replaced', this, {signal})
        this.includeFragment.addEventListener('error', this, {signal})
        this.includeFragment.addEventListener('loadend', this, {signal})
      },
    )

    this.#dialogIntersectionObserver = new IntersectionObserver(entries => {
      for (const entry of entries) {
        const elem = entry.target
        if (entry.isIntersecting && elem === this.dialog) {
          this.updateAnchorPosition()
        }
      }
    })

    this.#waitForCondition(
      () => Boolean(this.dialog),
      () => {
        if (this.getAttribute('data-open-on-load') === 'true') {
          this.show()
        }

        this.#dialogIntersectionObserver.observe(this.dialog)
        this.dialog.addEventListener('close', this, {signal})
      },
    )

    if (this.#fetchStrategy === FetchStrategy.LOCAL) {
      this.#waitForCondition(
        () => this.items.length > 0,
        () => {
          this.#updateItemVisibility()
          this.#updateInput()
        },
      )
    }
  }

  // Waits for condition to return true. If it returns false initially, this function creates a
  // MutationObserver that calls body() whenever the contents of the component change.
  #waitForCondition(condition: () => boolean, body: () => void) {
    if (condition()) {
      body()
    } else {
      const mutationObserver = new MutationObserver(() => {
        body()
        mutationObserver.disconnect()
      })

      mutationObserver.observe(this, {childList: true, subtree: true})
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

  // If there is an active item in single-select mode, set its tabindex to 0. Otherwise, set the
  // first visible item's tabindex to 0. All other items should have a tabindex of -1.
  #updateTabIndices() {
    let setZeroTabIndex = false

    if (this.selectVariant === 'single') {
      for (const item of this.items) {
        const itemContent = this.#getItemContent(item)
        if (!itemContent) continue

        if (!this.isItemHidden(item) && this.isItemChecked(item) && !setZeroTabIndex) {
          itemContent.setAttribute('tabindex', '0')
          setZeroTabIndex = true
        } else {
          itemContent.setAttribute('tabindex', '-1')
        }

        // <li> elements should not themselves be tabbable
        item.setAttribute('tabindex', '-1')
      }
    } else {
      for (const item of this.items) {
        const itemContent = this.#getItemContent(item)
        if (!itemContent) continue

        if (!this.isItemHidden(item) && !setZeroTabIndex) {
          setZeroTabIndex = true
        } else {
          itemContent.setAttribute('tabindex', '-1')
        }

        // <li> elements should not themselves be tabbable
        item.setAttribute('tabindex', '-1')
      }
    }

    if (!setZeroTabIndex && this.#firstItem) {
      this.#getItemContent(this.#firstItem)?.setAttribute('tabindex', '0')
    }
  }

  // returns true if activation was prevented
  #potentiallyDisallowActivation(event: Event): boolean {
    if (!this.#isActivation(event)) return false

    const item = (event.target as HTMLElement).closest(visibleMenuItemSelectors)
    if (!item) return false

    if (item.getAttribute('aria-disabled')) {
      event.preventDefault()

      // eslint-disable-next-line no-restricted-syntax
      event.stopPropagation()

      // eslint-disable-next-line no-restricted-syntax
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

  #isActivation(event: Event): boolean {
    // Some browsers fire MouseEvents (Firefox) and others fire PointerEvents (Chrome). Activating an item via
    // enter or space counterintuitively fires one of these rather than a KeyboardEvent. Since PointerEvent
    // inherits from MouseEvent, it is enough to check for MouseEvent here.
    return (event instanceof MouseEvent && event.type === 'click') || this.#isAnchorActivationViaSpace(event)
  }

  #checkSelectedItems() {
    for (const item of this.items) {
      const itemContent = this.#getItemContent(item)
      if (!itemContent) continue

      const value = itemContent.getAttribute('data-value')

      if (value) {
        if (this.#selectedItems.has(value)) {
          itemContent.setAttribute(this.ariaSelectionType, 'true')
        }
      }
    }
    this.#updateInput()
  }

  #addSelectedItem(item: SelectPanelItem) {
    const itemContent = this.#getItemContent(item)
    if (!itemContent) return

    const value = itemContent.getAttribute('data-value')

    if (value) {
      this.#selectedItems.set(value, {
        value,
        label: itemContent.querySelector('.ActionListItem-label')?.textContent?.trim(),
        inputName: itemContent.getAttribute('data-input-name'),
        element: item,
      })
    }
  }

  #removeSelectedItem(item: Element) {
    const value = item.getAttribute('data-value')

    if (value) {
      this.#selectedItems.delete(value)
    }
  }

  #setTextFieldLoadingSpinnerTimer() {
    if (this.#loadingDelayTimeoutId) clearTimeout(this.#loadingDelayTimeoutId)
    if (this.#loadingAnnouncementTimeoutId) clearTimeout(this.#loadingAnnouncementTimeoutId)

    this.#loadingAnnouncementTimeoutId = setTimeout(() => {
      announce('Loading', {element: this.ariaLiveContainer})
    }, 2000) as unknown as number

    this.#loadingDelayTimeoutId = setTimeout(() => {
      this.#filterInputTextFieldElement.showLeadingSpinner()
    }, 1000) as unknown as number
  }

  handleEvent(event: Event) {
    if (event.target === this.filterInputTextField) {
      this.#handleSearchFieldEvent(event)
      return
    }

    if (event.target === this.remoteInput) {
      this.#handleRemoteInputEvent(event)
      return
    }

    const targetIsInvoker = this.invokerElement?.contains(event.target as HTMLElement)
    const targetIsCloseButton = this.closeButton?.contains(event.target as HTMLElement)
    const eventIsActivation = this.#isActivation(event)

    if (targetIsInvoker && event.type === 'mousedown') {
      return
    }

    if (event.type === 'mousedown' && event.target instanceof HTMLInputElement) {
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
      return
    }

    if (targetIsCloseButton && eventIsActivation) {
      // hide() will automatically be called by dialog event triggered from `data-close-dialog-id`
      return
    }

    if (event.target === this.dialog && event.type === 'close') {
      this.dispatchEvent(
        new CustomEvent('panelClosed', {
          detail: {panel: this},
          bubbles: true,
        }),
      )

      return
    }

    const item = (event.target as Element).closest(visibleMenuItemSelectors)?.parentElement as
      | SelectPanelItem
      | null
      | undefined

    const targetIsItem = item !== null && item !== undefined

    if (targetIsItem && eventIsActivation) {
      if (this.#potentiallyDisallowActivation(event)) return

      const dialogInvoker = item.closest('[data-show-dialog-id]')

      if (dialogInvoker) {
        const dialog = this.ownerDocument.getElementById(dialogInvoker.getAttribute('data-show-dialog-id') || '')

        if (dialog && this.contains(dialogInvoker) && this.contains(dialog)) {
          this.#handleDialogItemActivated(event, dialog)
          return
        }
      }

      // Pressing the space key on a link will cause the page to scroll unless preventDefault() is called.
      // We then click it manually to navigate.
      if (this.#isAnchorActivationViaSpace(event)) {
        event.preventDefault()
        this.#getItemContent(item)?.click()
      }

      this.#handleItemActivated(item)

      return
    }

    if (event.type === 'click') {
      const rect = this.dialog.getBoundingClientRect()

      const clickWasInsideDialog =
        rect.top <= (event as MouseEvent).clientY &&
        (event as MouseEvent).clientY <= rect.top + rect.height &&
        rect.left <= (event as MouseEvent).clientX &&
        (event as MouseEvent).clientX <= rect.left + rect.width

      if (!clickWasInsideDialog) {
        this.hide()
      }
    }

    // The include fragment will have been removed from the DOM by the time
    // the include-fragment-replaced event has been dispatched, so we have to
    // check for the type of the event target manually, since this.includeFragment
    // will be null.
    if (event.target instanceof IncludeFragmentElement) {
      this.#handleIncludeFragmentEvent(event)
    }
  }

  #handleIncludeFragmentEvent(event: Event) {
    switch (event.type) {
      case 'include-fragment-replaced': {
        this.#updateItemVisibility()
        break
      }

      case 'loadstart': {
        this.#toggleIncludeFragmentElements(false)
        break
      }

      case 'loadend': {
        this.dispatchEvent(new CustomEvent('loadend'))
        break
      }

      case 'error': {
        this.#toggleIncludeFragmentElements(true)

        const errorElement = this.fragmentErrorElement
        // check if the errorElement is visible in the dom
        if (errorElement && !errorElement.hasAttribute('hidden')) {
          announceFromElement(errorElement, {element: this.ariaLiveContainer, assertive: true})
          return
        }

        break
      }
    }
  }

  #toggleIncludeFragmentElements(showError: boolean) {
    for (const el of this.includeFragment.querySelectorAll('[data-show-on-error]')) {
      if (el instanceof HTMLElement) el.hidden = !showError
    }
    for (const el of this.includeFragment.querySelectorAll('[data-hide-on-error]')) {
      if (el instanceof HTMLElement) el.hidden = showError
    }
  }

  #handleRemoteInputEvent(event: Event) {
    switch (event.type) {
      case 'remote-input-success': {
        this.#clearErrorState()
        this.#updateItemVisibility()
        this.#checkSelectedItems()
        break
      }

      case 'remote-input-error': {
        this.bodySpinner?.setAttribute('hidden', '')

        if (this.includeFragment || this.visibleItems.length === 0) {
          this.#setErrorState(ErrorStateType.BODY)
        } else {
          this.#setErrorState(ErrorStateType.BANNER)
        }

        break
      }

      case 'loadstart': {
        if (!this.#performFilteringLocally()) {
          this.#clearErrorState()
          this.bodySpinner?.removeAttribute('hidden')

          if (this.bodySpinner) break
          this.#setTextFieldLoadingSpinnerTimer()
        }

        break
      }

      case 'loadend': {
        this.#filterInputTextFieldElement.hideLeadingSpinner()
        if (this.#loadingAnnouncementTimeoutId) clearTimeout(this.#loadingAnnouncementTimeoutId)
        if (this.#loadingDelayTimeoutId) clearTimeout(this.#loadingDelayTimeoutId)
        this.dispatchEvent(new CustomEvent('loadend'))
        break
      }
    }
  }

  #defaultFilterFn(item: HTMLElement, query: string) {
    const text = (item.getAttribute('data-filter-string') || item.textContent || '').toLowerCase()
    return text.indexOf(query.toLowerCase()) > -1
  }

  #handleSearchFieldEvent(event: Event) {
    if (event.type === 'keydown' && (event as KeyboardEvent).key === 'ArrowDown') {
      if (this.focusableItem) {
        this.focusableItem.focus()
        event.preventDefault()
      }
    }
    if (event.type !== 'input') return

    // remote-input-element does not trigger another loadstart event if a request is
    // already in-flight, so we use the input event on the text field to reset the
    // loading spinner timer instead
    if (!this.bodySpinner && !this.#performFilteringLocally()) {
      this.#setTextFieldLoadingSpinnerTimer()
    }

    if (this.#fetchStrategy === FetchStrategy.LOCAL || this.#fetchStrategy === FetchStrategy.EVENTUALLY_LOCAL) {
      if (this.includeFragment) {
        this.includeFragment.refetch()
        return
      }

      this.#updateItemVisibility()
    }
  }

  #updateItemVisibility() {
    if (!this.list) return

    let atLeastOneResult = false

    if (this.#performFilteringLocally()) {
      const query = this.filterInputTextField?.value ?? ''
      const filter = this.filterFn || this.#defaultFilterFn

      for (const item of this.items) {
        if (filter(item, query)) {
          this.#showItem(item)
          atLeastOneResult = true
        } else {
          this.#hideItem(item)
        }
      }
    } else {
      atLeastOneResult = this.items.length > 0
    }

    this.#updateTabIndices()
    this.#maybeAnnounce()

    for (const item of this.items) {
      const itemContent = this.#getItemContent(item)
      if (!itemContent) continue

      const value = itemContent.getAttribute('data-value')

      if (value && !this.#selectedItems.has(value) && this.isItemChecked(item)) {
        this.#addSelectedItem(item)
      }
    }

    if (!this.noResults) return

    if (this.#inErrorState()) {
      this.noResults.setAttribute('hidden', '')
      return
    }

    if (atLeastOneResult) {
      this.noResults.setAttribute('hidden', '')
      // TODO can we change this to search for `@panelId-list`
      this.list?.querySelector('.ActionListWrap')?.removeAttribute('hidden')
    } else {
      this.list?.querySelector('.ActionListWrap')?.setAttribute('hidden', '')
      this.noResults.removeAttribute('hidden')
    }
  }

  #inErrorState(): boolean {
    if (this.fragmentErrorElement && !this.fragmentErrorElement.hasAttribute('hidden')) {
      return true
    }

    return !this.bannerErrorElement.hasAttribute('hidden')
  }

  #setErrorState(type: ErrorStateType) {
    let errorElement = this.fragmentErrorElement

    if (type === ErrorStateType.BODY) {
      this.fragmentErrorElement?.removeAttribute('hidden')
      this.bannerErrorElement.setAttribute('hidden', '')
    } else {
      errorElement = this.bannerErrorElement
      this.bannerErrorElement?.removeAttribute('hidden')
      this.fragmentErrorElement?.setAttribute('hidden', '')
    }

    // check if the errorElement is visible in the dom
    if (errorElement && !errorElement.hasAttribute('hidden')) {
      announceFromElement(errorElement, {element: this.ariaLiveContainer, assertive: true})
      return
    }
  }

  #clearErrorState() {
    this.fragmentErrorElement?.setAttribute('hidden', '')
    this.bannerErrorElement.setAttribute('hidden', '')
  }

  #maybeAnnounce() {
    if (this.open && this.list) {
      const items = this.items

      if (items.length > 0) {
        const instructions = 'tab for results'
        announce(`${items.length} result${items.length === 1 ? '' : 's'} ${instructions}`, {
          element: this.ariaLiveContainer,
        })
      } else {
        const noResultsEl = this.noResults
        if (noResultsEl) {
          announceFromElement(noResultsEl, {element: this.ariaLiveContainer})
        }
      }
    }
  }

  get #fetchStrategy(): FetchStrategy {
    if (!this.list) return FetchStrategy.REMOTE

    switch (this.list.getAttribute('data-fetch-strategy')) {
      case 'local':
        return FetchStrategy.LOCAL
      case 'eventually_local':
        return FetchStrategy.EVENTUALLY_LOCAL
      default:
        return FetchStrategy.REMOTE
    }
  }

  get #filterInputTextFieldElement(): PrimerTextFieldElement {
    return this.filterInputTextField.closest('primer-text-field') as PrimerTextFieldElement
  }

  #performFilteringLocally(): boolean {
    return this.#fetchStrategy === FetchStrategy.LOCAL || this.#fetchStrategy === FetchStrategy.EVENTUALLY_LOCAL
  }

  #handleInvokerActivated(event: Event) {
    event.preventDefault()

    // eslint-disable-next-line no-restricted-syntax
    event.stopPropagation()

    if (this.open) {
      this.hide()
    } else {
      this.show()
    }
  }

  #handleDialogItemActivated(event: Event, dialog: HTMLElement) {
    this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = 'none'
    const dialog_controller = new AbortController()
    const {signal} = dialog_controller
    const handleDialogClose = () => {
      dialog_controller.abort()
      this.querySelector<HTMLElement>('.ActionListWrap')!.style.display = ''
      if (this.open) {
        this.hide()
      }
      const activeElement = this.ownerDocument.activeElement
      const lostFocus = this.ownerDocument.activeElement === this.ownerDocument.body
      const focusInClosedMenu = this.contains(activeElement)
      if (lostFocus || focusInClosedMenu) {
        setTimeout(() => this.invokerElement?.focus(), 0)
      }
    }
    // a modal <dialog> element will close all popovers
    dialog.addEventListener('close', handleDialogClose, {signal})
    dialog.addEventListener('cancel', handleDialogClose, {signal})
  }

  #handleItemActivated(item: SelectPanelItem) {
    // Hide popover after current event loop to prevent changes in focus from
    // altering the target of the event. Not doing this specifically affects
    // <a> tags. It causes the event to be sent to the currently focused element
    // instead of the anchor, which effectively prevents navigation, i.e. it
    // appears as if hitting enter does nothing. Curiously, clicking instead
    // works fine.
    if (this.selectVariant !== 'multiple') {
      setTimeout(() => {
        if (this.open) {
          this.hide()
        }
      })
    }

    // The rest of the code below deals with single/multiple selection behavior, and should not
    // interfere with events fired by menu items whose behavior is specified outside the library.
    if (this.selectVariant !== 'multiple' && this.selectVariant !== 'single') return

    const checked = !this.isItemChecked(item)

    const activationSuccess = this.dispatchEvent(
      new CustomEvent('beforeItemActivated', {
        bubbles: true,
        detail: {item, checked},
        cancelable: true,
      }),
    )

    if (!activationSuccess) return

    const itemContent = this.#getItemContent(item)

    if (this.selectVariant === 'single') {
      // Only check, never uncheck here. Single-select mode does not allow unchecking a checked item.
      if (checked) {
        this.#addSelectedItem(item)
        itemContent?.setAttribute(this.ariaSelectionType, 'true')
      }

      for (const checkedItem of this.querySelectorAll(`[${this.ariaSelectionType}]`)) {
        if (checkedItem !== itemContent) {
          this.#removeSelectedItem(checkedItem)
          checkedItem.setAttribute(this.ariaSelectionType, 'false')
        }
      }

      this.#setDynamicLabel()
    } else {
      // multi-select mode allows unchecking a checked item
      itemContent?.setAttribute(this.ariaSelectionType, `${checked}`)

      if (checked) {
        this.#addSelectedItem(item)
      } else {
        this.#removeSelectedItem(item)
      }
    }

    this.#updateInput()
    this.#updateTabIndices()

    this.dispatchEvent(
      new CustomEvent('itemActivated', {
        bubbles: true,
        detail: {item, checked},
      }),
    )
  }

  show() {
    this.updateAnchorPosition()
    this.dialog.showModal()
    const event = new CustomEvent('dialog:open', {
      detail: {dialog: this.dialog},
    })
    this.dispatchEvent(event)
  }

  hide() {
    this.dialog.close()
  }

  #setDynamicLabel() {
    if (!this.dynamicLabel) return
    const invokerLabel = this.invokerLabel
    if (!invokerLabel) return
    this.#originalLabel ||= invokerLabel.textContent || ''
    const itemLabel =
      this.querySelector(`[${this.ariaSelectionType}=true] .ActionListItem-label`)?.textContent || this.#originalLabel
    if (itemLabel) {
      const prefixSpan = document.createElement('span')
      prefixSpan.classList.add('color-fg-muted')
      const contentSpan = document.createElement('span')
      prefixSpan.textContent = `${this.dynamicLabelPrefix} `
      contentSpan.textContent = itemLabel
      invokerLabel.replaceChildren(prefixSpan, contentSpan)

      if (this.dynamicAriaLabelPrefix) {
        this.invokerElement?.setAttribute('aria-label', `${this.dynamicAriaLabelPrefix} ${itemLabel.trim()}`)
      }
    } else {
      invokerLabel.textContent = this.#originalLabel
    }
  }

  #updateInput() {
    if (this.selectVariant === 'single') {
      const input = this.querySelector(`[data-list-inputs=true] input`) as HTMLInputElement
      if (!input) return

      const selectedItem = this.selectedItems[0]

      if (selectedItem) {
        input.value = (selectedItem.value || selectedItem.label || '').trim()
        if (selectedItem.inputName) input.name = selectedItem.inputName
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
        newInput.name = selectedItem.inputName || this.#inputName
        newInput.value = (selectedItem.value || selectedItem.label || '').trim()

        inputList.append(newInput)
      }

      for (const input of inputs) {
        input.remove()
      }
    }
  }

  get #firstItem(): SelectPanelItem | null {
    return (this.querySelector(visibleMenuItemSelectors)?.parentElement || null) as SelectPanelItem | null
  }

  get visibleItems(): SelectPanelItem[] {
    return Array.from(this.querySelectorAll(visibleMenuItemSelectors)).map(
      element => element.parentElement! as SelectPanelItem,
    )
  }

  get items(): SelectPanelItem[] {
    return Array.from(this.querySelectorAll(menuItemSelectors)).map(
      element => element.parentElement! as SelectPanelItem,
    )
  }
  get focusableItem(): HTMLElement | undefined {
    for (const item of this.items) {
      const itemContent = this.#getItemContent(item)
      if (!itemContent) continue
      if (itemContent.getAttribute('tabindex') === '0') {
        return itemContent
      }
    }
  }

  getItemById(itemId: string): SelectPanelItem | null {
    return this.querySelector(`li[data-item-id="${itemId}"`)
  }

  isItemDisabled(item: SelectPanelItem | null): boolean {
    if (item) {
      return item.classList.contains('ActionListItem--disabled')
    } else {
      return false
    }
  }

  disableItem(item: SelectPanelItem | null) {
    if (item) {
      item.classList.add('ActionListItem--disabled')
      this.#getItemContent(item)!.setAttribute('aria-disabled', 'true')
    }
  }

  enableItem(item: SelectPanelItem | null) {
    if (item) {
      item.classList.remove('ActionListItem--disabled')
      this.#getItemContent(item)!.removeAttribute('aria-disabled')
    }
  }

  isItemHidden(item: SelectPanelItem | null): boolean {
    if (item) {
      return item.hasAttribute('hidden')
    } else {
      return false
    }
  }

  #hideItem(item: SelectPanelItem | null) {
    if (item) {
      item.setAttribute('hidden', 'hidden')
    }
  }

  #showItem(item: SelectPanelItem | null) {
    if (item) {
      item.removeAttribute('hidden')
    }
  }

  isItemChecked(item: SelectPanelItem | null) {
    if (item) {
      return this.#getItemContent(item)!.getAttribute(this.ariaSelectionType) === 'true'
    } else {
      return false
    }
  }

  checkItem(item: SelectPanelItem | null) {
    if (item && (this.selectVariant === 'single' || this.selectVariant === 'multiple')) {
      if (!this.isItemChecked(item)) {
        this.#handleItemActivated(item)
      }
    }
  }

  uncheckItem(item: SelectPanelItem | null) {
    if (item && (this.selectVariant === 'single' || this.selectVariant === 'multiple')) {
      if (this.isItemChecked(item)) {
        this.#handleItemActivated(item)
      }
    }
  }

  #getItemContent(item: SelectPanelItem): HTMLElement | null {
    return item.querySelector('.ActionListContent')
  }
}

if (!window.customElements.get('select-panel')) {
  window.SelectPanelElement = SelectPanelElement
  window.customElements.define('select-panel', SelectPanelElement)
}

declare global {
  interface Window {
    SelectPanelElement: typeof SelectPanelElement
  }
}
