import '@github/auto-check-element'
import type {AutoCheckErrorEvent, AutoCheckSuccessEvent} from '@github/auto-check-element'
import {controller, target} from '@github/catalyst'
import {CharacterCounter} from './character_counter'

declare global {
  interface HTMLElementEventMap {
    'auto-check-success': AutoCheckSuccessEvent
    'auto-check-error': AutoCheckErrorEvent
  }
}

@controller
export class PrimerTextFieldElement extends HTMLElement {
  @target inputElement: HTMLInputElement
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement
  @target validationSuccessIcon: HTMLElement
  @target validationErrorIcon: HTMLElement
  @target leadingVisual: HTMLElement
  @target leadingSpinner: HTMLElement
  @target characterLimitElement: HTMLElement
  @target characterLimitSrElement: HTMLElement

  #abortController: AbortController | null
  #characterCounter: CharacterCounter | null = null

  connectedCallback(): void {
    this.#abortController?.abort()
    const {signal} = (this.#abortController = new AbortController())

    this.addEventListener(
      'auto-check-success',
      async (event: AutoCheckSuccessEvent) => {
        const message = await event.detail.response.text()
        if (message && message.length > 0) {
          this.setSuccess(message)
        } else {
          this.clearError()
        }
      },
      {signal},
    )

    this.addEventListener(
      'auto-check-error',
      async (event: AutoCheckErrorEvent) => {
        const errorMessage = await event.detail.response.text()
        this.setError(errorMessage)
      },
      {signal},
    )

    // Set up character limit tracking if present
    if (this.characterLimitElement) {
      this.#characterCounter = new CharacterCounter(
        this.inputElement,
        this.characterLimitElement,
        this.characterLimitSrElement,
      )
      this.#characterCounter.initialize(signal)
    }
  }

  disconnectedCallback() {
    this.#abortController?.abort()
    this.#characterCounter?.cleanup()
  }

  clearContents() {
    this.inputElement.value = ''
    this.inputElement.focus()
    this.inputElement.dispatchEvent(new Event('input', {bubbles: true, cancelable: false}))
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
    if (isError) {
      this.validationElement.classList.remove('FormControl-inlineValidation--success')
    } else {
      this.validationElement.classList.add('FormControl-inlineValidation--success')
    }
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

  showLeadingSpinner(): void {
    this.leadingSpinner?.removeAttribute('hidden')
    this.leadingVisual?.setAttribute('hidden', '')
  }

  hideLeadingSpinner(): void {
    this.leadingSpinner?.setAttribute('hidden', '')
    this.leadingVisual?.removeAttribute('hidden')
  }
}
