import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import '@oddbird/popover-polyfill'
import {getAnchoredPosition} from '@primer/behaviors'

const TOOLTIP_ARROW_EDGE_OFFSET = 6
const TOOLTIP_SR_ONLY_CLASS = 'sr-only'
const TOOLTIP_OFFSET = 10

type Direction = 'n' | 's' | 'e' | 'w' | 'ne' | 'se' | 'nw' | 'sw'

const DIRECTION_CLASSES = [
  'tooltip-n',
  'tooltip-s',
  'tooltip-e',
  'tooltip-w',
  'tooltip-ne',
  'tooltip-se',
  'tooltip-nw',
  'tooltip-sw'
]

function closeOpenTooltips(except?: Element) {
  for (const tooltip of openTooltips) {
    if (tooltip === except) continue
    if (tooltip.matches(':popover-open')) {
      tooltip.hidePopover()
    } else {
      openTooltips.delete(tooltip)
    }
  }
}

function focusOutListener() {
  closeOpenTooltips()
}

const tooltips = new Set<ToolTipElement>()
const openTooltips = new Set<ToolTipElement>()
class ToolTipElement extends HTMLElement {
  styles() {
    return `
      :host {
        padding: .5em .75em !important;
        font: normal normal 11px/1.5 -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
        -webkit-font-smoothing: subpixel-antialiased;
        color: var(--color-fg-on-emphasis) !important;
        text-align: center;
        text-decoration: none;
        text-shadow: none;
        text-transform: none;
        letter-spacing: normal;
        word-wrap: break-word;
        white-space: pre;
        background: var(--color-neutral-emphasis-plus) !important;
        border-radius: 6px;
        border: 0 !important;
        opacity: 0;
        max-width: 250px;
        word-wrap: break-word;
        white-space: normal;
        width: max-content !important;
        inset: var(--tool-tip-position-top, 0) auto auto var(--tool-tip-position-left, 0) !important;
        overflow: visible !important;
      }

      :host:before{
        position: absolute;
        z-index: 1000001;
        color: var(--color-neutral-emphasis-plus);
        content: "";
        border: 6px solid transparent;
        opacity: 0
      }

      @keyframes tooltip-appear {
        from {
          opacity: 0;
        }
        to {
          opacity: 1
        }
      }

      :host:after{
        position: absolute;
        display: block;
        right: 0;
        left: 0;
        height: 12px;
        content: ""
      }

      :host(:popover-open),
      :host(:popover-open):before {
        animation-name: tooltip-appear;
        animation-duration: .1s;
        animation-fill-mode: forwards;
        animation-timing-function: ease-in;
        animation-delay: .4s
      }

      :host(.\\:popover-open),
      :host(.\\:popover-open):before {
        animation-name: tooltip-appear;
        animation-duration: .1s;
        animation-fill-mode: forwards;
        animation-timing-function: ease-in;
        animation-delay: .4s
      }

      :host(.tooltip-s):before,
      :host(.tooltip-n):before {
        right: 50%;
        margin-right: -${TOOLTIP_ARROW_EDGE_OFFSET}px;
      }

      :host(.tooltip-s):before,
      :host(.tooltip-se):before,
      :host(.tooltip-sw):before {
        bottom: 100%;
        border-bottom-color: var(--color-neutral-emphasis-plus)
      }

      :host(.tooltip-s):after,
      :host(.tooltip-se):after,
      :host(.tooltip-sw):after {
        bottom: 100%
      }

      :host(.tooltip-n):before,
      :host(.tooltip-ne):before,
      :host(.tooltip-nw):before {
        top: 100%;
        border-top-color: var(--color-neutral-emphasis-plus)
      }

      :host(.tooltip-n):after,
      :host(.tooltip-ne):after,
      :host(.tooltip-nw):after {
        top: 100%
      }

      :host(.tooltip-se):before,
      :host(.tooltip-ne):before {
        left: 0;
        margin-left: ${TOOLTIP_ARROW_EDGE_OFFSET}px;
      }

      :host(.tooltip-sw):before,
      :host(.tooltip-nw):before {
        right: 0;
        margin-right: ${TOOLTIP_ARROW_EDGE_OFFSET}px;
      }

      :host(.tooltip-w):before {
        top: 50%;
        bottom: 50%;
        left: 100%;
        margin-top: -6px;
        border-left-color: var(--color-neutral-emphasis-plus)
      }

      :host(.tooltip-e):before {
        top: 50%;
        right: 100%;
        bottom: 50%;
        margin-top: -6px;
        border-right-color: var(--color-neutral-emphasis-plus)
      }
    `
  }

