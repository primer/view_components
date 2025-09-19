import {controller} from '@github/catalyst'

export class ActionListTruncationObserver {
  resizeObserver = new ResizeObserver(entries => {
    for (const entry of entries) {
      const action = entry.target

      if (action instanceof HTMLElement) {
        this.update(action)
      }
    }
  })

  constructor(el: HTMLElement) {
    this.resizeObserver.observe(el)
  }

  unobserve(el: HTMLElement) {
    this.resizeObserver.unobserve(el)
  }

  update(el: HTMLElement) {
    const items = el.querySelectorAll('li')

    for (const item of items) {
      const label = item.querySelector('.ActionListItem-label') as HTMLElement
      if (!label) continue
      const tooltip = item.querySelector('.ActionListItem-truncationTooltip') as HTMLElement
      if (!tooltip) continue

      const isTruncated = label.scrollWidth > label.clientWidth

      if (isTruncated) {
        tooltip.style.display = ''
      } else {
        tooltip.style.display = 'none'
      }
    }
  }
}

@controller
export class ActionListElement extends HTMLElement {
  #truncationObserver: ActionListTruncationObserver
  #abortController: AbortController

  connectedCallback() {
    this.#truncationObserver = new ActionListTruncationObserver(this)
    this.#abortController = new AbortController()
    this.#setupHoverMenus()
  }

  disconnectedCallback() {
    this.#truncationObserver.unobserve(this)
    this.#abortController.abort()
  }

  #setupHoverMenus() {
    const {signal} = this.#abortController
    const itemsWithHoverMenus = this.querySelectorAll('[data-has-hover-menu="true"]')

    for (const item of itemsWithHoverMenus) {
      const actionMenu = item.querySelector('action-menu')
      if (!actionMenu) continue

      let hideTimeout: number | null = null

      const showMenu = () => {
        if (hideTimeout) {
          clearTimeout(hideTimeout)
          hideTimeout = null
        }

        // For hover menus, we directly access the popover within the action-menu
        // since there's no invoker button that would normally provide the popover reference
        const popover = actionMenu.querySelector('[popover]') as HTMLElement & {showPopover(): void}
        if (popover && !popover.matches(':popover-open')) {
          popover.showPopover()
        }
      }

      const hideMenu = () => {
        hideTimeout = window.setTimeout(() => {
          const popover = actionMenu.querySelector('[popover]') as HTMLElement & {hidePopover(): void}
          if (popover && popover.matches(':popover-open')) {
            popover.hidePopover()
          }
        }, 200)
      }

      const cancelHide = () => {
        if (hideTimeout) {
          clearTimeout(hideTimeout)
          hideTimeout = null
        }
      }

      // Show menu when hovering over the item
      item.addEventListener('mouseenter', showMenu, {signal})

      // Hide menu when leaving the item, unless moving to the menu
      item.addEventListener(
        'mouseleave',
        (event: Event) => {
          const mouseEvent = event as MouseEvent
          const relatedTarget = mouseEvent.relatedTarget as HTMLElement
          if (!relatedTarget || !actionMenu.contains(relatedTarget)) {
            hideMenu()
          }
        },
        {signal},
      )

      // Keep menu open when hovering over the menu itself
      const popover = actionMenu.querySelector('[popover]')
      if (popover) {
        popover.addEventListener('mouseenter', cancelHide, {signal})
        popover.addEventListener('mouseleave', hideMenu, {signal})
      }
    }
  }
}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
