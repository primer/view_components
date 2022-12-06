import '@github/auto-check-element'
import {controller, target} from '@github/catalyst'

@controller
class PrimerTextFieldElement extends HTMLElement {
  @target inputElement: HTMLInputElement
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement

  #abortController: AbortController | null

  connectedCallback(): void {
    this.#abortController?.abort()
    const {signal} = (this.#abortController = new AbortController())

    this.inputElement.addEventListener(
      'auto-check-success',
      () => { this.clearError() },
      {signal}
    )

    this.inputElement.addEventListener(
      'auto-check-error',
      (event: any) => {
        event.detail.response.text().then(
          (error_message: string) => { this.setError(error_message) }
        )
      },
      {signal}
    )
  }

  disconnectedCallback() {
    this.#abortController?.abort()
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
