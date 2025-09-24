import {controller, target, attr} from '@github/catalyst'
import type {LiveRegionElement} from '@primer/live-region-element'

const SUBMIT_BUTTON_SELECTOR = 'input[type=submit],button[type=submit],button[data-submit-dialog-id]'

@controller
class DangerDialogFormHelperElement extends HTMLElement {
  @target checkbox: HTMLInputElement | undefined
  @target liveRegion: LiveRegionElement
  @attr confirmationLiveMessageChecked = ''
  @attr confirmationLiveMessageUnchecked = ''

  get form() {
    return this.querySelector('form')
  }

  get submitButton() {
    return this.querySelector<HTMLInputElement | HTMLButtonElement>(SUBMIT_BUTTON_SELECTOR)!
  }

  connectedCallback() {
    // makes the custom element behave as if it doesn't exist in the DOM structure, passing all
    // styles directly to its children.
    this.style.display = 'contents'
    if (this.form) {
      this.form.style.display = 'contents'
    }
    this.#reset()
  }

  toggle(): void {
    if (!this.checkbox || !this.submitButton) return

    const enabled = this.checkbox.checked
    this.submitButton.disabled = !enabled

    if (this.liveRegion) {
      const message = enabled ? this.confirmationLiveMessageChecked : this.confirmationLiveMessageUnchecked
      this.liveRegion.announce(message, {politeness: 'assertive'})
    }
  }

  #reset(): void {
    this.toggle()
  }
}

declare global {
  interface Window {
    DangerDialogFormHelperElement: typeof DangerDialogFormHelperElement
  }
}

if (!window.customElements.get('danger-dialog-form-helper')) {
  window.DangerDialogFormHelperElement = DangerDialogFormHelperElement
  window.customElements.define('danger-dialog-form-helper', DangerDialogFormHelperElement)
}
