import {controller, attr} from '@github/catalyst'

@controller
export class ScrollableRegionElement extends HTMLElement {
  @attr hasOverflow = false
  @attr labelledBy = ''

  observer: ResizeObserver

  connectedCallback() {
    this.style.overflow = 'auto'

    this.observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        this.hasOverflow =
          entry.target.scrollHeight > entry.target.clientHeight || entry.target.scrollWidth > entry.target.clientWidth
      }
    })

    this.observer.observe(this)
  }

  disconnectedCallback() {
    this.observer.disconnect()
  }

  attributeChangedCallback(name: string) {
    if (name === 'data-has-overflow') {
      if (this.hasOverflow) {
        this.setAttribute('aria-labelledby', this.labelledBy)
        this.setAttribute('role', 'region')
        this.setAttribute('tabindex', '0')
      } else {
        this.removeAttribute('aria-labelledby')
        this.removeAttribute('role')
        this.removeAttribute('tabindex')
      }
    }
  }
}

declare global {
  interface Window {
    ScrollableRegionElement: typeof ScrollableRegionElement
  }
}

window.ScrollableRegionElement = ScrollableRegionElement
