import {controller, target, targets} from '@github/catalyst'
import {ActionListElement} from './action_list_element'

@controller
class NavListElement extends ActionListElement {
  @target list: HTMLElement
  @target showMoreItem: HTMLElement
  @targets focusMarkers: HTMLElement[]

  connectedCallback(): void {
    if (this.arrowNavigation === true) {
      this.setupFocusZone()
    }

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
    const fragment = this.parseHTML(document, html)
    fragment?.querySelector('li > a')?.setAttribute('data-targets', 'nav-list.focusMarkers')
    this.list.insertBefore(fragment, this.showMoreItem)
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

  private parseHTML(document: Document, html: string): DocumentFragment {
    const template = document.createElement('template')
    // eslint-disable-next-line github/no-inner-html
    template.innerHTML = html
    return document.importNode(template.content, true)
  }
}

declare global {
  interface Window {
    NavListElement: typeof NavListElement
  }
}
