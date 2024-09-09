import {controller, target} from '@github/catalyst'

declare global {
  interface HTMLElementEventMap {
    'banner:dismiss': CustomEvent<void>
  }
}

@controller
class XBannerElement extends HTMLElement {
  @target titleText: HTMLElement

  dismiss() {
    if (this.#dismissScheme === 'remove') {
      const parentElement = this.parentElement
      if (!parentElement) return

      parentElement.removeChild(this)
    } else {
      this.hide()
    }

    this.dispatchEvent(new CustomEvent('banner:dismiss'))
  }

  show() {
    this.style.setProperty('display', 'initial')
  }

  hide() {
    this.style.setProperty('display', 'none')
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
