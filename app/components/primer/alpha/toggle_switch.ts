import {controller, target} from '@github/catalyst'

@controller
class ToggleSwitchElement extends HTMLElement {
  @target switch: HTMLElement
  @target loadingSpinner: HTMLElement
  @target errorIcon: HTMLElement

  private toggling = false

  get src(): string | null {
    const src = this.getAttribute('src')
    if (!src) return null

    const link = this.ownerDocument.createElement('a')
    link.href = src
    return link.href
  }

  get csrf(): string | null {
    const csrfElement = this.querySelector('[data-csrf]')
    return this.getAttribute('csrf') || (csrfElement instanceof HTMLInputElement && csrfElement.value) || null
  }

  get csrfField(): string {
    // the authenticity token is passed into the element and is not generated in js land

    return this.getAttribute('csrf-field') || 'authenticity_token'
  }

  isRemote(): boolean {
    return this.src != null
  }

  async toggle() {
    if (this.toggling) return

    this.toggling = true

    if (this.isDisabled()) {
      return
    }

    if (!this.isRemote()) {
      this.performToggle()
      this.toggling = false
      return
    }

    // toggle immediately to tell screen readers the switch was clicked
    this.performToggle()
    this.setLoadingState()

    try {
      await this.submitForm()
    } catch (error) {
      if (error instanceof Error) {
        // because we toggle immediately when the switch is clicked, toggle back to the
        // old state on failure
        this.setErrorState(error.message || 'An error occurred, please try again.')
        this.performToggle()
      }

      return
    } finally {
      this.toggling = false
    }

    this.setSuccessState()
  }

  turnOn(): void {
    if (this.isDisabled()) {
      return
    }

    this.switch.setAttribute('aria-pressed', 'true')
    this.classList.add('ToggleSwitch--checked')
  }

  turnOff(): void {
    if (this.isDisabled()) {
      return
    }

    this.switch.setAttribute('aria-pressed', 'false')
    this.classList.remove('ToggleSwitch--checked')
  }

  isOn(): boolean {
    return this.switch.getAttribute('aria-pressed') === 'true'
  }

  isOff(): boolean {
    return !this.isOn()
  }

  isDisabled(): boolean {
    return this.switch.getAttribute('disabled') != null
  }

  disable(): void {
    this.switch.setAttribute('disabled', 'disabled')
  }

  enable(): void {
    this.switch.removeAttribute('disabled')
  }

  private performToggle(): void {
    if (this.isOn()) {
      this.turnOff()
    } else {
      this.turnOn()
    }
  }

  private setLoadingState(): void {
    this.errorIcon.setAttribute('hidden', 'hidden')
    this.loadingSpinner.removeAttribute('hidden')

    const event = new CustomEvent('toggleSwitchLoading', {bubbles: true})
    this.dispatchEvent(event)
  }

  private setSuccessState(): void {
    const event = new CustomEvent('toggleSwitchSuccess', {bubbles: true})
    this.dispatchEvent(event)

    this.setFinishedState(false)
  }

  private setErrorState(message: string): void {
    const event = new CustomEvent('toggleSwitchError', {bubbles: true, detail: message})
    this.dispatchEvent(event)

    this.setFinishedState(true)
  }

  private setFinishedState(error: boolean): void {
    if (error) {
      this.errorIcon.removeAttribute('hidden')
    }

    this.loadingSpinner.setAttribute('hidden', 'hidden')
  }

  private async submitForm() {
    const body = new FormData()

    if (this.csrf) {
      body.append(this.csrfField, this.csrf)
    }

    body.append('value', this.isOn() ? '1' : '0')

    if (!this.src) throw new Error('invalid src')

    let response

    try {
      response = await fetch(this.src, {
        credentials: 'same-origin',
        method: 'POST',
        headers: {
          'Requested-With': 'XMLHttpRequest',
        },
        body,
      })
    } catch (error) {
      throw new Error('A network error occurred, please try again.')
    }

    if (!response.ok) {
      throw new Error(await response.text())
    }
  }
}

declare global {
  interface Window {
    ToggleSwitchElement: typeof ToggleSwitchElement
  }
}

if (!window.customElements.get('toggle-switch')) {
  window.ToggleSwitchElement = ToggleSwitchElement
  window.customElements.define('toggle-switch', ToggleSwitchElement)
}
