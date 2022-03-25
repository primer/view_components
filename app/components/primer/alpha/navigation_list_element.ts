import {controller} from '@github/catalyst'

@controller
class NavigationListElement extends HTMLElement {
  connectedCallback(): void {
    this.addEventListener('click', this)
  }

  handleEvent(event: Event) {
    if (!(event.target instanceof HTMLElement)) return
    const item = event.target?.closest('button')
    if (item?.closest(this.tagName) !== this) return
    if (event.type === 'click') {
      this.#handleClick(item, event)
    }
  }

  #handleClick(item: HTMLElement, e: Event) {
    if (item.getAttribute('aria-expanded') !== null) {
      if (item.getAttribute('aria-expanded') === 'true') {
        item.setAttribute('aria-expanded', 'false')
      } else {
        item.setAttribute('aria-expanded', 'true')
      }
    }

    e.stopPropagation()
  }
}

// Necessary to turn this file into an external module
export {}
