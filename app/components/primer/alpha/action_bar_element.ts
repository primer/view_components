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

@controller('action-bar')
class ActionBarElement extends HTMLElement {
  @targets items: HTMLElement[]
  @target itemContainer: HTMLElement
  @target moreMenu: ActionMenuElement

  #focusZoneAbortController: AbortController | null = null
  #pendingUpdate = false

  connectedCallback() {
    resizeObserver.observe(this)
    instersectionObserver.observe(this)

    // This overflow visible is needed for browsers that don't support PopoverElement
    // to ensure the menu and tooltips are visible when the action bar is in a collapsed state
    // once popover is fully supported we can remove this.style.overflow = 'visible'
    this.style.overflow = 'visible'
    this.update()
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
    if (this.#pendingUpdate) return
    this.#pendingUpdate = true
    requestAnimationFrame(() => {
      this.#pendingUpdate = false
      this.#performUpdate()
    })
  }

  #performUpdate() {
    const firstItem = this.#firstItem
    if (!firstItem) return

    const baseTop = firstItem.getBoundingClientRect().top
    const cachedMenuItems = this.#menuItems

    // Snapshot geometry in one pass before mutating the DOM
    const snapshots = Array.from(this.items, el => ({
      top: el.getBoundingClientRect().top,
      isDivider: el.classList.contains('ActionBar-divider'),
    }))

    // Apply visibility changes after all reads are complete
    let prevWasDivider = false
    for (let n = 0; n < snapshots.length; n++) {
      const snap = snapshots[n]
      if (snap.isDivider) {
        prevWasDivider = true
        continue
      }

      if (snap.top > baseTop) {
        this.#hideItem(n, cachedMenuItems)
        if (this.moreMenu.hidden) this.moreMenu.hidden = false
        if (prevWasDivider) this.#hideItem(n - 1, cachedMenuItems)
      } else {
        this.#showItem(n, cachedMenuItems)
        if (n === this.items.length - 1) this.moreMenu.hidden = true
        if (prevWasDivider) this.#showItem(n - 1, cachedMenuItems)
      }

      prevWasDivider = false
    }

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
    return this.items.find(el => !el.classList.contains('ActionBar-divider')) ?? null
  }

  #showItem(index: number, menuItems: NodeListOf<HTMLElement>) {
    const item = this.items[index]
    const menuItem = menuItems[index]
    if (!item || !menuItem) return
    item.style.setProperty('visibility', 'visible')
    menuItem.hidden = true
  }

  #hideItem(index: number, menuItems: NodeListOf<HTMLElement>) {
    const item = this.items[index]
    const menuItem = menuItems[index]
    if (!item || !menuItem) return
    item.style.setProperty('visibility', 'hidden')
    menuItem.hidden = false
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
