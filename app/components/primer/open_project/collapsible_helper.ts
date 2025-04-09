import {attr, target, targets} from '@github/catalyst'

// eslint-disable-next-line custom-elements/expose-class-on-global
export abstract class CollapsibleHelperElement extends HTMLElement {
  @target arrowDown: HTMLElement
  @target arrowUp: HTMLElement
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
    this.arrowDown?.classList.remove('d-none')
    this.arrowUp?.classList.add('d-none')

    for (const el of this.collapsibleElements) {
      el.classList.add('d-none')
    }

    this.classList.add(`${this.baseClass}--collapsed`)
  }

  expandAll() {
    this.arrowDown?.classList.add('d-none')
    this.arrowUp?.classList.remove('d-none')

    for (const el of this.collapsibleElements) {
      el.classList.remove('d-none')
    }

    this.classList.remove(`${this.baseClass}--collapsed`)
  }

  abstract get baseClass(): string
}
