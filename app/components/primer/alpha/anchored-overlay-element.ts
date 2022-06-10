import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

// <anchored-overlay open data-anchor-align="start" data-anchor-side="outside-bottom">

class AnchoredOverlayElement extends HTMLElement {
  #abortController: AbortController
  #openButton: HTMLButtonElement | undefined

  get anchorAlign(): AnchorAlignment {
    return (this.getAttribute('data-anchor-align') || 'start') as AnchorAlignment
  }

  get anchorSide(): AnchorSide {
    return (this.getAttribute('data-anchor-side') || 'outside-bottom') as AnchorSide
  }

  // use data attribute
  get trigger(): HTMLButtonElement | null {
    return this.querySelector<HTMLButtonElement>('button')
  }

  // get overlay(): HTMLDivElement | null {
  //   return this.querySelector<HTMLDivElement>('.Overlay')
  // }

  get open() {
    return this.hasAttribute('open')
  }

  // open: true
  // - set the position
  // - remove Overlay--visibilityHidden
  //
  // open: false
  // - set Overlay--visibilityHidden
  set open(value: boolean) {
    const initialBodyWidth = document.body.clientWidth
    const observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (initialBodyWidth !== entry.contentRect.width && this.open) {
          this.#updatePosition()
        }
      }
    })

    if (value) {
      if (this.open) return
      //   if (!this.trigger) return
      this.setAttribute('open', '')

      this.#updatePosition()
      // If the window width is changed when the menu is open,
      // this keeps the menu aligned to the button
      observer.observe(document.body)
      this.setAttribute('open', '')
      this.classList.remove('Overlay--visibilityHidden')
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.classList.add('Overlay--visibilityHidden')
      observer.unobserve(document.body)

      // TODO: Do this without a setTimeout
      setTimeout(() => {
        // There are some actions that may move focus to another part of the page intentionally.
        // For example: "Quote Reply" in the comment options moves focus to the comment box.
        // This only moves focus to the trigger if it's not managed in another way.
        if (document.activeElement === document.body) this.trigger?.focus()
      }, 1)
    }
  }

  connectedCallback() {
    if (!this.trigger) return
    const {signal} = (this.#abortController = new AbortController())

    this.ownerDocument.addEventListener(
      'click',
      event => {
        const target = event.target as HTMLElement
        const clickOutsideDialog = target.closest(this.tagName) !== this
        const button = target?.closest('button')
        // go over this logic:
        if (!button) {
          if (clickOutsideDialog) {
            // This click is outside the dialog
            this.close()
          }
          return
        }

        let dialogId = button.getAttribute('data-close-overlay-id')
        if (dialogId === this.id) {
          this.close()
        }

        dialogId = button.getAttribute('data-submit-overlay-id')
        if (dialogId === this.id) {
          this.close(true)
        }

        dialogId = button.getAttribute('data-show-overlay-id')
        if (dialogId === this.id) {
          //TODO: see if I can remove this
          event.stopPropagation()
          //   this.#openButton = button
          this.show()
        }
      },
      {signal}
    )

    // this.addEventListener('keydown', e => this.#keydown(e))
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  show() {
    this.open = true
  }

  close(closed = false) {
    const eventType = closed ? 'close' : 'cancel'
    const dialogEvent = new Event(eventType)
    this.dispatchEvent(dialogEvent)
    this.open = false
  }

  hide() {
    this.open = false
  }

  // #addEvents() {
  //   this.#abortController = new AbortController()
  //   const {signal} = this.#abortController

  //   if (!this.trigger) return

  //   // this.trigger.addEventListener('keydown', this.buttonKeydown.bind(this), {signal})
  //   // this.trigger.addEventListener('click', this.buttonClick.bind(this), {signal})
  // }

  #updatePosition() {
    if (!this.trigger) return

    const float = this.querySelector<HTMLElement>('[data-menu-overlay]')
    const anchor = this.trigger
    // const {top, left} = getAnchoredPosition(float, anchor, {side: this.anchorSide, align: this.anchorAlign})

    // float.style.top = `${top}px`
    // float.style.left = `${left}px`
  }
}

if (!window.customElements.get('anchored-overlay')) {
  window.AnchoredOverlayElement = AnchoredOverlayElement
  window.customElements.define('anchored-overlay', AnchoredOverlayElement)
}

declare global {
  interface Window {
    AnchoredOverlayElement: typeof AnchoredOverlayElement
  }
}
