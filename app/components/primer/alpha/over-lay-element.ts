import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

// <over-lay open data-anchor-align="start" data-anchor-side="outside-bottom">

class OverLayElement extends HTMLElement {
  #abortController: AbortController

  get anchorAlign(): AnchorAlignment {
    return (this.getAttribute('data-anchor-align') || 'start') as AnchorAlignment
  }

  get anchorSide(): AnchorSide {
    return (this.getAttribute('data-anchor-side') || 'outside-bottom') as AnchorSide
  }

  // use data attribute
  get trigger(): HTMLButtonElement | null {
    return this.querySelector<HTMLButtonElement>('button')
  }

  // get overlay(): HTMLDivElement | null {
  //   return this.querySelector<HTMLDivElement>('.Overlay')
  // }

  get open() {
    return this.hasAttribute('open')
  }

  // open: true
  // - set the position
  // - remove Overlay--visibilityHidden
  //
  // open: false
  // - set Overlay--visibilityHidden
  set open(value: boolean) {
    const initialBodyWidth = document.body.clientWidth
    const observer = new ResizeObserver(entries => {
      for (const entry of entries) {
        if (initialBodyWidth !== entry.contentRect.width && this.open) {
          this.#updatePosition()
        }
      }
    })

    if (value) {
      if (this.open) return
      if (!this.trigger) return
      this.setAttribute('open', '')

      this.#updatePosition()
      // If the window width is changed when the menu is open,
      // this keeps the menu aligned to the button
      observer.observe(document.body)
      this.classList.remove('Overlay--visibilityHidden')
    } else {
      if (!this.open) return
      this.removeAttribute('open')
      this.classList.add('Overlay--visibilityHidden')
      observer.unobserve(document.body)

      // TODO: Do this without a setTimeout
      setTimeout(() => {
        // There are some actions that may move focus to another part of the page intentionally.
        // For example: "Quote Reply" in the comment options moves focus to the comment box.
        // This only moves focus to the trigger if it's not managed in another way.
        if (document.activeElement === document.body) this.trigger?.focus()
      }, 1)
    }
  }

  connectedCallback() {
    if (!this.trigger) return
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  show() {
    this.open = true
  }

  hide() {
    this.open = false
  }

  // #addEvents() {
  //   this.#abortController = new AbortController()
  //   const {signal} = this.#abortController

  //   if (!this.trigger) return

  //   // this.trigger.addEventListener('keydown', this.buttonKeydown.bind(this), {signal})
  //   // this.trigger.addEventListener('click', this.buttonClick.bind(this), {signal})
  // }

  #updatePosition() {
    if (!this.trigger) return

    const float = this.querySelector<HTMLElement>('[data-menu-overlay]')
    const anchor = this.trigger
    const {top, left} = getAnchoredPosition(float, anchor, {side: this.anchorSide, align: this.anchorAlign})

    float.style.top = `${top}px`
    float.style.left = `${left}px`
  }

  //   // Menu event handlers
  //   buttonKeydown(event: KeyboardEvent) {
  //     // TODO: use data-hotkey
  //     // eslint-disable-next-line no-restricted-syntax
  //     const key = event.key
  //     let flag = false

  //     switch (key) {
  //       case ' ':
  //       case 'Enter':
  //       case 'ArrowDown':
  //       case 'Down':
  //         this.show()
  //         this.setFocusToMenuItem(this.#firstMenuItem)
  //         flag = true
  //         break

  //       case 'Esc':
  //       case 'Escape':
  //         this.hide()
  //         flag = true
  //         break

  //       case 'Up':
  //       case 'ArrowUp':
  //         this.show()
  //         this.setFocusToMenuItem(this.#lastMenuItem)
  //         flag = true
  //         break

  //       default:
  //         break
  //     }

  //     if (flag) {
  //       event.stopPropagation()
  //       event.preventDefault()
  //     }
  //   }

  //   buttonClick(event: MouseEvent) {
  //     if (this.open) {
  //       this.hide()
  //     } else {
  //       this.show()
  //       this.setFocusToMenuItem(this.#firstMenuItem)
  //     }

  //     event.stopPropagation()
  //     event.preventDefault()
  //   }
  // }
}

if (!window.customElements.get('over-lay')) {
  window.OverLayElement = OverLayElement
  window.customElements.define('over-lay', OverLayElement)
}

declare global {
  interface Window {
    OverLayElement: typeof OverLayElement
  }
}
