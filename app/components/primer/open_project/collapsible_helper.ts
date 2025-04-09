import {attr, target, targets} from '@github/catalyst'

// eslint-disable-next-line custom-elements/expose-class-on-global
export abstract class CollapsibleHelperElement extends HTMLElement {
  @target arrowDown: HTMLElement
  @target arrowUp: HTMLElement
  @targets collapsibleElements: HTMLElement[]

  @attr collapsed: string
  private _collapsed: boolean

  connectedCallback() {
    if (this.collapsed === 'true') {
      this._collapsed = true
      this.hideAll()
    } else {
      this._collapsed = false
    }
  }

  toggle() {
    if (this._collapsed) {
      this._collapsed = false
      this.expandAll()
    } else {
      this._collapsed = true
      this.hideAll()
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
