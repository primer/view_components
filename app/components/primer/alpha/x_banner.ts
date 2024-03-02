import {controller, target} from '@github/catalyst'
// eslint-disable-next-line import/no-unresolved
import '@primer/live-region-element/define'
import {announceFromElement} from '@primer/live-region-element'

@controller
class XBannerElement extends HTMLElement {
  @target titleText: HTMLElement
  @target banner: HTMLElement
  @target contentToAnnounce: HTMLElement
  private observer?: IntersectionObserver

  connectedCallback() {
    if (this.#announceOnShow === 'true') {
      const options = {
        root: document.body,
        rootMargin: '0px',
        threshold: 0,
      }
      const callback = (entries: IntersectionObserverEntry[]) => {
        for (const entry of entries) {
          if (entry.isIntersecting || entry.intersectionRatio > 0) {
            if (this.#announceOnShow === 'true') {
              announceFromElement(this.contentToAnnounce)
            }
            this.observer?.disconnect()
          }
        }
      }
      this.observer = new IntersectionObserver(callback, options)
      this.observer.observe(this.banner)
    }
  }
  disconnectedCallback() {
    this.observer?.disconnect()
  }

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
  }

  hide() {
    this.style.setProperty('display', 'none')
  }

  get #announceOnShow(): string {
    return this.getAttribute('data-announce-on-show')!
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
