import {controller} from '@github/catalyst'

@controller
class PageHeaderElement extends HTMLElement {
  menuItemClick(event: Event) {
    const currentTarget = event.currentTarget as HTMLButtonElement

    const id = currentTarget?.getAttribute('data-for')

    if (id) {
      document.getElementById(id)?.click()
    }
  }
}

declare global {
  interface Window {
    PageHeaderElement: typeof PageHeaderElement
  }
}

if (!window.customElements.get('page-header')) {
  window.PageHeaderElement = PageHeaderElement
  window.customElements.define('page-header', PageHeaderElement)
}
