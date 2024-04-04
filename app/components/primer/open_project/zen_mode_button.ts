import {controller, target} from '@github/catalyst'

@controller
class ZenModeButtonElement extends HTMLElement {
  @target button: HTMLElement
  inZenMode = false

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
