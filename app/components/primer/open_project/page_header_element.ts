import {controller, targets} from '@github/catalyst'

@controller
class PageHeaderElement extends HTMLElement {
  @targets actionItems: HTMLElement[]

  connectedCallback() {
    for (const item of this.actionItems) {
      /*
      If there is only one action to be shown, we show that instead of the mobile action menu. However, the buttons should be the smaller button variant.
      Unfortunately, the `size` attribute does not support responsive attributes and the .pcss syntax does not support inheritance between classes.
      So we have to add the class manually here.
      */
      if (window.innerWidth <= 544) {
        item.classList.add('Button--small')
      }
    }
  }

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
