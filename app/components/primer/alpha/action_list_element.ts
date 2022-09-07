/* eslint-disable custom-elements/expose-class-on-global */

import {FocusKeys, focusZone} from '@primer/behaviors'
import {attr, controller} from '@github/catalyst'
import type {FocusZoneSettings} from '@primer/behaviors'

@controller
export class ActionListElement extends HTMLElement {
  @attr arrowNavigation = false
  #actionListContentItems: HTMLElement[]
  #focusZoneAbortController: AbortController | null = null

  connectedCallback(): void {
    if (this.arrowNavigation === true) {
      this.setupFocusZone()
    }

    // On hashchange, add highlight to current target, if any.
    window.addEventListener('hashchange', () => {
      this.removeHighlightFromActiveItems()
      this.addHighlightToCurrentTarget()
    })
    this.addHighlightToCurrentTarget()
  }

  // only target <action-list> components with data-action "setupFocusZone"
  setupFocusZone() {
    if (this.#focusZoneAbortController) {
      this.#focusZoneAbortController.abort()
    }
    this.#actionListContentItems = Array.from(this.querySelectorAll('.ActionList-content'))
    this.#focusZoneAbortController = focusZone(this, {
      bindKeys: FocusKeys.ArrowAll | FocusKeys.HomeAndEnd,
      getNextFocusable: (direction, current: HTMLElement, event) => {
        if (current.tagName === 'BUTTON') {
          if (event.code === 'ArrowRight') {
            // if collapse item is already expanded, move focus to next visible item
            if (current.getAttribute('aria-expanded') === 'true') {
              return this.getNextVisibleItem(current)
            } else {
              // expand item, keep focus on current item
              this.expandItem(current)
              return current
            }
          } else if (event.code === 'ArrowLeft') {
            // if collapse item is already collapsed, move focus to next previous item
            if (current.getAttribute('aria-expanded') === 'false') {
              return this.getPreviousVisibleItem(current)
            } else {
              // collapse item, keep focus on current item
              this.collapseItem(current)
              return current
            }
          }
        }

        if (direction === 'next') {
          return this.getNextVisibleItem(current)
        } else if (direction === 'previous') {
          return this.getPreviousVisibleItem(current)
        }
      },
      // check for [hidden] attribute used on filtered out items
      focusableElementFilter: element => {
        return !element.closest('[hidden]')
      }
    } as FocusZoneSettings)
  }

  // get next item if item or parent item is hidden
  getNextVisibleItem(item: HTMLElement): HTMLElement | null {
    const index = this.#actionListContentItems.indexOf(item)
    if (index + 1 >= this.#actionListContentItems.length) {
      return null
    }

    const nextContentItem = this.#actionListContentItems[index + 1]
    const parentUList = this.getParentHiddenSubGroup(nextContentItem)
    if (nextContentItem.parentElement?.hidden || parentUList) {
      return this.getNextVisibleItem(nextContentItem)
    }
    return nextContentItem
  }

  // get previous item if item or parent item is hidden
  getPreviousVisibleItem(item: HTMLElement): HTMLElement | null {
    const index = this.#actionListContentItems.indexOf(item)
    if (index <= 0) {
      return null
    }

    const previousContentItem = this.#actionListContentItems[index - 1]
    const parentUList = this.getParentHiddenSubGroup(previousContentItem)
    if (previousContentItem.parentElement?.hidden || parentUList) {
      return this.getPreviousVisibleItem(previousContentItem)
    }

    return previousContentItem
  }

  // expand collapsible item onClick, or ArrowLeft/ArrowRight
  expandItem(item: HTMLElement) {
    item.nextElementSibling?.removeAttribute('data-hidden')
    item.setAttribute('aria-expanded', 'true')
  }

  collapseItem(item: HTMLElement) {
    item.nextElementSibling?.setAttribute('data-hidden', '')
    item.setAttribute('aria-expanded', 'false')
  }

  getParentHiddenSubGroup(item: HTMLElement) {
    return item?.closest('ul.ActionList--subGroup[data-hidden]') as HTMLUListElement
  }

  itemIsExpanded(item: HTMLElement | null) {
    if (item?.tagName === 'A') {
      return true
    }
    return item?.getAttribute('aria-expanded') === 'true'
  }

  // expand/collapse item
  handleItemWithSubItemClick(e: Event) {
    const target = e.target
    if (!(target instanceof HTMLElement)) return

    const button = target.closest<HTMLButtonElement>('button')
    if (!button) return
    if (this.itemIsExpanded(button)) {
      this.collapseItem(button)
    } else {
      this.expandItem(button)
    }

    e.stopPropagation()
  }

  // Apply active state
  handleItemClick(e: Event) {
    const target = e.target
    if (!(target instanceof HTMLElement)) return

    const item = target.closest<HTMLLIElement>('.ActionList-item')
    if (!item) return

    this.removeHighlightFromActiveItems()
    this.addHighlightToItem(item)
  }

  addHighlightToCurrentTarget(): void {
    if (window.location.hash === '') return
    const listItems = document.querySelectorAll<HTMLLIElement>('.ActionList-item')

    for (const listItem of listItems) {
      const listItemContentLink = listItem.querySelector<HTMLAnchorElement>('.ActionList-content')
      if (!listItemContentLink) continue
      if (listItemContentLink.hash !== window.location.hash) continue

      this.addHighlightToItem(listItem)
    }
  }

  addHighlightToItem(item: HTMLLIElement): void {
    item.classList.add('ActionList-item--navActive')
    item.setAttribute('aria-current', 'location')
    if (!item.classList.contains('ActionList-item--subItem')) return

    const itemGroup = item.closest('.ActionList-item--hasSubItem')
    if (!itemGroup) return

    // if item is in folder, add active class to folder button
    const groupButton = item.parentElement!.previousElementSibling
    groupButton?.classList.add('ActionList-content--hasActiveSubItem')
  }

  removeHighlightFromActiveItems(): void {
    const activeItems = document.querySelectorAll<HTMLLIElement>('.ActionList-item--navActive')

    for (const activeItem of activeItems) {
      this.removeHighlightFromActiveItem(activeItem)
    }

    const activeItemGroups = document.querySelectorAll<HTMLButtonElement>('.ActionList-content--hasActiveSubItem')
    for (const activeItemGroup of activeItemGroups) {
      activeItemGroup.classList.remove('ActionList-content--hasActiveSubItem')
    }
  }

  removeHighlightFromActiveItem(item: HTMLLIElement) {
    item.classList.remove('ActionList-item--navActive')
    item.removeAttribute('aria-current')
  }
}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
