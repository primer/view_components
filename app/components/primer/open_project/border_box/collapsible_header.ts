import {controller} from '@github/catalyst'
import {CollapsibleHelperElement} from '../collapsible_helper'

@controller
class CollapsibleHeaderElement extends CollapsibleHelperElement {
  connectedCallback() {
    if (!this.closest('.Box')) {
      throw new Error('No surrounding BorderBox found')
    }

    super.connectedCallback()
  }

  get baseClass(): string | void {
    return 'CollapsibleHeader'
  }
}

declare global {
  interface Window {
    CollapsibleHeaderElement: typeof CollapsibleHeaderElement
  }
}

if (!window.customElements.get('collapsible-header')) {
  window.CollapsibleHeaderElement = CollapsibleHeaderElement
  // eslint-disable-next-line custom-elements/extends-correct-class
  window.customElements.define('collapsible-header', CollapsibleHeaderElement)
}
