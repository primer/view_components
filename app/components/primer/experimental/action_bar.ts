import {controller, targets, target} from '@github/catalyst'
import {positionedOffset, focusZone, FocusKeys} from '@primer/behaviors'
import type {FocusZoneSettings} from '@primer/behaviors'

@controller
export class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @targets menuItems: HTMLElement[]
  @target moreMenu: HTMLElement

  #observer: ResizeObserver
  #initialBarWidth: number
  #itemGap: number
  #focusController: AbortController
  #focusSettings: FocusZoneSettings = {
    bindKeys: FocusKeys.ArrowHorizontal | FocusKeys.HomeAndEnd
  } as FocusZoneSettings

  connectedCallback() {
    this.#initialBarWidth = this.offsetWidth
    this.#itemGap = parseInt(window.getComputedStyle(this)?.columnGap, 10) || 0

    // Calculate the width of all the items before hiding anything
    for (const item of this.items) {
      const width = item.getBoundingClientRect().width
      const marginLeft = parseInt(window.getComputedStyle(item)?.marginLeft, 10)
      const marginRight = parseInt(window.getComputedStyle(item)?.marginRight, 10)
      item.setAttribute('data-offset-width', `${width + marginLeft + marginRight}`)
    }

    this.#focusController = focusZone(this, this.#focusSettings)

    // Calculate visible items on page load until there is enough space
    // to show all items or the first item is hidden
    // while (this.#availableSpace() < this.moreMenu.clientWidth && !this.items[0].hidden) {
    //   this.#calculateVisibleItems()
    // }

    this.style.overflow = 'visible'

    this.#observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        // Only recalculate if the bar width changed
        if (this.#initialBarWidth !== entry.contentRect.width) {
          this.#calculateVisibleItems()
        }
      }
    })

    this.#observer.observe(this)
  }

  disconnectedCallback() {
    this.#focusController?.abort()
    this.#observer.unobserve(this)
  }

  #availableSpace(): number {
    const visibleItems = this.#visibleItems()
    const lastItem = visibleItems[visibleItems.length - 1]
    // Get the offset of the first item from the container edge
    const offset = positionedOffset(lastItem, this)
    if (!offset) {
      return this.clientWidth - this.moreMenu.clientWidth
    }

    return offset.right
  }

  #calculateVisibleItems() {
    const space = this.#availableSpace()

    if (space < this.moreMenu.clientWidth) {
      this.#hideItem()
    } else if (space > this.#nextItemWidth() + this.moreMenu.clientWidth) {
      this.#showItem()
    }
  }

  #nextItemWidth(): number {
    const nextItem = this.#hiddenItems()[0] || this.items[0]

    return Number(nextItem.getAttribute('data-offset-width') || '0')
  }

  #hideItem() {
    const visibleItems = this.#visibleItems()
    const hiddenMenuItems = this.#hiddenMenuItems()

    if (visibleItems.length === 0) {
      return
    }
    visibleItems[visibleItems.length - 1].hidden = true
    hiddenMenuItems[hiddenMenuItems.length - 1].hidden = false

    if (this.moreMenu.getAttribute('aria-hidden') === 'true') {
      this.#showMenu()
    }

    // Reset focus controller
    this.#focusController?.abort()
    this.#focusController = focusZone(this, this.#focusSettings)
  }

  #showItem() {
    const hiddenItems = this.#hiddenItems()
    const visibleMenuItems = this.#visibleMenuItems()

    if (hiddenItems.length === 0) {
      return
    }
    hiddenItems[0].hidden = false
    visibleMenuItems[0].hidden = true
    // If there was only one item left, hide the more menu
    if (hiddenItems.length === 1) {
      this.#hideMenu()
    }

    // Reset focus controller
    this.#focusController?.abort()
    this.#focusController = focusZone(this, this.#focusSettings)
  }

  #hiddenItems(): HTMLElement[] {
    return this.items.filter(item => item.hidden)
  }

  #visibleItems(): HTMLElement[] {
    return this.items.filter(item => !item.hidden)
  }

  #hiddenMenuItems(): HTMLElement[] {
    return this.menuItems.filter(item => item.hidden)
  }

  #visibleMenuItems(): HTMLElement[] {
    return this.menuItems.filter(item => !item.hidden)
  }

  #hideMenu() {
    this.moreMenu.setAttribute('aria-hidden', 'true')
    // this.moreMenu.open = false
  }

  #showMenu() {
    this.moreMenu.setAttribute('aria-hidden', 'false')
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}

window.ActionBarElement = ActionBarElement
