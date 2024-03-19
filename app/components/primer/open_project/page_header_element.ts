import {controller} from '@github/catalyst'

@controller
class PageHeaderElement extends HTMLElement {
  menuItemClick(event: Event) {
    // Todo: remove
    alert('test')
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

window.PageHeaderElement = PageHeaderElement
