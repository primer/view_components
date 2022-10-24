import {controller} from '@github/catalyst'
import {XBannerElement} from './x_banner'

@controller
class XFlashElement extends XBannerElement {
  connectedCallback() {
    if (document.readyState.toString() === 'ready' || document.readyState.toString() === 'complete') {
      this.announceMessage()
    } else {
      document.addEventListener('readystatechange', () => {
        if (document.readyState.toString() === 'complete') {
          this.announceMessage()
        }
      })
    }
  }

  dismiss() {
    super.dismiss()
  }

  private announceMessage() {
    setTimeout(() => {
      const textNode = document.createTextNode('\u00A0')
      this.titleText.appendChild(textNode)
    }, 500)
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
