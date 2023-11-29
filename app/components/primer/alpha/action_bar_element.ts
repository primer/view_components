import {controller, targets, target} from '@github/catalyst'
import {focusZone, FocusKeys} from '@primer/behaviors'

const instersectionObserver = new IntersectionObserver(entries => {
  for (const entry of entries) {
    const action = entry.target
    if (entry.isIntersecting && action instanceof ActionBarElement) {
      action.update()
    }
  }
})

const resizeObserver = new ResizeObserver(entries => {
  for (const entry of entries) {
    const action = entry.target
    if (action instanceof ActionBarElement) {
      action.update(entry.contentRect)
    }
  }
})

@controller
class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @target itemContainer: HTMLElement
  @target moreMenu: HTMLElement

  #initialBarWidth: number
  #previousBarWidth: number
  #focusZoneAbortController: AbortController | null = null

  connectedCallback() {
    this.#previousBarWidth = this.offsetWidth ?? Infinity
    this.#initialBarWidth = this.itemContainer.offsetWidth ?? Infinity

    // Calculate the width of all the items before hiding anything
    for (const item of this.items) {
      const width = item.getBoundingClientRect().width
      const marginLeft = parseInt(window.getComputedStyle(item)?.marginLeft, 10)
      const marginRight = parseInt(window.getComputedStyle(item)?.marginRight, 10)
      item.setAttribute('data-offset-width', `${width + marginLeft + marginRight}`)
    }

    resizeObserver.observe(this)
    instersectionObserver.observe(this)

    // Wait for the items to be rendered, making this really short to avoid a flash of unstyled content
    requestAnimationFrame(() => this.update())
  }

  disconnectedCallback() {
    resizeObserver.unobserve(this)
    instersectionObserver.unobserve(this)
  }

  menuItemClick(event: Event) {
    const currentTarget = event.currentTarget as HTMLButtonElement

    const id = currentTarget?.getAttribute('data-for')

    if (id) {
      document.getElementById(id)?.click()
    }
  }

  update(rect: DOMRect = this.getBoundingClientRect()) {
    // Only recalculate if the bar width changed
    if (rect.width <= this.#previousBarWidth || this.#previousBarWidth === 0) {
      this.#shrink()
    } else if (rect.width > this.#previousBarWidth) {
      this.#grow()
    }
    this.#previousBarWidth = rect.width

    if (rect.width <= this.#initialBarWidth) {
      this.style.justifyContent = 'space-between'
    } else {
      this.style.justifyContent = 'flex-end'
    }
    if (this.#focusZoneAbortController) {
      this.#focusZoneAbortController.abort()
    }
    this.#focusZoneAbortController = focusZone(this, {
      bindKeys: FocusKeys.ArrowHorizontal | FocusKeys.HomeAndEnd,
      focusOutBehavior: 'wrap',
      focusableElementFilter: element => {
        return this.#isVisible(element)
      },
    })
  }

  #isVisible(element: HTMLElement): boolean {
    // Safari doesn't support `checkVisibility` yet.
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    if (typeof element.checkVisibility === 'function') return element.checkVisibility()

    return Boolean(element.offsetParent || element.offsetWidth || element.offsetHeight)
  }

  #itemGap(): number {
    return parseInt(window.getComputedStyle(this.itemContainer)?.columnGap, 10) || 0
  }

  #availableSpace(): number {
    // Get the offset of the item container from the container edge
    return this.offsetWidth - this.itemContainer.offsetWidth
  }

  #menuSpace(): number {
    if (this.moreMenu.hidden) {
      return 0
    }
    return this.moreMenu.offsetWidth + this.#itemGap()
  }

  #shrink() {
    if (this.items[0]!.hidden) {
      return
    }

    let index = this.items.length - 1
    for (const item of this.items.reverse()) {
      if (!item.hidden && this.#availableSpace() < this.#menuSpace()) {
        this.#hideItem(index)
      } else if (this.#availableSpace() >= this.#menuSpace()) {
        return
      }
      index--
    }
  }

  #grow() {
    // If last item is visible, there is no need to grow
    if (!this.items[this.items.length - 1]!.hidden) {
      return
    }
    let index = 0
    for (const item of this.items) {
      if (item.hidden) {
        const offsetWidth = Number(item.getAttribute('data-offset-width'))

        if (this.#availableSpace() >= this.#menuSpace() + offsetWidth || index === this.items.length - 1) {
          this.#showItem(index)
        } else {
          return
        }
      }
      index++
    }

    if (!this.items[this.items.length - 1]!.hidden) {
      this.moreMenu.hidden = true
    }
  }

  #showItem(index: number) {
    this.items[index]!.hidden = false
    this.#menuItems[index]!.hidden = true
  }

  #hideItem(index: number) {
    this.items[index]!.hidden = true
    this.#menuItems[index]!.hidden = false

    if (this.moreMenu.hidden) {
      this.moreMenu.hidden = false
    }
  }

  get #menuItems(): NodeListOf<HTMLElement> {
    return this.moreMenu.querySelectorAll('[role="menu"] > li')
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}

window.ActionBarElement = ActionBarElement
