/* eslint-disable custom-elements/expose-class-on-global */
/* eslint-disable custom-elements/define-tag-after-class-definition */

import {controller, targets, target} from '@github/catalyst'
import {positionedOffset} from '@primer/behaviors'

@controller
export class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @targets menuItems: HTMLElement[]
  @target moreMenu: HTMLElement

  // eslint-disable-next-line prettier/prettier
  #observer: ResizeObserver
  #initialBarWidth: number

  connectedCallback() {
    let overflowItemsCount = 0
    for (const item of this.items) {
      const offset = positionedOffset(item, this)
      if (offset && offset.left < 0) {
        overflowItemsCount++
      }
    }
    this.#hideItems(overflowItemsCount)
    this.#toggleMoreMenu()

    this.#initialBarWidth = this.offsetWidth

    this.#observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (this.#initialBarWidth !== entry.contentRect.width) {
          this.#calculateVisibility()
        }
      }
    })
    this.#observer.observe(this)
  }

  disconnectedCallback() {
    this.#observer.unobserve(this)
  }

  #calculateVisibility() {
    const firstItem = this.items[0]
    if (firstItem.hidden && this.offsetWidth >= firstItem.offsetWidth + this.#gap()) {
      this.#showItems(1)
    }
    const offset = positionedOffset(firstItem, this)
    if (!offset) {
      return
    }
    if (offset.left < 0) {
      this.#hideItems(1)
    } else if (offset.left >= firstItem.offsetWidth + this.#gap()) {
      this.#showItems(1)
    }
    this.#toggleMoreMenu()
  }

  #hideItems(count: number) {
    const reversedItems = this.items.slice().reverse().filter(item => !item.hidden)
    const reversedMenuItems = this.menuItems.slice().reverse().filter(item => item.hidden)
    for (const i of [...Array(count).keys()]) {
      if (reversedItems[i]) {
        reversedItems[i].hidden = true
      }
      if (reversedMenuItems[i]) {
        reversedMenuItems[i].hidden = false
      }
    }
  }

  #showItems(count: number) {
    const items = this.#hiddenItems()
    const menuItems = this.menuItems.filter(item => !item.hidden)
    for (const i of [...Array(count).keys()]) {
      if (items[i]) {
        items[i].hidden = false
      }
      if (menuItems[i]) {
        menuItems[i].hidden = true
      }
    }
  }

  #hiddenItems(): HTMLElement[] {
    return this.items.filter(item => item.hidden)
  }

  #toggleMoreMenu() {
    this.moreMenu.hidden = this.#hiddenItems().length === 0
  }

  #gap(): number {
    return parseInt(window.getComputedStyle(this)?.columnGap) || 0
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}
