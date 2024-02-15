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
      const label = item.querySelector('.ActionListItem-label')
      if (!label) continue

      const tooltip = item.querySelector('.ActionListItem-truncationTooltip') as HTMLElement | null
      if (!tooltip) continue

      const isTruncated = label.scrollWidth > label.clientWidth

      if (isTruncated) {
        tooltip.style.display = ''
      } else {
        tooltip.style.display = 'none'
      }
    }
  }
}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
