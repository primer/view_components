import {controller, target} from '@github/catalyst'

@controller
class FlashBannerElement extends HTMLElement {
  @target root: HTMLElement
  @target message: HTMLElement

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
    this.lastFocusedElement?.focus()
  }

  private announceMessage() {
    setTimeout(() => {
      this.message.focus()
    }, 200)
  }

  private shouldReappear(): boolean {
    return this.root.getAttribute('data-reappear') === 'true'
  }
}

declare global {
  interface Window {
    FlashBannerElement: typeof FlashBannerElement
  }
}

if (!window.customElements.get('flash-banner')) {
  window.FlashBannerElement = FlashBannerElement
  window.customElements.define('flash-banner', FlashBannerElement)
}