  #abortController: AbortController | undefined
  #align: AnchorAlignment = 'center'
  #side: AnchorSide = 'outside-bottom'
  #allowUpdatePosition = false

  get htmlFor(): string {
    return this.getAttribute('for') || ''
  }

  set htmlFor(value: string) {
    this.setAttribute('for', value)
  }

  get type(): 'description' | 'label' {
    const type = this.getAttribute('data-type')
    return type === 'label' ? 'label' : 'description'
  }

  set type(value: 'description' | 'label') {
    this.setAttribute('data-type', value)
  }

  get direction(): Direction {
    return (this.getAttribute('data-direction') || 's') as Direction
  }

  set direction(value: Direction) {
    this.setAttribute('data-direction', value)
  }

  get control(): HTMLElement | null {
    return this.ownerDocument.getElementById(this.htmlFor)
  }

  /* @deprecated */
  set hiddenFromView(value: true | false) {
    if (value && this.matches(':popover-open')) {
      this.hidePopover()
    } else if (!value && this.matches(':not(:popover-open)')) {
      this.showPopover()
    }
  }

  /* @deprecated */
  get hiddenFromView() {
    return !this.matches(':popover-open')
  }

  connectedCallback() {
    tooltips.add(this)
    this.#updateControlReference()
    this.#updateDirection()
    if (!this.shadowRoot) {
      const shadow = this.attachShadow({mode: 'open'})
      const style = shadow.appendChild(document.createElement('style'))
      style.textContent = this.styles()
      shadow.appendChild(document.createElement('slot'))
    }
    this.#update(false)
    this.#allowUpdatePosition = true

    if (!this.control) return

    this.setAttribute('role', 'tooltip')

    this.#abortController?.abort()
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.addEventListener('mouseleave', this, {signal})
    this.addEventListener('toggle', this, {signal})
    this.control.addEventListener('mouseenter', this, {signal})
    this.control.addEventListener('mouseleave', this, {signal})
    this.control.addEventListener('focus', this, {signal})
    this.control.addEventListener('mousedown', this, {signal})
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore popoverTargetElement is not in the type definition
    this.control.popoverTargetElement?.addEventListener('beforetoggle', this, {
      signal
    })
    this.ownerDocument.addEventListener('focusout', focusOutListener)
    this.ownerDocument.addEventListener('keydown', this, {signal})
  }

  disconnectedCallback() {
    tooltips.delete(this)
    openTooltips.delete(this)
    this.#abortController?.abort()
  }

  async handleEvent(event: Event) {
    if (!this.control) return
    const showing = this.matches(':popover-open')

    // Ensures that tooltip stays open when hovering between tooltip and element
    // WCAG Success Criterion 1.4.13 Hoverable
    const shouldShow = event.type === 'mouseenter' || event.type === 'focus'
    const isMouseLeaveFromButton =
      event.type === 'mouseleave' &&
      (event as MouseEvent).relatedTarget !== this.control &&
      (event as MouseEvent).relatedTarget !== this
    const isEscapeKeydown = event.type === 'keydown' && (event as KeyboardEvent).key === 'Escape'
    const isMouseDownOnButton = event.type === 'mousedown' && event.currentTarget === this.control
    const isOpeningOtherPopover = event.type === 'beforetoggle' && event.currentTarget !== this
    const shouldHide = isMouseLeaveFromButton || isEscapeKeydown || isMouseDownOnButton || isOpeningOtherPopover

    await Promise.resolve()
    if (!showing && shouldShow && this.matches(':not(:popover-open)')) {
      this.showPopover()
    } else if (showing && shouldHide && this.matches(':popover-open')) {
      this.hidePopover()
    }

    if (event.type === 'toggle') {
      this.#update((event as ToggleEvent).newState === 'open')
    }
  }

