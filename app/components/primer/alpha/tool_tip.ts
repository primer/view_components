import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const TOOLTIP_OPEN_CLASS = 'tooltip-open'
const TOOLTIP_ARROW_EDGE_OFFSET = 6
const TOOLTIP_SR_ONLY_CLASS = 'sr-only'

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

class ToolTipElement extends HTMLElement {
  styles() {
    return `
      :host {
        position: absolute;
        z-index: 1000000;
        padding: .5em .75em;
        font: normal normal 11px/1.5 -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
        -webkit-font-smoothing: subpixel-antialiased;
        color: var(--color-fg-on-emphasis);
        text-align: center;
        text-decoration: none;
        text-shadow: none;
        text-transform: none;
        letter-spacing: normal;
        word-wrap: break-word;
        white-space: pre;
        background: var(--color-neutral-emphasis-plus);
        border-radius: 6px;
        opacity: 0;
        max-width: 250px;
        word-wrap: break-word;
        white-space: normal;
        width: max-content;
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
          opacity: 0
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

      :host(.${TOOLTIP_OPEN_CLASS}),
      :host(.${TOOLTIP_OPEN_CLASS}):before {
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

  set hiddenFromView(value: true | false) {
    this.classList.toggle(TOOLTIP_SR_ONLY_CLASS, value)
    if (this.isConnected) this.#update()
  }

  get hiddenFromView() {
    return this.classList.contains(TOOLTIP_SR_ONLY_CLASS)
  }

  connectedCallback() {
    if (!this.shadowRoot) {
      const shadow = this.attachShadow({mode: 'open'})
      // eslint-disable-next-line github/no-inner-html
      shadow.innerHTML = `
        <style>
          ${this.styles()}
        </style>
        <slot></slot>
      `
    }
    this.hiddenFromView = true
    this.#allowUpdatePosition = true

    if (!this.id) {
      this.id = `tooltip-${Date.now()}-${(Math.random() * 10000).toFixed(0)}`
    }

    if (!this.control) return

    this.setAttribute('role', 'tooltip')

    this.#abortController?.abort()
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.addEventListener('mouseleave', this, {signal})
    this.control.addEventListener('mouseenter', this, {signal})
    this.control.addEventListener('mouseleave', this, {signal})
    this.control.addEventListener('focus', this, {signal})
    this.control.addEventListener('blur', this, {signal})
    this.ownerDocument.addEventListener('keydown', this, {signal})
    this.#update()
  }

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  handleEvent(event: Event) {
    if (!this.control) return

    // Ensures that tooltip stays open when hovering between tooltip and element
    // WCAG Success Criterion 1.4.13 Hoverable
    if ((event.type === 'mouseenter' || event.type === 'focus') && this.hiddenFromView) {
      this.hiddenFromView = false
    } else if (event.type === 'blur') {
      this.hiddenFromView = true
    } else if (
      event.type === 'mouseleave' &&
      (event as MouseEvent).relatedTarget !== this.control &&
      (event as MouseEvent).relatedTarget !== this
    ) {
      this.hiddenFromView = true
    } else if (event.type === 'keydown' && (event as KeyboardEvent).key === 'Escape' && !this.hiddenFromView) {
      this.hiddenFromView = true
    }
  }

  static observedAttributes = ['data-type', 'data-direction', 'id']

  #update() {
    if (this.hiddenFromView) {
      this.classList.remove(TOOLTIP_OPEN_CLASS, ...DIRECTION_CLASSES)
    } else {
      this.classList.add(TOOLTIP_OPEN_CLASS)
      for (const tooltip of this.ownerDocument.querySelectorAll<ToolTipElement>(this.tagName)) {
        if (tooltip !== this) tooltip.hiddenFromView = true
      }
      this.#updatePosition()
    }
  }

  attributeChangedCallback(name: string) {
    if (name === 'id' || name === 'data-type') {
      if (!this.id || !this.control) return
      if (this.type === 'label') {
        let labelledBy = this.control.getAttribute('aria-labelledby')
        if (labelledBy) {
          labelledBy = `${labelledBy} ${this.id}`
        } else {
          labelledBy = this.id
        }
        this.control.setAttribute('aria-labelledby', labelledBy)

        // Prevent duplicate accessible name announcements.
        this.setAttribute('aria-hidden', 'true')
      } else {
        let describedBy = this.control.getAttribute('aria-describedby')
        describedBy ? (describedBy = `${describedBy} ${this.id}`) : (describedBy = this.id)
        this.control.setAttribute('aria-describedby', describedBy)
      }
    } else if (name === 'data-direction') {
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
  }

  #updatePosition() {
    if (!this.control) return
    if (!this.#allowUpdatePosition || this.hiddenFromView) return

    const TOOLTIP_OFFSET = 10

    this.style.left = `0px` // Ensures we have reliable tooltip width in `getAnchoredPosition`

    const position = getAnchoredPosition(this, this.control, {
      side: this.#side,
      align: this.#align,
      anchorOffset: TOOLTIP_OFFSET
    })
    const anchorSide = position.anchorSide
    const align = position.anchorAlign

    this.style.top = `${position.top}px`
    this.style.left = `${position.left}px`

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
