import {controller} from '@github/catalyst'
import {CollapsibleHelperElement} from '../collapsible_helper'

@controller
class CollapsibleHeaderElement extends CollapsibleHelperElement {
  connectedCallback() {
    if (!this.closest('.Box')) {
      throw new Error('No surrounding BorderBox found')
    }
  }

  get baseClass(): string {
    return 'CollapsibleHeader'
  }
}

declare global {
  interface Window {
    CollapsibleHeaderElement: typeof CollapsibleHeaderElement
  }
}
