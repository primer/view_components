import {controller, target} from '@github/catalyst'
import {observeMutationsUntilConditionMet} from '../../utils'

@controller
export class TreeViewIconPairElement extends HTMLElement {
  @target expandedIcon: HTMLElement
  @target collapsedIcon: HTMLElement

  expanded: boolean

  connectedCallback() {
    observeMutationsUntilConditionMet(
      this,
      () => Boolean(this.collapsedIcon) && Boolean(this.expandedIcon),
      () => {
        this.expanded = this.collapsedIcon.hidden
      },
    )
  }

  showExpanded() {
    this.expanded = true
    this.#update()
  }

  showCollapsed() {
    this.expanded = false
    this.#update()
  }

  toggle() {
    this.expanded = !this.expanded
    this.#update()
  }

  #update() {
    if (this.expanded) {
      this.expandedIcon.hidden = false
      this.collapsedIcon.hidden = true
    } else {
      this.expandedIcon.hidden = true
      this.collapsedIcon.hidden = false
    }
  }
}

if (!window.customElements.get('tree-view-icon-pair')) {
  window.TreeViewIconPairElement = TreeViewIconPairElement
  window.customElements.define('tree-view-icon-pair', TreeViewIconPairElement)
}

declare global {
  interface Window {
    TreeViewIconPairElement: typeof TreeViewIconPairElement
  }
}
