import {controller} from '@github/catalyst'

// eslint-disable-next-line custom-elements/no-exports-with-element
export class ActionListTruncationObserver {
  resizeObserver = new ResizeObserver(entries => {
    for (const entry of entries) {
      const action = entry.target

      if (action instanceof HTMLElement) {
        this.update(action)
      }
    }
  })

  constructor(el: HTMLElement) {
    this.resizeObserver.observe(el)
  }

  unobserve(el: HTMLElement) {
    this.resizeObserver.unobserve(el)
  }

  update(el: HTMLElement) {
    const items = el.querySelectorAll('li')

    for (const item of items) {
      const label = item.querySelector('.ActionListItem-label') as HTMLElement
      if (!label) continue
      const tooltip = item.querySelector('.ActionListItem-truncationTooltip') as HTMLElement
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

@controller
// eslint-disable-next-line custom-elements/expose-class-on-global
export class ActionListElement extends HTMLElement {
  #truncationObserver: ActionListTruncationObserver

  connectedCallback() {
    this.#truncationObserver = new ActionListTruncationObserver(this)
  }

  disconnectedCallback() {
    this.#truncationObserver.unobserve(this)
  }
}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
