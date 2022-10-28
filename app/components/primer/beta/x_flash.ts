import {controller} from '@github/catalyst'
import {XBannerElement} from './x_banner'

@controller
class XFlashElement extends XBannerElement {
  connectedCallback() {
    this.announceMessage()
  }

  dismiss() {
    super.dismiss()
  }

  private announceMessage() {
    this.heading.focus()
  }
}

declare global {
  interface Window {
    XFlashElement: typeof XFlashElement
  }
}

if (!window.customElements.get('x-flash')) {
  window.XFlashElement = XFlashElement
  // eslint-disable-next-line custom-elements/extends-correct-class
  window.customElements.define('x-flash', XFlashElement)
}
