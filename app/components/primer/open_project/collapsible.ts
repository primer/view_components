import {attr, target, targets} from '@github/catalyst'

// eslint-disable-next-line custom-elements/expose-class-on-global
export abstract class CollapsibleElement extends HTMLElement {
  @target arrowDown: Element
  @target arrowUp: Element
  @targets collapsibleElements: HTMLElement[]

  @attr collapsed = false

  toggle() {
    this.collapsed = !this.collapsed
  }

  attributeChangedCallback(name: string) {
    if (name === 'data-collapsed') {
      if (this.collapsed) {
        this.hideAll()
      } else {
        this.expandAll()
      }
    }
  }

  hideAll() {
    // For whatever reason, setting `hidden` directly does not work on the SVGs
    this.arrowDown.removeAttribute('hidden')
    this.arrowUp.setAttribute('hidden', '')

    for (const el of this.collapsibleElements) {
      el.hidden = true
    }

    this.classList.add(`${this.baseClass}--collapsed`)
  }

  expandAll() {
    this.arrowUp.removeAttribute('hidden')
    this.arrowDown.setAttribute('hidden', '')

    for (const el of this.collapsibleElements) {
      el.hidden = false
    }

    this.classList.remove(`${this.baseClass}--collapsed`)
  }

  abstract get baseClass(): string
}
