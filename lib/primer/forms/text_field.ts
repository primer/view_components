import '@github/auto-check-element'
import {controller, target} from '@github/catalyst'

@controller
class TextFieldElement extends HTMLElement { // TODO: have a less generic tag name than <text-field>
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
    TextFieldElement: typeof TextFieldElement
  }
}

if (!window.customElements.get('text-field')) {
  Object.assign(window, {TextFieldElement})
  window.customElements.define('text-field', TextFieldElement)
}
