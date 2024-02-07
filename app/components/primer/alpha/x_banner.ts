import {controller, target} from '@github/catalyst'

@controller
class XBannerElement extends HTMLElement {
  @target titleText: HTMLElement

  // connectedCallback() {
  //   if (this.#focusOnShow === 'true') {
  //     this.focus()
  //   }
  // }

  dismiss() {
    const parentElement = this.parentElement
    if (!parentElement) return

    if (this.#dismissScheme === 'remove') {
      parentElement.removeChild(this)
    } else {
      this.hide()
    }
  }

  focusBanner() {
    this.setAttribute('tabindex', '-1')
    this.focus()
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
