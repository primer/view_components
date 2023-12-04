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
      action.update()
    }
  }
})

enum ItemType {
  Item,
  Divider
}

@controller
class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @target itemContainer: HTMLElement
  @target moreMenu: HTMLElement

  #focusZoneAbortController: AbortController | null = null

  connectedCallback() {
    // Calculate the width of all the items before hiding anything
    for (const item of this.items) {
      const width = item.getBoundingClientRect().width
      const marginLeft = parseInt(window.getComputedStyle(item)?.marginLeft, 10)
      const marginRight = parseInt(window.getComputedStyle(item)?.marginRight, 10)
      item.setAttribute('data-offset-width', `${width + marginLeft + marginRight}`)
    }

    resizeObserver.observe(this)
    instersectionObserver.observe(this)

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

  update() {
    const firstItem = this.#firstItem
    if (!firstItem) return

    const firstItemTop = firstItem.getBoundingClientRect().top
    let previousItemType: ItemType | null = null

    this.#eachItem((item: HTMLElement, index: number, type: ItemType): boolean => {
      const itemTop = item.getBoundingClientRect().top

      if (type === ItemType.Item) {
        if (itemTop > firstItemTop) {
          this.#hideItem(index)

          if (this.moreMenu.hidden) {
            this.moreMenu.hidden = false
          }

          if (previousItemType === ItemType.Divider) {
            this.#hideItem(index - 1)
          }
        } else {
          this.#showItem(index)

          if (index === this.items.length - 1) {
            this.moreMenu.hidden = true
          }

          if (previousItemType === ItemType.Divider) {
            this.#showItem(index - 1)
          }
        }
      }

      previousItemType = type

      return true
    })

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

  get #firstItem(): HTMLElement | null {
    let foundItem = null

    this.#eachItem((item: HTMLElement, _index: number, type: ItemType): boolean => {
      if (type === ItemType.Item) {
        foundItem = item
        return false
      }

      return true
    })

    return foundItem
  }

  #isVisible(element: HTMLElement): boolean {
    // Safari doesn't support `checkVisibility` yet.
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    if (typeof element.checkVisibility === 'function') return element.checkVisibility()

    return Boolean(element.offsetParent || element.offsetWidth || element.offsetHeight)
  }

  #showItem(index: number) {
    this.items[index].style.setProperty('visibility', 'visible')
    this.#menuItems[index]!.hidden = true
  }

  #hideItem(index: number) {
    this.items[index].style.setProperty('visibility', 'hidden')
    this.#menuItems[index]!.hidden = false
  }

  get #menuItems(): NodeListOf<HTMLElement> {
    return this.moreMenu.querySelectorAll('[role="menu"] > li')
  }

  // eslint-disable-next-line no-unused-vars
  #eachItem(callback: (item: HTMLElement, index: number, type: ItemType) => boolean): void {
    for (let i = 0; i < this.items.length; i++) {
      const item = this.items[i]
      const type = item.classList.contains('ActionBar-divider') ? ItemType.Divider : ItemType.Item
      if (!callback(item, i, type)) {
        break
      }
    }
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}

window.ActionBarElement = ActionBarElement
