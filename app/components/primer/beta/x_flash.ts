import {controller} from '@github/catalyst'
import {XBannerElement} from './x_banner'

@controller
class XFlashElement extends XBannerElement {
  private lastFocusedElement: HTMLElement

  connectedCallback() {
    this.lastFocusedElement = (document.activeElement as HTMLElement) || document.body

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
    this.lastFocusedElement?.focus()
  }

  private announceMessage() {
    this.message.focus()
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
