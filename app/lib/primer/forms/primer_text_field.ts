/* eslint-disable custom-elements/expose-class-on-global */

import '@github/auto-check-element'
import type {AutoCheckErrorEvent, AutoCheckSuccessEvent} from '@github/auto-check-element'
import {controller, target} from '@github/catalyst'

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
  @target characterLimitValidationElement: HTMLElement
  @target characterLimitValidationMessageElement: HTMLElement

  #abortController: AbortController | null
  #announceTimeout: number | null = null

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
      this.inputElement.addEventListener('input', () => this.#updateCharacterCount(), {signal})
      this.#updateCharacterCount()
    }
  }

  disconnectedCallback() {
    this.#abortController?.abort()
    if (this.#announceTimeout) {
      clearTimeout(this.#announceTimeout)
    }
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

  #updateCharacterCount(): void {
    if (!this.characterLimitElement) return

    const maxLength = parseInt(this.characterLimitElement.getAttribute('data-max-length') || '0', 10)
    if (maxLength === 0) return

    const currentLength = this.inputElement.value.length
    const remaining = maxLength - currentLength
    let message = ''

    if (remaining >= 0) {
      // Still under or at the limit
      const word = remaining === 1 ? 'character' : 'characters'
      message = `${remaining} ${word} remaining.`
      this.characterLimitElement.textContent = message
      this.#clearCharacterLimitError()
    } else {
      // Over the limit
      const over = Math.abs(remaining)
      const word = over === 1 ? 'character' : 'characters'
      message = `${over} ${word} over.`
      this.characterLimitElement.textContent = message
      this.#setCharacterLimitError()
    }

    // Debounce the aria-live announcement
    this.#announceToScreenReader(message)
  }

  #announceToScreenReader(message: string): void {
    // Clear any existing timeout
    if (this.#announceTimeout) {
      clearTimeout(this.#announceTimeout)
    }

    // Set a new timeout to announce after 150ms
    this.#announceTimeout = window.setTimeout(() => {
      const srTargetId = this.characterLimitElement?.getAttribute('data-sr-target')
      if (srTargetId) {
        const srElement = document.getElementById(srTargetId)
        if (srElement) {
          srElement.textContent = message
        }
      }
    }, 150)
  }

  #setCharacterLimitError(): void {
    if (!this.characterLimitValidationElement || !this.characterLimitValidationMessageElement) return

    this.inputElement.setAttribute('invalid', 'true')
    this.characterLimitValidationMessageElement.textContent = "You've exceeded the character limit"
    this.characterLimitValidationElement.hidden = false
  }

  #clearCharacterLimitError(): void {
    if (!this.characterLimitValidationElement || !this.characterLimitValidationMessageElement) return

    this.inputElement.removeAttribute('invalid')
    this.characterLimitValidationMessageElement.textContent = ''
    this.characterLimitValidationElement.hidden = true
  }
}
