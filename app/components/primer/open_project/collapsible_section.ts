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
