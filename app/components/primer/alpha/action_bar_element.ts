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
    const firstItemTop = this.items[0].getBoundingClientRect().top

    for (let i = 0; i < this.items.length; i++) {
      const item = this.items[i]
      const itemTop = item.getBoundingClientRect().top

      if (itemTop > firstItemTop) {
        this.#hideItem(i)

        if (this.moreMenu.hidden) {
          this.moreMenu.hidden = false
        }
      } else {
        this.#showItem(i)

        if (i === this.items.length - 1) {
          this.moreMenu.hidden = true
        }
      }
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

  #showItem(index: number) {
    this.items[index].style.setProperty('visibility', 'visible')
    this.#menuItems[index]!.hidden = true
  }

  #hideItem(index: number) {
    this.items[index].style.setProperty('visibility', 'hidden')
    this.#menuItems[index]!.hidden = false
  }

  get #menuItems(): NodeListOf<HTMLElement> {
    return this.moreMenu.querySelectorAll('[role="menu"] > li.ActionListItem')
  }
}

declare global {
  interface Window {
    ActionBarElement: typeof ActionBarElement
  }
}

window.ActionBarElement = ActionBarElement
