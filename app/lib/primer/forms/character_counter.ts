/**
 * Shared character counting functionality for text inputs with character limits.
 * Handles real-time character count updates, validation, and aria-live announcements.
 */
export class CharacterCounter {
  private SCREEN_READER_DELAY: number = 500
  private announceTimeout: number | null = null
  private isInitialLoad: boolean = true

  constructor(
    private inputElement: HTMLInputElement | HTMLTextAreaElement,
    private characterLimitElement: HTMLElement,
    private characterLimitSrElement?: HTMLElement,
  ) {}

  /**
   * Initialize character counting by setting up event listener and initial count
   */
  initialize(signal?: AbortSignal): void {
    this.inputElement.addEventListener('input', () => this.updateCharacterCount(), signal ? {signal} : undefined)
    this.updateCharacterCount()
    this.isInitialLoad = false
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
   * Pluralizes a word based on the count
   */
  private pluralize(count: number, string: string): string {
    return count === 1 ? string : `${string}s`
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
      const characterText = this.pluralize(charactersRemaining, 'character')
      message = `${charactersRemaining} ${characterText} remaining`
      const textSpan = this.characterLimitElement.querySelector('.FormControl-caption-text')
      if (textSpan) {
        textSpan.textContent = message
      }
      this.clearError()
    } else {
      const charactersOver = -charactersRemaining
      const characterText = this.pluralize(charactersOver, 'character')
      message = `${charactersOver} ${characterText} over`
      const textSpan = this.characterLimitElement.querySelector('.FormControl-caption-text')
      if (textSpan) {
        textSpan.textContent = message
      }
      this.setError()
    }

    // We don't want this announced on initial load
    if (!this.isInitialLoad) {
      this.announceToScreenReader(message)
    }
  }

  /**
   * Announce character count to screen readers with debouncing
   */
  private announceToScreenReader(message: string): void {
    if (this.announceTimeout) {
      clearTimeout(this.announceTimeout)
    }

    this.announceTimeout = window.setTimeout(() => {
      if (this.characterLimitSrElement) {
        this.characterLimitSrElement.textContent = message
      }
    }, this.SCREEN_READER_DELAY)
  }

  /**
   * Set error when character limit is exceeded
   */
  private setError(): void {
    this.inputElement.setAttribute('invalid', 'true')
    this.inputElement.setAttribute('aria-invalid', 'true')
    this.characterLimitElement.classList.add('fgColor-danger')

    // Show danger icon
    const icon = this.characterLimitElement.querySelector('.FormControl-caption-icon')
    if (icon) {
      icon.removeAttribute('hidden')
    }
  }

  /**
   * Clear error when back under character limit
   */
  private clearError(): void {
    this.inputElement.removeAttribute('invalid')
    this.inputElement.removeAttribute('aria-invalid')
    this.characterLimitElement.classList.remove('fgColor-danger')

    // Hide danger icon
    const icon = this.characterLimitElement.querySelector('.FormControl-caption-icon')
    if (icon) {
      icon.setAttribute('hidden', '')
    }
  }
}
