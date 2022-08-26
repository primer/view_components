/* eslint-disable custom-elements/expose-class-on-global */
/* eslint-disable custom-elements/define-tag-after-class-definition */

import {controller, targets, target} from '@github/catalyst'
import {positionedOffset} from '@primer/behaviors'

@controller
export class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @targets menuItems: HTMLElement[]
  @target moreMenu: HTMLElement

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

    window.addEventListener('resize', this.#calculateVisibility.bind(this))
  }

  #calculateVisibility() {
    const firstItem = this.items[0]
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
      reversedItems[i].hidden = true
      reversedMenuItems[i].hidden = false
    }
  }

  #showItems(count: number) {
    const items = this.#hiddenItems()
    const menuItems = this.menuItems.filter(item => !item.hidden)
    for (const i of [...Array(count).keys()]) {
      items[i].hidden = false
      menuItems[i].hidden = true
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
