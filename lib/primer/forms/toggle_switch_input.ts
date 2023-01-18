import {controller, target} from '@github/catalyst'

@controller
export class ToggleSwitchInputElement extends HTMLElement {
  @target validationElement: HTMLElement
  @target validationMessageElement: HTMLElement

  connectedCallback() {
    this.addEventListener('toggleSwitchError', (event: Event) => {
      this.validationMessageElement.innerText = (event as CustomEvent).detail
      this.validationElement.removeAttribute('hidden')
    })

    this.addEventListener('toggleSwitchSuccess', () => {
      this.validationMessageElement.innerText = ''
      this.validationElement.setAttribute('hidden', 'hidden')
    })
  }
}
