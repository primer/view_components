import {controller, target, targets} from '@github/catalyst'

@controller
class SubHeaderElement extends HTMLElement {
  @target filterInput: HTMLInputElement
  @targets hiddenItemsOnExpandedFilter: HTMLElement[]
  @targets shownItemsOnExpandedFilter: HTMLElement[]

  connectedCallback() {
    this.setupFilterInputClearButton()
  }

  setupFilterInputClearButton() {
    this.waitForCondition(
      () => Boolean(this.filterInput),
      () => {
        this.toggleFilterInputClearButton()
      },
    )
  }

  toggleFilterInputClearButton() {
    if (this.filterInput.value.length > 0) {
      this.filterInput.classList.remove('SubHeader-filterInput_hiddenClearButton')
    } else {
      this.filterInput.classList.add('SubHeader-filterInput_hiddenClearButton')
    }
  }

  expandFilterInput() {
    for (const item of this.hiddenItemsOnExpandedFilter) {
      item.classList.add('d-none')
    }

    for (const item of this.shownItemsOnExpandedFilter) {
      item.classList.remove('d-none')
    }

    this.classList.add('SubHeader--expandedSearch')

    this.filterInput.focus()
  }

  collapseFilterInput() {
    for (const item of this.hiddenItemsOnExpandedFilter) {
      item.classList.remove('d-none')
    }

    for (const item of this.shownItemsOnExpandedFilter) {
      item.classList.add('d-none')
    }

    this.classList.remove('SubHeader--expandedSearch')
  }

  // Waits for condition to return true. If it returns false initially, this function creates a
  // MutationObserver that calls body() whenever the contents of the component change.
  private waitForCondition(condition: () => boolean, body: () => void) {
    if (condition()) {
      body()
    } else {
      const mutationObserver = new MutationObserver(() => {
        if (condition()) {
          body()
          mutationObserver.disconnect()
        }
      })

      mutationObserver.observe(this, {childList: true, subtree: true})
    }
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
