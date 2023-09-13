/* eslint-disable custom-elements/expose-class-on-global */
import {controller, target, targets} from '@github/catalyst'

@controller
export class NavListAlphaElement extends HTMLElement {
  @targets items: HTMLElement[]
  @target showMoreItem: HTMLElement
  @targets focusMarkers: HTMLElement[]

  connectedCallback(): void {
    this.setShowMoreItemState()
  }

  get showMoreDisabled(): boolean {
    return this.showMoreItem.hasAttribute('aria-disabled')
  }

  set showMoreDisabled(value: boolean) {
    if (value) {
      this.showMoreItem.setAttribute('aria-disabled', 'true')
    } else {
      this.showMoreItem.removeAttribute('aria-disabled')
    }
    this.showMoreItem.classList.toggle('disabled', value)
  }

  set currentPage(value: number) {
    this.showMoreItem.setAttribute('data-current-page', value.toString())
  }

  get currentPage(): number {
    return parseInt(this.showMoreItem.getAttribute('data-current-page') as string) || 1
  }

  get totalPages(): number {
    return parseInt(this.showMoreItem.getAttribute('data-total-pages') as string) || 1
  }

  get paginationSrc(): string {
    return this.showMoreItem.getAttribute('src') || ''
  }

  selectItemById(itemId: string | null): boolean {
    if (!itemId) return false

    const selectedItem = this.#findSelectedNavItemById(itemId)

    if (selectedItem) {
      this.#select(selectedItem)
      return true
    }

    return false
  }

  selectItemByHref(href: string | null): boolean {
    if (!href) return false

    const selectedItem = this.#findSelectedNavItemByHref(href)

    if (selectedItem) {
      this.#select(selectedItem)
      return true
    }

    return false
  }

  selectItemByCurrentLocation(): boolean {
    const selectedItem = this.#findSelectedNavItemByCurrentLocation()

    if (selectedItem) {
      this.#select(selectedItem)
      return true
    }

    return false
  }

  // expand collapsible item onClick
  expandItem(item: HTMLElement) {
    item.nextElementSibling?.removeAttribute('data-hidden')
    item.setAttribute('aria-expanded', 'true')
  }

  collapseItem(item: HTMLElement) {
    item.nextElementSibling?.setAttribute('data-hidden', '')
    item.setAttribute('aria-expanded', 'false')
    item.focus()
  }

  itemIsExpanded(item: HTMLElement | null) {
    if (item?.tagName === 'A') {
      return true
    }
    return item?.getAttribute('aria-expanded') === 'true'
  }

  // expand/collapse item
  handleItemWithSubItemClick(e: Event) {
    const el = e.target
    if (!(el instanceof HTMLElement)) return

    const button = el.closest<HTMLButtonElement>('button')
    if (!button) return
    if (this.itemIsExpanded(button)) {
      this.collapseItem(button)
    } else {
      this.expandItem(button)
    }

    e.stopPropagation()
  }

  // collapse item
  handleItemWithSubItemKeydown(e: KeyboardEvent) {
    const el = e.currentTarget
    if (!(el instanceof HTMLElement)) return

    let button = el.closest<HTMLButtonElement>('button')
    if (!button) {
      const button_id = el.getAttribute('aria-labelledby')
      if (button_id) {
        button = document.getElementById(button_id) as HTMLButtonElement
      } else {
        return
      }
    }

    if (this.itemIsExpanded(button) && e.key === 'Escape') {
      this.collapseItem(button)
    }

    e.stopPropagation()
  }

  private async showMore(e: Event) {
    e.preventDefault()
    if (this.showMoreDisabled) return
    this.showMoreDisabled = true
    let html
    try {
      const paginationURL = new URL(this.paginationSrc, window.location.origin)
      this.currentPage++
      paginationURL.searchParams.append('page', this.currentPage.toString())
      const response = await fetch(paginationURL)
      if (!response.ok) return
      html = await response.text()
      if (this.currentPage === this.totalPages) {
        this.showMoreItem.hidden = true
      }
    } catch (err) {
      // Ignore network errors
      this.showMoreDisabled = false
      this.currentPage--
      return
    }
    const fragment = this.#parseHTML(document, html)
    fragment?.querySelector('li > a')?.setAttribute('data-targets', 'nav-list.focusMarkers')
    const listId = (e.target as HTMLElement).closest('button')!.getAttribute('data-list-id')!
    const list = document.getElementById(listId)!
    list.append(fragment)
    this.focusMarkers.pop()?.focus()
    this.showMoreDisabled = false
  }

  private setShowMoreItemState() {
    if (!this.showMoreItem) {
      return
    }

    if (this.currentPage < this.totalPages) {
      this.showMoreItem.hidden = false
    } else {
      this.showMoreItem.hidden = true
    }
  }

  #parseHTML(document: Document, html: string): DocumentFragment {
    const template = document.createElement('template')
    // eslint-disable-next-line github/no-inner-html
    template.innerHTML = html
    return document.importNode(template.content, true)
  }

  #findSelectedNavItemById(itemId: string): HTMLElement | null {
    // First we compare the selected link to data-item-id for each nav item
    for (const navItem of this.items) {
      if (navItem.classList.contains('ActionListItem--hasSubItem')) {
        continue
      }

      const keys = navItem.getAttribute('data-item-id')?.split(' ') || []

      if (keys.includes(itemId)) {
        return navItem
      }
    }

    return null
  }

  #findSelectedNavItemByHref(href: string): HTMLElement | null {
    // If we didn't find a match, we compare the selected link to the href of each nav item
    const selectedNavItem = this.querySelector<HTMLAnchorElement>(`.ActionListContent[href="${href}"]`)
    if (selectedNavItem) {
      return selectedNavItem.closest('.ActionListItem')
    }

    return null
  }

  #findSelectedNavItemByCurrentLocation(): HTMLElement | null {
    return this.#findSelectedNavItemByHref(window.location.pathname)
  }

  #select(navItem: HTMLElement) {
    const currentlySelectedItem = this.querySelector('.ActionListItem--navActive') as HTMLElement
    if (currentlySelectedItem) this.#deselect(currentlySelectedItem)

    navItem.classList.add('ActionListItem--navActive')

    if (navItem.children.length > 0) {
      navItem.children[0].setAttribute('aria-current', 'page')
    }

    const parentMenu = this.#findParentMenu(navItem)

    if (parentMenu) {
      this.expandItem(parentMenu)
      parentMenu.classList.add('ActionListContent--hasActiveSubItem')
    }
  }

  #deselect(navItem: HTMLElement) {
    navItem.classList.remove('ActionListItem--navActive')

    if (navItem.children.length > 0) {
      navItem.children[0].removeAttribute('aria-current')
    }

    const parentMenu = this.#findParentMenu(navItem)

    if (parentMenu) {
      this.collapseItem(parentMenu)
      parentMenu.classList.remove('ActionListContent--hasActiveSubItem')
    }
  }

  #findParentMenu(navItem: HTMLElement): HTMLElement | null {
    if (!navItem.classList.contains('ActionListItem--subItem')) return null

    const parent = navItem.closest('li.ActionListItem--hasSubItem')?.querySelector('button.ActionListContent')

    if (parent) {
      return parent as HTMLElement
    } else {
      return null
    }
  }
}

declare global {
  interface Window {
    NavListAlphaElement: typeof NavListAlphaElement
  }
}