  static observedAttributes = ['data-type', 'data-direction', 'id']

  #update(isOpen: boolean) {
    if (isOpen) {
      openTooltips.add(this)
      this.classList.remove(TOOLTIP_SR_ONLY_CLASS)
      closeOpenTooltips(this)
      this.#updatePosition()
    } else {
      openTooltips.delete(this)
      this.classList.remove(...DIRECTION_CLASSES)
      this.classList.add(TOOLTIP_SR_ONLY_CLASS)
    }
  }

  attributeChangedCallback(name: string) {
    if (!this.isConnected) return

    if (name === 'id' || name === 'data-type') {
      this.#updateControlReference()
    } else if (name === 'data-direction') {
      this.#updateDirection()
    }
  }

  #updateControlReference() {
    if (!this.id || !this.control) return
    if (this.type === 'label') {
      let labelledBy = this.control.getAttribute('aria-labelledby')
      if (labelledBy) {
        if (!labelledBy.split(' ').includes(this.id)) {
          labelledBy = `${labelledBy} ${this.id}`
        } else {
          labelledBy = `${labelledBy}`
        }
      } else {
        labelledBy = this.id
      }
      this.control.setAttribute('aria-labelledby', labelledBy)

      // Prevent duplicate accessible name announcements.
      this.setAttribute('aria-hidden', 'true')
    } else {
      let describedBy = this.control.getAttribute('aria-describedby')
      if (describedBy) {
        if (!describedBy.split(' ').includes(this.id)) {
          describedBy = `${describedBy} ${this.id}`
        } else {
          describedBy = `${describedBy}`
        }
      } else {
        describedBy = this.id
      }
      this.control.setAttribute('aria-describedby', describedBy)
    }
  }

  #updateDirection() {
    this.classList.remove(...DIRECTION_CLASSES)
    const direction = this.direction
    if (direction === 'n') {
      this.#align = 'center'
      this.#side = 'outside-top'
    } else if (direction === 'ne') {
      this.#align = 'start'
      this.#side = 'outside-top'
    } else if (direction === 'e') {
      this.#align = 'center'
      this.#side = 'outside-right'
    } else if (direction === 'se') {
      this.#align = 'start'
      this.#side = 'outside-bottom'
    } else if (direction === 's') {
      this.#align = 'center'
      this.#side = 'outside-bottom'
    } else if (direction === 'sw') {
      this.#align = 'end'
      this.#side = 'outside-bottom'
    } else if (direction === 'w') {
      this.#align = 'center'
      this.#side = 'outside-left'
    } else if (direction === 'nw') {
      this.#align = 'end'
      this.#side = 'outside-top'
    }
  }

  #updatePosition() {
    if (!this.control) return
    if (!this.#allowUpdatePosition || !this.matches(':popover-open')) return

    const position = getAnchoredPosition(this, this.control, {
      side: this.#side,
      align: this.#align,
      anchorOffset: TOOLTIP_OFFSET
    })
    const anchorSide = position.anchorSide
    const align = position.anchorAlign

    this.style.setProperty('--tool-tip-position-top', `${position.top}px`)
    this.style.setProperty('--tool-tip-position-left', `${position.left}px`)

    let direction: Direction = 's'

    if (anchorSide === 'outside-left') {
      direction = 'w'
    } else if (anchorSide === 'outside-right') {
      direction = 'e'
    } else if (anchorSide === 'outside-top') {
      if (align === 'center') {
        direction = 'n'
      } else if (align === 'start') {
        direction = 'ne'
      } else {
        direction = 'nw'
      }
    } else {
      if (align === 'center') {
        direction = 's'
      } else if (align === 'start') {
        direction = 'se'
      } else {
        direction = 'sw'
      }
    }

    this.classList.add(`tooltip-${direction}`)
  }
}

if (!window.customElements.get('tool-tip')) {
  window.ToolTipElement = ToolTipElement
  window.customElements.define('tool-tip', ToolTipElement)
}

declare global {
  interface Window {
    ToolTipElement: typeof ToolTipElement
  }
}
