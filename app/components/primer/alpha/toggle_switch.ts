import {controller, target} from '@github/catalyst'
import {debounce} from '@github/mini-throttle/decorators'

@controller
export class ToggleSwitchElement extends HTMLElement {
  @target switch: HTMLElement
  @target loadingSpinner: HTMLElement
  @target errorIcon: HTMLElement

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

  toggle() {
    if (this.isRemote()) {
      this.setLoadingState()
      this.check()
    } else {
      this.performToggle()
    }
  }

  turnOn(): void {
    if (this.isDisabled()) {
      return
    }

    this.switch.setAttribute('aria-checked', 'true')
    this.classList.add('ToggleSwitch--checked')
  }

  turnOff(): void {
    if (this.isDisabled()) {
      return
    }

    this.switch.setAttribute('aria-checked', 'false')
    this.classList.remove('ToggleSwitch--checked')
  }

  isOn(): boolean {
    return this.switch.getAttribute('aria-checked') === 'true'
  }

  isOff(): boolean {
    return !this.isOn()
  }

  isDisabled(): boolean {
    return this.switch.getAttribute('aria-disabled') === 'true'
  }

  disable(): void {
    this.switch.setAttribute('aria-disabled', 'true')
  }

  enable(): void {
    this.switch.setAttribute('aria-disabled', 'false')
  }

  private performToggle(): void {
    if (this.isOn()) {
      this.turnOff()
    } else {
      this.turnOn()
    }
  }

  private setLoadingState(): void {
    this.disable()
    this.errorIcon.setAttribute('hidden', 'hidden')
    this.loadingSpinner.removeAttribute('hidden')
  }

  private setSuccessState(): void {
    this.setFinishedState(false)
  }

  private setErrorState(): void {
    this.setFinishedState(true)
  }

  private setFinishedState(error: boolean): void {
    if (error) {
      this.errorIcon.removeAttribute('hidden')
    }

    this.loadingSpinner.setAttribute('hidden', 'hidden')
    this.enable()
  }

  @debounce(300)
  private async check() {
    const body = new FormData()

    if (this.csrf) {
      body.append(this.csrfField, this.csrf)
    }

    body.append('value', this.isOn() ? '1' : '0')

    try {
      if (!this.src) throw new Error('invalid src')
      const response = await fetch(this.src, {
        credentials: 'same-origin',
        method: 'POST',
        body
      })
      if (response.ok) {
        this.setSuccessState()
        this.performToggle()
      } else {
        this.setErrorState()
      }
    } catch (error) {
      this.setErrorState()
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
