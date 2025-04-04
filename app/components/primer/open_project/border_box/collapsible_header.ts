import {attr, controller, target} from '@github/catalyst'

@controller
class CollapsibleHeaderElement extends HTMLElement {
  @target arrowDown: HTMLElement
  @target arrowUp: HTMLElement
  @target description: HTMLElement | undefined

  @attr collapsed: string
  private _collapsed: boolean

  connectedCallback() {
    if (!this.closest('.Box')) {
      throw new Error('No surrounding BorderBox found')
    }

    if (this.collapsed === 'true') {
      this._collapsed = true
      this.hideAll()
    } else {
      this._collapsed = false
    }
  }

  public toggle() {
    if (this._collapsed) {
      this._collapsed = false
      this.expandAll()
    } else {
      this._collapsed = true
      this.hideAll()
    }
  }

  private hideAll() {
    this.arrowDown?.classList.remove('d-none')
    this.arrowUp?.classList.add('d-none')

    this.description?.classList.add('d-none')

    this.classList.add('CollapsibleHeader--collapsed')
  }

  private expandAll() {
    this.arrowDown?.classList.add('d-none')
    this.arrowUp?.classList.remove('d-none')

    this.description?.classList.remove('d-none')

    this.classList.remove('CollapsibleHeader--collapsed')
  }
}

declare global {
  interface Window {
    CollapsibleHeaderElement: typeof CollapsibleHeaderElement
  }
}

if (!window.customElements.get('collapsible-header')) {
  window.CollapsibleHeaderElement = CollapsibleHeaderElement
  window.customElements.define('collapsible-header', CollapsibleHeaderElement)
}
