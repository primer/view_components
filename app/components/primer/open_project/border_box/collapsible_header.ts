import { attr, controller, target } from '@github/catalyst'

@controller
class CollapsibleHeaderElement extends HTMLElement {
  container = null
  @target arrowDown: HTMLElement
  @target arrowUp: HTMLElement
  @target description: HTMLElement

  @attr collapsed: boolean

  // eslint-disable-next-line custom-elements/no-constructor
  constructor() {
    super()

    this.container = this.closest('.Box')
  }

  connectedCallback() {
    if (this.collapsed) {
      this.hideAll()
    }
  }

  public toggle() {
    if (this.collapsed) {
      this.collapsed = false
      this.expandAll()
    } else {
      this.collapsed = true
      this.hideAll()
    }
  }

  private hideAll() {
    const rows = this.container.querySelectorAll('.Box-row, .Box-body, .Box-footer')

    rows.forEach(row => {
      row.classList.add('d-none')
    })

    this.arrowDown.classList.remove('d-none')
    this.arrowUp.classList.add('d-none')
    this.description.classList.add('d-none')

    this.container.style.borderBottomLeftRadius = '0'
    this.container.style.borderBottomRightRadius = '0'
    this.container.style.borderBottomWidth = '3px'
  }

  private expandAll() {
    const rows = this.container.querySelectorAll('.Box-row, .Box-body, .Box-footer')

    rows.forEach(row => {
      row.classList.remove('d-none')
    })

    this.arrowDown.classList.add('d-none')
    this.arrowUp.classList.remove('d-none')
    this.description.classList.remove('d-none')

    this.container.style.borderBottomLeftRadius = '0.375rem'
    this.container.style.borderBottomRightRadius = '0.375rem'
    this.container.style.borderBottomWidth = '1px'
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
