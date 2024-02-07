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
    this.style.setProperty('display', 'initial')
    if (this.#focusOnShow === 'true') {
      this.focus()
    }
  }

  hide() {
    this.style.setProperty('display', 'none')
  }

  get #dismissScheme(): string {
    return this.getAttribute('data-dismiss-scheme')!
  }

  get #focusOnShow(): string {
    return this.getAttribute('data-focus-on-show')!
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
