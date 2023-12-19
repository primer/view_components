import {focusTrap} from '@primer/behaviors'
import {getFocusableChild} from '@primer/behaviors/utils'

function focusIfNeeded(elem: HTMLElement | undefined | null) {
  if (document.activeElement !== elem) {
    elem?.focus()
  }
}

const overlayStack: ModalDialogElement[] = []

function clickHandler(event: Event) {
  const target = event.target as HTMLElement
  const button = target?.closest('button')

  if (!button || button.hasAttribute('disabled') || button.getAttribute('aria-disabled') === 'true') return

  // If the user is clicking a valid dialog trigger
  let dialogId = button?.getAttribute('data-show-dialog-id')
  if (dialogId) {
    event.stopPropagation()
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof ModalDialogElement) {
      dialog.openButton = button
      dialog.show()
      // A buttons default behaviour in some browsers it to send a pointer event
      // If the behaviour is allowed through the dialog will be shown but then
      // quickly hidden- as if it were never shown. This prevents that.
      event.preventDefault()
      return
    }
  }

  if (!overlayStack.length) return

  dialogId = button.getAttribute('data-close-dialog-id') || button.getAttribute('data-submit-dialog-id')
  if (dialogId) {
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof ModalDialogElement) {
      const dialogIndex = overlayStack.findIndex(ele => ele.id === dialogId)
      overlayStack.splice(dialogIndex, 1)
      dialog.close(button.hasAttribute('data-submit-dialog-id'))
    }
  }
}

function keydownHandler(event: Event) {
  if (
    !(event instanceof KeyboardEvent) ||
    event.type !== 'keydown' ||
    event.key !== 'Enter' ||
    event.ctrlKey ||
    event.altKey ||
    event.metaKey ||
    event.shiftKey
  )
    return

  clickHandler(event)
}

function mousedownHandler(event: Event) {
  const target = event.target as HTMLElement
  if (target?.closest('button')) return

  // Find the top level dialog that is open.
  const topLevelDialog = overlayStack[overlayStack.length - 1]
  if (!topLevelDialog) return

  // Check if the mousedown happened outside the boundary of the top level dialog
  const mouseDownOutsideDialog = !target.closest(`#${topLevelDialog.getAttribute('id')}`)

  // Only close dialog if it's a click outside the dialog and the dialog has a button?
  if (mouseDownOutsideDialog) {
    target.ownerDocument.addEventListener(
      'mouseup',
      (upEvent: Event) => {
        if (upEvent.target === target) {
          overlayStack.pop()
          topLevelDialog.close()
        }
      },
      {once: true},
    )
  }
}

export class ModalDialogElement extends HTMLElement {
  //TODO: Do we remove the abortController from focusTrap?
  #focusAbortController = new AbortController()
  openButton: HTMLButtonElement | null

  get open() {
    return this.hasAttribute('open')
  }
  set open(value: boolean) {
    if (value) {
      if (this.open) return
      this.setAttribute('open', '')
      this.setAttribute('aria-disabled', 'false')
      document.body.style.paddingRight = `${window.innerWidth - document.body.clientWidth}px`
      document.body.style.overflow = 'hidden'
      this.#overlayBackdrop?.classList.remove('Overlay--hidden')
      if (this.#focusAbortController.signal.aborted) {
        this.#focusAbortController = new AbortController()
      }
      focusTrap(this, this.querySelector('[autofocus]') as HTMLElement, this.#focusAbortController.signal)
      overlayStack.push(this)
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.setAttribute('aria-disabled', 'true')
      this.#overlayBackdrop?.classList.add('Overlay--hidden')
      document.body.style.paddingRight = '0'
      document.body.style.overflow = 'initial'
      this.#focusAbortController.abort()
      // if #openButton is a child of a menu, we need to focus a suitable child of the menu
      // element since it is expected for the menu to close on click
      const menu = this.openButton?.closest('details') || this.openButton?.closest('action-menu')
      if (menu) {
        focusIfNeeded(getFocusableChild(menu))
      } else {
        focusIfNeeded(this.openButton)
      }
      this.openButton = null
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

    document.addEventListener('click', clickHandler)
    document.addEventListener('keydown', keydownHandler)
    document.addEventListener('mousedown', mousedownHandler)

    this.addEventListener('keydown', e => this.#keydown(e))
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
    if (!this.open) return

    switch (event.key) {
      case 'Escape':
        this.close()
        event.preventDefault()
        event.stopPropagation()
        break
      case 'Enter': {
        const target = event.target as HTMLElement

        if (target.getAttribute('data-close-dialog-id') === this.id) {
          event.stopPropagation()
        }
        break
      }
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
