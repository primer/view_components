import {controller, target} from '@github/catalyst'

const SUBMIT_BUTTON_SELECTOR = 'input[type=submit],button[type=submit],button[data-submit-dialog-id]'

@controller
class DangerDialogFormHelperElement extends HTMLElement {
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
    DangerDialogFormHelperElement: typeof DangerDialogFormHelperElement
  }
}

if (!window.customElements.get('danger-dialog-form-helper')) {
  window.DangerDialogFormHelperElement = DangerDialogFormHelperElement
  window.customElements.define('danger-dialog-form-helper', DangerDialogFormHelperElement)
}
