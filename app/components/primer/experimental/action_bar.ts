import {controller, targets, target} from '@github/catalyst'
import {focusZone, FocusKeys} from '@primer/behaviors'
import type {FocusZoneSettings} from '@primer/behaviors'

@controller
export class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @targets menuItems: HTMLElement[]
  @target itemContainer: HTMLElement
  @target moreMenu: HTMLElement

  #observer: ResizeObserver
  #initialBarWidth: number
  #previousBarWidth: number
  #itemGap: number
  #focusController: AbortController
  #focusSettings: FocusZoneSettings = {
    bindKeys: FocusKeys.ArrowHorizontal | FocusKeys.HomeAndEnd
  } as FocusZoneSettings

  connectedCallback() {
    this.#initialBarWidth = this.offsetWidth
    this.#previousBarWidth = this.offsetWidth
    this.#itemGap = parseInt(window.getComputedStyle(this.itemContainer)?.columnGap, 10) || 0

    // Calculate the width of all the items before hiding anything
    for (const item of this.items) {
      const width = item.getBoundingClientRect().width
      const marginLeft = parseInt(window.getComputedStyle(item)?.marginLeft, 10)
      const marginRight = parseInt(window.getComputedStyle(item)?.marginRight, 10)
      item.setAttribute('data-offset-width', `${width + marginLeft + marginRight}`)
    }

    this.#focusController = focusZone(this, this.#focusSettings)

    this.style.maxWidth = `${this.itemContainer.offsetWidth}px`

    // Calculate visible items on page load until there is enough space
    // to show all items or the first item is hidden
    while (this.#availableSpace() < this.moreMenu.offsetWidth + this.#itemGap * 0.5 && !this.items[0].hidden) {
      this.#shrinking()
    }

    this.style.overflow = 'visible'

    this.#observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        // Only recalculate if the bar width changed
        if (this.#initialBarWidth !== entry.contentRect.width) {
          if (entry.contentRect.width < this.#previousBarWidth) {
            this.#shrinking()
          } else {
            this.#growing()
          }
          this.#previousBarWidth = entry.contentRect.width
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
    // Get the offset of the item container from the container edge
    return this.offsetWidth - this.itemContainer.offsetWidth
  }

  #shrinking() {
    if (this.items[0].hidden) {
      return
    }
    const gapSpace = this.#itemGap * 0.5

    if (this.#availableSpace() < this.moreMenu.offsetWidth + gapSpace) {
      const visibleItems = this.items.filter(item => !item.hidden)
      const hiddenMenuItems = this.menuItems.filter(item => item.hidden)

      visibleItems[visibleItems.length - 1].hidden = true
      hiddenMenuItems[hiddenMenuItems.length - 1].hidden = false

      if (this.moreMenu.hidden) {
        this.moreMenu.hidden = false
      }

      // Reset focus controller
      this.#focusController?.abort()
      this.#focusController = focusZone(this, this.#focusSettings)
    }
  }

  #growing() {
    if (this.moreMenu.hidden) {
      return
    }
    const gapSpace = this.#itemGap * 0.5
    const hiddenItems = this.items.filter(item => item.hidden)
    if (hiddenItems.length === 0) {
      return
    }

    const hiddenItemWidth = Number(hiddenItems[0].getAttribute('data-offset-width'))

    if (this.#availableSpace() >= this.moreMenu.offsetWidth + hiddenItemWidth + gapSpace) {
      const visibleMenuItems = this.menuItems.filter(item => !item.hidden)

      hiddenItems[0].hidden = false
      visibleMenuItems[0].hidden = true

      if (hiddenItems.length === 2) {
        hiddenItems[1].hidden = false
        visibleMenuItems[1].hidden = true
      }

      // If there was only one item left, hide the more menu
      if (hiddenItems.length <= 2) {
        this.moreMenu.hidden = true
      }

      // Reset focus controller
      this.#focusController?.abort()
      this.#focusController = focusZone(this, this.#focusSettings)
    }
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}

window.ActionBarElement = ActionBarElement
