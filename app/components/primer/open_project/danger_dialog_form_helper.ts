import {controller, target} from '@github/catalyst'

const SUBMIT_BUTTON_SELECTOR = 'input[type=submit],button[type=submit],button[data-submit-dialog-id]'

@controller
class DangerDialogFormHelperElement extends HTMLElement {
  @target checkbox: HTMLInputElement | undefined

  get form() {
    return this.querySelector('form')
  }

  get submitButton() {
    return this.querySelector<HTMLInputElement | HTMLButtonElement>(SUBMIT_BUTTON_SELECTOR)!
  }

  connectedCallback() {
    // makes the custom element behave as if it doesn't exist in the DOM structure, passing all
    // styles directly to its children.
    this.style.display = 'contents'
    if (this.form) {
      this.form.style.display = 'contents'
    }
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
