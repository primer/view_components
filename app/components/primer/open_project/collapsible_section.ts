import {controller} from '@github/catalyst'
import {CollapsibleElement} from './collapsible'

@controller
class CollapsibleSectionElement extends CollapsibleElement {
  get baseClass(): string {
    return 'CollapsibleSection'
  }
}

declare global {
  interface Window {
    CollapsibleSectionElement: typeof CollapsibleSectionElement
  }
}
