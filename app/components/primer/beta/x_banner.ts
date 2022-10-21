import {controller, target} from '@github/catalyst'

@controller
export class XBannerElement extends HTMLElement {
  @target root: HTMLElement
  @target message: HTMLElement

  dismiss() {
    if (this.shouldReappear()) {
      this.style.setProperty('visibility', 'hidden')

      setTimeout(() => {
        this.style.setProperty('visibility', 'visible')
      }, 2000)

      return
    }

    const parentElement = this.parentElement
    if (!parentElement) return

    parentElement.removeChild(this)
  }

  private shouldReappear(): boolean {
    return this.root.getAttribute('data-reappear') === 'true'
  }
}

declare global {
  interface Window {
    XBannerElement: typeof XBannerElement
  }
}

if (!window.customElements.get('x-banner')) {
  window.XBannerElement = XBannerElement
  window.customElements.define('x-banner', XBannerElement)
}
