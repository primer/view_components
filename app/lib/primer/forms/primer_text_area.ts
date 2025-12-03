import {controller, target} from '@github/catalyst'

@controller
export class PrimerTextAreaElement extends HTMLElement {
  @target inputElement: HTMLTextAreaElement
  @target characterLimitElement: HTMLElement
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement

  #announceTimeout: number | null = null

  connectedCallback(): void {
    this.inputElement.addEventListener('input', () => this.#updateCharacterCount())
    // Initialize the count on load
    this.#updateCharacterCount()
  }

  disconnectedCallback(): void {
    if (this.#announceTimeout) {
      clearTimeout(this.#announceTimeout)
    }
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
      this.#clearError()
    } else {
      // Over the limit
      const over = Math.abs(remaining)
      const word = over === 1 ? 'character' : 'characters'
      message = `${over} ${word} over.`
      this.characterLimitElement.textContent = message
      this.#setError()
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

  #setError(): void {
    if (!this.validationElement || !this.validationMessageElement) return

    this.inputElement.setAttribute('invalid', 'true')
    this.validationMessageElement.textContent = "You've exceeded the character limit"
    this.validationElement.hidden = false
  }

  #clearError(): void {
    if (!this.validationElement || !this.validationMessageElement) return

    this.inputElement.removeAttribute('invalid')
    this.validationMessageElement.textContent = ''
    this.validationElement.hidden = true
  }
}

declare global {
  interface Window {
    PrimerTextAreaElement: typeof PrimerTextAreaElement
  }
}

if (!window.customElements.get('primer-text-area')) {
  Object.assign(window, {PrimerTextAreaElement})
  window.customElements.define('primer-text-area', PrimerTextAreaElement)
}
