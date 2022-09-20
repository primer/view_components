import {controller} from '@github/catalyst'
import {ActionListElement} from './action_list_element'

@controller
class NavListElement extends ActionListElement {
  connectedCallback(): void {
    if (this.arrowNavigation === true) {
      this.setupFocusZone()
    }
  }
}

declare global {
  interface Window {
    NavListElement: typeof NavListElement
  }
}
