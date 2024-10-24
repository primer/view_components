import {controller, target} from '@github/catalyst'

@controller
class ZenModeButtonElement extends HTMLElement {
  @target button: HTMLElement
  inZenMode = false

  dispatchZenModeStatus() {
    // Create a new custom event
    const event = new CustomEvent('zenModeToggled', {
      detail: {
        active: this.inZenMode,
      },
    })
    // Dispatch the custom event
    window.dispatchEvent(event)
  }

  private deactivateZenMode() {
    this.inZenMode = false
    this.button.setAttribute('aria-pressed', 'false')
    if (document.exitFullscreen) {
      void document.exitFullscreen()
    }
  }

  private activateZenMode() {
    this.inZenMode = true
    this.button.setAttribute('aria-pressed', 'true')
    if (document.documentElement.requestFullscreen) {
      void document.documentElement.requestFullscreen()
    }
  }

  public performAction() {
    if (this.inZenMode) {
      this.deactivateZenMode()
    } else {
      this.activateZenMode()
    }
    this.dispatchZenModeStatus()
  }
}

declare global {
  interface Window {
    ZenModeButtonElement: typeof ZenModeButtonElement
  }
}

if (!window.customElements.get('zen-mode-button')) {
  window.ZenModeButtonElement = ZenModeButtonElement
  window.customElements.define('zen-mode-button', ZenModeButtonElement)
}
