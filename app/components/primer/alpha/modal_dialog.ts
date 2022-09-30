import {focusTrap} from '@primer/behaviors'
import {getFocusableChild} from '@primer/behaviors/utils'

function focusIfNeeded(elem?: HTMLElement) {
  if (document.activeElement !== elem) {
    elem?.focus()
  }
}

export class ModalDialogElement extends HTMLElement {
  //TODO: Do we remove the abortController from focusTrap?
  #focusAbortController = new AbortController()
  #abortController: AbortController | null = null
  #openButton: HTMLButtonElement | undefined
  #shouldTryLoadingFragment = true

  get open() {
    return this.hasAttribute('open')
  }
  set open(value: boolean) {
    if (value) {
      if (this.open) return
      this.setAttribute('open', '')
      this.#overlayBackdrop?.classList.remove('Overlay--hidden')
      document.body.style.overflow = 'hidden'
      if (this.#focusAbortController.signal.aborted) {
        this.#focusAbortController = new AbortController()
      }
      focusTrap(this, undefined, this.#focusAbortController.signal)
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.#overlayBackdrop?.classList.add('Overlay--hidden')
      document.body.style.overflow = 'initial'
      this.#focusAbortController.abort()
      // if #openButton is a child of a menu, we need to focus a suitable child of the menu
      // element since it is expected for the menu to close on click
      const menu = this.#openButton?.closest('details') || this.#openButton?.closest('action-menu')
      if (menu) {
        focusIfNeeded(getFocusableChild(menu))
      } else {
        focusIfNeeded(this.#openButton)
      }
      this.#openButton = undefined
    }
  }

  get #overlayBackdrop(): HTMLElement | null {
    if (this.parentElement?.hasAttribute('data-modal-dialog-overlay')) {
      return this.parentElement
    }

    return null
  }

  get showButtons(): NodeList {
    // Dialogs may also be opened from any arbitrary button with a matching show-dialog-id data attribute
    return document.querySelectorAll(`button[data-show-dialog-id='${this.id}']`)
  }

  connectedCallback(): void {
    if (!this.hasAttribute('role')) this.setAttribute('role', 'dialog')

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

        let dialogId = button.getAttribute('data-close-dialog-id')
        if (dialogId === this.id) {
          this.close()
        }

        dialogId = button.getAttribute('data-submit-dialog-id')
        if (dialogId === this.id) {
          this.close(true)
        }

        dialogId = button.getAttribute('data-show-dialog-id')
        if (dialogId === this.id) {
          event.stopPropagation()
          this.#openButton = button
          this.show()
        }
      },
      {signal}
    )

    this.addEventListener('keydown', e => this.#keydown(e))
  }

  disconnectedCallback(): void {
    this.#abortController?.abort()
  }

  show() {
    this.open = true
  }

  close(closedNotCancelled = false) {
    if (this.open === false) return
    const eventType = closedNotCancelled ? 'close' : 'cancel'
    const dialogEvent = new Event(eventType)
    this.dispatchEvent(dialogEvent)
    this.open = false
  }

  #keydown(event: Event) {
    if (!(event instanceof KeyboardEvent)) return
    if (event.isComposing) return

    switch (event.key) {
      case 'Escape':
        if (this.open) {
          this.close()
          event.preventDefault()
          event.stopPropagation()
        }
        break
    }
  }
}

declare global {
  interface Window {
    ModalDialogElement: typeof ModalDialogElement
  }
  interface HTMLElementTagNameMap {
    'modal-dialog': ModalDialogElement
  }
}

if (!window.customElements.get('modal-dialog')) {
  window.ModalDialogElement = ModalDialogElement
  window.customElements.define('modal-dialog', ModalDialogElement)
}
