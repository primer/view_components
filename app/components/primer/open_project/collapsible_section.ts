import {controller} from '@github/catalyst'
import {CollapsibleHelperElement} from './collapsible_helper'

@controller
class CollapsibleSectionElement extends CollapsibleHelperElement {
  get baseClass(): string {
    return 'CollapsibleSection'
  }
}

declare global {
  interface Window {
    CollapsibleSectionElement: typeof CollapsibleSectionElement
  }
}

if (!window.customElements.get('collapsible-section')) {
  window.CollapsibleSectionElement = CollapsibleSectionElement
  // eslint-disable-next-line custom-elements/extends-correct-class
  window.customElements.define('collapsible-section', CollapsibleSectionElement)
}
