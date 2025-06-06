import {controller, targets, target} from '@github/catalyst'
import {focusZone, FocusKeys} from '@primer/behaviors'
import {ActionMenuElement} from './action_menu/action_menu_element'

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

// These are definitely used, but eslint is dumb apparently

enum ItemType {
  Item,
  Divider,
}

@controller
class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @target itemContainer: HTMLElement
  @target moreMenu: ActionMenuElement

  #focusZoneAbortController: AbortController | null = null

  connectedCallback() {
    resizeObserver.observe(this)
    instersectionObserver.observe(this)

    requestAnimationFrame(() => {
      // This overflow visible is needed for browsers that don't support PopoverElement
      // to ensure the menu and tooltips are visible when the action bar is in a collapsed state
      // once popover is fully supported we can remove this.style.overflow = 'visible'
      this.style.overflow = 'visible'
      this.update()
    })
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
        const idx = this.items.indexOf(element.parentElement!)
        const elementIsVisibleItem = idx > -1 && this.items[idx].style.visibility === 'visible'
        const elementIsVisibleActionMenuInvoker = element === this.moreMenu.invokerElement && !this.moreMenu.hidden
        return elementIsVisibleItem || elementIsVisibleActionMenuInvoker
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

  #showItem(index: number) {
    const item = this.items[index]
    const menuItem = this.#menuItems[index]
    if (!item || !menuItem) return
    item.style.setProperty('visibility', 'visible')
    menuItem.hidden = true
  }

  #hideItem(index: number) {
    const item = this.items[index]
    const menuItem = this.#menuItems[index]
    if (!item || !menuItem) return
    item.style.setProperty('visibility', 'hidden')
    menuItem.hidden = false
  }

  get #menuItems(): NodeListOf<HTMLElement> {
    return this.moreMenu.querySelectorAll('[role="menu"] > li')
  }

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
