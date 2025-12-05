/**
 * Shared character counting functionality for text inputs with character limits.
 * Handles real-time character count updates, validation, and aria-live announcements.
 */
export class CharacterCounter {
  private SCREEN_READER_DELAY: number = 500
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

    const maxLengthAttr = this.characterLimitElement.getAttribute('data-max-length')
    if (!maxLengthAttr) return

    const maxLength = parseInt(maxLengthAttr, 10)
    const currentLength = this.inputElement.value.length
    const charactersRemaining = maxLength - currentLength
    let message = ''

    if (charactersRemaining >= 0) {
      const characterText = charactersRemaining === 1 ? 'character' : 'characters'
      message = `${charactersRemaining} ${characterText} remaining.`
      this.characterLimitElement.textContent = message
      this.clearError()
    } else {
      const charactersOver = -charactersRemaining
      const characterText = charactersOver === 1 ? 'character' : 'characters'
      message = `${charactersOver} ${characterText} over.`
      this.characterLimitElement.textContent = message
      this.setError()
    }

    this.announceToScreenReader(message)
  }

  /**
   * Announce character count to screen readers with debouncing
   */
  private announceToScreenReader(message: string): void {
    if (this.announceTimeout) {
      clearTimeout(this.announceTimeout)
    }

    this.announceTimeout = window.setTimeout(() => {
      const srTargetId = this.characterLimitElement?.getAttribute('data-sr-target')
      if (!srTargetId) return

      const srElement = document.getElementById(srTargetId)
      if (srElement) {
        srElement.textContent = message
      }
    }, this.SCREEN_READER_DELAY)
  }

  /**
   * Show validation error when character limit is exceeded.
   * Required since default validation on inputs only appears after an attempt to submit the form.
   */
  private setError(): void {
    if (!this.validationElement || !this.validationMessageElement) return

    this.inputElement.setAttribute('invalid', 'true')
    this.inputElement.setAttribute('aria-invalid', 'true')

    // Add validation message ID to aria-describedby to ensure it is read by screen readers
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
