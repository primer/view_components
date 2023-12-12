function dialogInvokerButtonHandler(event: Event) {
  const target = event.target as HTMLElement
  const button = target?.closest('button')

  if (!button || button.hasAttribute('disabled') || button.getAttribute('aria-disabled') === 'true') return

  // If the user is clicking a valid dialog trigger
  let dialogId = button?.getAttribute('data-show-dialog-id')
  if (dialogId) {
    event.stopPropagation()
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof HTMLDialogElement) {
      dialog.showModal()
      // A buttons default behaviour in some browsers it to send a pointer event
      // If the behaviour is allowed through the dialog will be shown but then
      // quickly hidden- as if it were never shown. This prevents that.
      event.preventDefault()
    }
  }

  dialogId = button.getAttribute('data-close-dialog-id') || button.getAttribute('data-submit-dialog-id')
  if (dialogId) {
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof HTMLDialogElement && dialog.open) {
      dialog.close()
    }
  }
}

export class DialogHelperElement extends HTMLElement {
  get dialog() {
    return this.querySelector('dialog')
  }

  #abortController: AbortController | null = null
  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    document.addEventListener('click', dialogInvokerButtonHandler)
    document.addEventListener('click', this, {signal})
  }

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  handleEvent(event: MouseEvent) {
    const target = event.target as HTMLElement
    const dialog = this.dialog
    if (!dialog?.open) return
    if (target?.closest('dialog') !== dialog) return

    const rect = dialog.getBoundingClientRect()
    const clickWasInsideDialog =
      rect.top <= event.clientY &&
      event.clientY <= rect.top + rect.height &&
      rect.left <= event.clientX &&
      event.clientX <= rect.left + rect.width

    if (!clickWasInsideDialog) {
      dialog.close()
    }
  }
}

declare global {
  interface Window {
    DialogHelperElement: typeof DialogHelperElement
  }
  interface HTMLElementTagNameMap {
    'dialog-helper': DialogHelperElement
  }
}

if (!window.customElements.get('dialog-helper')) {
  window.DialogHelperElement = DialogHelperElement
  window.customElements.define('dialog-helper', DialogHelperElement)
}
