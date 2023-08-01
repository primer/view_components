import {controller, target} from '@github/catalyst'

@controller
class XBannerElement extends HTMLElement {
  @target titleText: HTMLElement

  dismiss() {
    const parentElement = this.parentElement
    if (!parentElement) return

    if (this.#dismissScheme === 'remove') {
      parentElement.removeChild(this)
    } else {
      this.hide()
    }
  }

  show() {
    this.style.setProperty('visibility', 'visible')
  }

  hide() {
    this.style.setProperty('visibility', 'hidden')
  }

  get #dismissScheme(): string {
    return this.getAttribute('data-dismiss-scheme')!
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
