import {controller, target} from '@github/catalyst'

const SUBMIT_BUTTON_SELECTOR = 'input[type=submit],button[type=submit],button[data-submit-dialog-id]'

@controller
class DangerConfirmationDialogFormHelperElement extends HTMLElement {
  @target checkbox: HTMLInputElement

  get submitButton() {
    return this.querySelector<HTMLInputElement | HTMLButtonElement>(SUBMIT_BUTTON_SELECTOR)!
  }

  connectedCallback() {
    this.#reset()
  }

  toggle(): void {
    this.submitButton.disabled = !this.checkbox.checked
  }

  #reset(): void {
    this.checkbox.checked = false
    this.toggle()
  }
}

declare global {
  interface Window {
    DangerConfirmationDialogFormHelperElement: typeof DangerConfirmationDialogFormHelperElement
  }
}

if (!window.customElements.get('danger-confirmation-dialog-form-helper')) {
  window.DangerConfirmationDialogFormHelperElement = DangerConfirmationDialogFormHelperElement
  window.customElements.define('danger-confirmation-dialog-form-helper', DangerConfirmationDialogFormHelperElement)
}
