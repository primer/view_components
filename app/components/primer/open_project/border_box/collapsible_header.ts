import {controller} from '@github/catalyst'
import {CollapsibleElement} from '../collapsible'

@controller
class CollapsibleHeaderElement extends CollapsibleElement {
  connectedCallback() {
    super.connectedCallback()
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
