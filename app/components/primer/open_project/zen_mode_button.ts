import {controller, target} from '@github/catalyst'
import screenfull from 'screenfull'

@controller
class ZenModeButtonElement extends HTMLElement {
  @target button: HTMLElement
  inZenMode = false

  private deactivateZenMode() {
    this.inZenMode = false
    this.button.classList.remove('zen-mode-button--active')
    this.querySelector('body')?.classList.remove('zen-mode')
    if (screenfull.isEnabled && screenfull.isFullscreen) {
      screenfull.exit()
    }
  }

  private activateZenMode() {
    this.inZenMode = true
    document.querySelector('body')?.classList.add('zen-mode')
    this.button.classList.add('zen-mode-button--active')
    if (screenfull.isEnabled) {
      screenfull.request()
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
