import {controller, target} from '@github/catalyst'

const SUBMIT_BUTTON_SELECTOR = 'input[type=submit],button[type=submit],button[data-submit-dialog-id]'

@controller
class DangerDialogFormHelperElement extends HTMLElement {
  @target checkbox: HTMLInputElement | undefined

  get submitButton() {
    return this.querySelector<HTMLInputElement | HTMLButtonElement>(SUBMIT_BUTTON_SELECTOR)!
  }

  connectedCallback() {
    this.style.display = 'contents'
    this.#reset()
  }

  toggle(): void {
    if (this.checkbox) {
      this.submitButton.disabled = !this.checkbox.checked
    }
  }

  #reset(): void {
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
