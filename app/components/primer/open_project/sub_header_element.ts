import {controller, target, targets} from '@github/catalyst'

@controller
class SubHeaderElement extends HTMLElement {
  @target filterInput: HTMLElement
  @targets hiddenItemsOnExpandedFilter: HTMLElement[]
  @targets shownItemsOnExpandedFilter: HTMLElement[]

  expandFilterInput() {
    for (const item of this.hiddenItemsOnExpandedFilter) {
      item.classList.add('d-none')
    }

    for (const item of this.shownItemsOnExpandedFilter) {
      item.classList.remove('d-none')
    }

    this.classList.add('d-flex')

    this.filterInput.focus()
  }

  collapseFilterInput() {
    for (const item of this.hiddenItemsOnExpandedFilter) {
      item.classList.remove('d-none')
    }

    for (const item of this.shownItemsOnExpandedFilter) {
      item.classList.add('d-none')
    }

    this.classList.remove('d-flex')
  }
}

declare global {
  interface Window {
    SubHeaderElement: typeof SubHeaderElement
  }
}

if (!window.customElements.get('sub-header')) {
  window.SubHeaderElement = SubHeaderElement
  window.customElements.define('sub-header', SubHeaderElement)
}
