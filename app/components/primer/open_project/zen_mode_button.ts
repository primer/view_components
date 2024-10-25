import {controller, target} from '@github/catalyst'

@controller
class ZenModeButtonElement extends HTMLElement {
  @target button: HTMLElement
  inZenMode = false

  // eslint-disable-next-line custom-elements/no-constructor
  constructor() {
    super()
    document.addEventListener('fullscreenchange', this.fullscreenChangeEventHandler.bind(this))
  }

  disconnectedCallback() {
    document.removeEventListener('fullscreenchange', this.fullscreenChangeEventHandler.bind(this))
  }

  fullscreenChangeEventHandler() {
    this.changeButtonState(!this.inZenMode)
    this.dispatchZenModeStatus()
  }
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
    if (document.exitFullscreen) {
      void document.exitFullscreen()
    }
  }

  private activateZenMode() {
    if (document.documentElement.requestFullscreen) {
      void document.documentElement.requestFullscreen()
    }
  }
  public changeButtonState(inZenMode: boolean) {
    this.inZenMode = inZenMode
    this.button.setAttribute('aria-pressed', inZenMode.toString())
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
