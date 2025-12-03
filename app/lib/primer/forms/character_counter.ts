/**
 * Shared character counting functionality for text inputs with character limits.
 * Handles real-time character count updates, validation, and aria-live announcements.
 */
export class CharacterCounter {
  private announceTimeout: number | null = null

  constructor(
    private inputElement: HTMLInputElement | HTMLTextAreaElement,
    private characterLimitElement: HTMLElement,
    private validationElement: HTMLElement | undefined,
    private validationMessageElement: HTMLElement | undefined,
  ) {}

  /**
   * Initialize character counting by setting up event listener and initial count
   */
  initialize(signal?: AbortSignal): void {
    this.inputElement.addEventListener('input', () => this.updateCharacterCount(), signal ? {signal} : undefined)
    this.updateCharacterCount()
  }

  /**
   * Clean up any pending timeouts
   */
  cleanup(): void {
    if (this.announceTimeout) {
      clearTimeout(this.announceTimeout)
    }
  }

  /**
   * Update the character count display and validation state
   */
  private updateCharacterCount(): void {
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
      this.clearError()
    } else {
      // Over the limit
      const over = Math.abs(remaining)
      const word = over === 1 ? 'character' : 'characters'
      message = `${over} ${word} over.`
      this.characterLimitElement.textContent = message
      this.setError()
    }

    // Debounce the aria-live announcement
    this.announceToScreenReader(message)
  }

  /**
   * Announce character count to screen readers with debouncing
   */
  private announceToScreenReader(message: string): void {
    // Clear any existing timeout
    if (this.announceTimeout) {
      clearTimeout(this.announceTimeout)
    }

    // Set a new timeout to announce after 150ms
    this.announceTimeout = window.setTimeout(() => {
      const srTargetId = this.characterLimitElement?.getAttribute('data-sr-target')
      if (srTargetId) {
        const srElement = document.getElementById(srTargetId)
        if (srElement) {
          srElement.textContent = message
        }
      }
    }, 150)
  }

  /**
   * Show validation error when character limit is exceeded
   */
  private setError(): void {
    if (!this.validationElement || !this.validationMessageElement) return

    this.inputElement.setAttribute('invalid', 'true')
    this.inputElement.setAttribute('aria-invalid', 'true')

    // Add validation message ID to aria-describedby
    const validationId = this.validationElement.id
    if (validationId) {
      const existingDescribedBy = this.inputElement.getAttribute('aria-describedby') || ''
      const describedByIds = existingDescribedBy.split(' ').filter(id => id.length > 0)
      if (!describedByIds.includes(validationId)) {
        describedByIds.push(validationId)
        this.inputElement.setAttribute('aria-describedby', describedByIds.join(' '))
      }
    }

    this.validationMessageElement.textContent = "You've exceeded the character limit"
    this.validationElement.hidden = false
  }

  /**
   * Clear validation error when back under character limit
   */
  private clearError(): void {
    if (!this.validationElement || !this.validationMessageElement) return

    this.inputElement.removeAttribute('invalid')
    this.inputElement.removeAttribute('aria-invalid')

    // Remove validation message ID from aria-describedby
    const validationId = this.validationElement.id
    if (validationId) {
      const existingDescribedBy = this.inputElement.getAttribute('aria-describedby') || ''
      const describedByIds = existingDescribedBy.split(' ').filter(id => id.length > 0 && id !== validationId)
      if (describedByIds.length > 0) {
        this.inputElement.setAttribute('aria-describedby', describedByIds.join(' '))
      } else {
        this.inputElement.removeAttribute('aria-describedby')
      }
    }

    this.validationMessageElement.textContent = ''
    this.validationElement.hidden = true
  }
}
