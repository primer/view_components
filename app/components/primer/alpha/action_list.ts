/* eslint-disable custom-elements/expose-class-on-global */
import {controller, targets} from '@github/catalyst'

const resizeObserver = new ResizeObserver(entries => {
  for (const entry of entries) {
    const action = entry.target
    if (action instanceof ActionListElement) {
      action.update()
    }
  }
})

@controller
export class ActionListElement extends HTMLElement {
  @targets items: HTMLElement[]

  connectedCallback() {
    resizeObserver.observe(this)
  }

  disconnectedCallback() {
    resizeObserver.unobserve(this)
  }

  update() {
    for (const item of this.items) {
      const isTruncated = item.scrollWidth > item.clientWidth
      if (!isTruncated) {
        const result = item.querySelector('.ActionListItem-truncationTooltip') as HTMLElement
        if (result) {
          result.style.display = 'none'
        }
      } else {
        const result = item.querySelector('.ActionListItem-truncationTooltip') as HTMLElement
        if (result) {
          result.style.display = ''
        }
      }
    }
  }
}
declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
