import {controller, target} from '@github/catalyst'
import {CharacterCounter} from './character_counter'

@controller
export class PrimerTextAreaElement extends HTMLElement {
  @target inputElement: HTMLTextAreaElement
  @target characterLimitElement: HTMLElement
  @target characterLimitSrElement: HTMLElement

  #characterCounter: CharacterCounter | null = null

  connectedCallback(): void {
    if (this.characterLimitElement) {
      this.#characterCounter = new CharacterCounter(
        this.inputElement,
        this.characterLimitElement,
        this.characterLimitSrElement,
      )
      this.#characterCounter.initialize()
    }
  }

  disconnectedCallback(): void {
    this.#characterCounter?.cleanup()
  }
}

declare global {
  interface Window {
    PrimerTextAreaElement: typeof PrimerTextAreaElement
  }
}

if (!window.customElements.get('primer-text-area')) {
  Object.assign(window, {PrimerTextAreaElement})
  window.customElements.define('primer-text-area', PrimerTextAreaElement)
}
