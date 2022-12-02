import '@github/auto-check-element'
import {controller, target} from '@github/catalyst'

@controller
class PrimerTextFieldElement extends HTMLElement {
  @target inputElement: HTMLInputElement
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement

  connectedCallback(): void {
    this.inputElement.addEventListener('auto-check-success', () => { this.clearError() })

    this.inputElement.addEventListener('auto-check-error', (event: any) => {
      event.detail.response.text().then((error_message: string) => {
        this.setError(error_message)
      })
    })
  }

  clearError(): void {
    this.inputElement.removeAttribute('invalid')
    this.validationElement.hidden = true
    this.validationMessageElement.innerText = ''
  }

  setError(message: string): void {
    this.validationMessageElement.innerText = message
    this.validationElement.hidden = false
    this.inputElement.setAttribute('invalid', 'true')
  }
}

declare global {
  interface Window {
    PrimerTextFieldElement: typeof PrimerTextFieldElement
  }
}

if (!window.customElements.get('primer-text-field')) {
  Object.assign(window, {PrimerTextFieldElement})
  window.customElements.define('primer-text-field', PrimerTextFieldElement)
}
