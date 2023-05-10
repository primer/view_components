/* eslint-disable custom-elements/expose-class-on-global */

import {controller, target} from '@github/catalyst'

@controller
export class ToggleSwitchInputElement extends HTMLElement {
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement

  connectedCallback() {
    this.addEventListener('toggleSwitchError', (event: Event) => {
      this.validationMessageElement.textContent = (event as CustomEvent).detail
      this.validationElement.removeAttribute('hidden')
    })

    this.addEventListener('toggleSwitchSuccess', () => {
      this.validationMessageElement.textContent = ''
      this.validationElement.setAttribute('hidden', 'hidden')
    })

    this.addEventListener('toggleSwitchLoading', () => {
      this.validationMessageElement.textContent = ''
      this.validationElement.setAttribute('hidden', 'hidden')
    })
  }
}
