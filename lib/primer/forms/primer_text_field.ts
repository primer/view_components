import '@github/auto-check-element'
import {controller, target} from '@github/catalyst'

// eslint-disable-next-line custom-elements/expose-class-on-global
@controller
// eslint-disable-next-line no-unused-vars, @typescript-eslint/no-unused-vars
class PrimerTextFieldElement extends HTMLElement {
  @target inputElement: HTMLInputElement
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement
  @target validationSuccessIcon: HTMLElement
  @target validationErrorIcon: HTMLElement

  #abortController: AbortController | null

  connectedCallback(): void {
    this.#abortController?.abort()
    const {signal} = (this.#abortController = new AbortController())

    this.inputElement.addEventListener(
      'auto-check-success',
      async (event: any) => {
        const message = await event.detail.response.text()
        if (message && message.length > 0) {
          this.setSuccess(message)
        } else {
          this.clearError()
        }
      },
      {signal},
    )

    this.inputElement.addEventListener(
      'auto-check-error',
      async (event: any) => {
        const errorMessage = await event.detail.response.text()
        this.setError(errorMessage)
      },
      {signal},
    )
  }

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  clearContents() {
    this.inputElement.value = ''
    this.inputElement.focus()
  }

  clearError(): void {
    this.inputElement.removeAttribute('invalid')
    this.validationElement.hidden = true
    this.validationMessageElement.replaceChildren()
  }

  setValidationMessage(message: string): void {
    const template = document.createElement('template')
    // eslint-disable-next-line github/no-inner-html
    template.innerHTML = message
    const fragment = document.importNode(template.content, true)
    this.validationMessageElement.replaceChildren(fragment)
  }

  toggleValidationStyling(isError: boolean): void {
    this.validationElement.classList.remove(
      isError ? 'FormControl-inlineValidation--success' : 'FormControl-inlineValidation--error',
    )
    this.validationElement.classList.add(
      isError ? 'FormControl-inlineValidation--error' : 'FormControl-inlineValidation--success',
    )
    this.validationSuccessIcon.hidden = isError
    this.validationErrorIcon.hidden = !isError
    this.inputElement.setAttribute('invalid', isError ? 'true' : 'false')
  }

  setSuccess(message: string): void {
    this.toggleValidationStyling(false)
    this.setValidationMessage(message)
    this.validationElement.hidden = false
  }

  setError(message: string): void {
    this.toggleValidationStyling(true)
    this.setValidationMessage(message)
    this.validationElement.hidden = false
  }
}
