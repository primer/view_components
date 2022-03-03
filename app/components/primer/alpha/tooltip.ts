import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const TOOLTIP_OPEN_CLASS = 'tooltip-open'

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
type DirectionClass = typeof DIRECTION_CLASSES[number]

const DIRECTION_TO_CLASS: Record<Direction, DirectionClass> = {
  n: 'tooltip-n',
  s: 'tooltip-s',
  e: 'tooltip-e',
  w: 'tooltip-w',
  ne: 'tooltip-ne',
  se: 'tooltip-se',
  nw: 'tooltip-nw',
  sw: 'tooltip-sw'
}

class TooltipElement extends HTMLElement {
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
        white-space: normal
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
      
      :host(.tooltip-open),
      :host(.tooltip-open):before {
        animation-name: tooltip-appear;
        animation-duration: .1s;
        animation-fill-mode: forwards;
        animation-timing-function: ease-in;
        animation-delay: .4s
      }
      
      :host(.tooltip-s):before,
      :host(.tooltip-se):before,
      :host(.tooltip-sw):before {
        right: 50%;
        bottom: 100%;
        margin-right: -6px;
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
        right: 50%;
        margin-right: -6px;
        border-top-color: var(--color-neutral-emphasis-plus)
      }
      
      :host(.tooltip-n):after,
      :host(.tooltip-ne):after,
      :host(.tooltip-nw):after {
        top: 100%
      }
      
      :host(.tooltip-se):before,
      :host(.tooltip-ne):before {
        right: auto
      }
      
      :host(.tooltip-sw):before,
      :host(.tooltip-nw):before {
        right: 0;
        margin-right: 6px
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

  get control(): HTMLElement | null {
    return this.ownerDocument.getElementById(this.htmlFor)
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

  constructor() {
    super()
    const shadow = this.attachShadow({mode: 'open'})
    shadow.innerHTML = `
      <style>
        ${this.styles()}
      </style>
      <slot></slot>
    `
  }

  connectedCallback() {
    this.hidden = true
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
  }

  static observedAttributes = ['data-type', 'data-direction', 'id', 'hidden']

  attributeChangedCallback(name: string) {
    if (name === 'id' || name === 'data-type') {
      if (!this.id || !this.control) return
      if (this.type === 'label') {
        this.control.setAttribute('aria-labelledby', this.id)
      } else {
        let describedBy = this.control.getAttribute('aria-describedby')
        describedBy ? (describedBy = `${describedBy} ${this.id}`) : (describedBy = this.id)
        this.control.setAttribute('aria-describedby', describedBy)
      }
    } else if (name === 'hidden') {
      if (this.hidden) {
        this.classList.remove(TOOLTIP_OPEN_CLASS, ...DIRECTION_CLASSES)
      } else {
        this.classList.add(TOOLTIP_OPEN_CLASS)
        for (const tooltip of this.ownerDocument.querySelectorAll<HTMLElement>(this.tagName)) {
          if (tooltip !== this) tooltip.hidden = true
        }
        this.#updatePosition()
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

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  handleEvent(event: Event) {
    if (!this.control) return

    // Ensures that tooltip stays open when hovering between tooltip and element
    // WCAG Success Criterion 1.4.13 Hoverable
    if ((event.type === 'mouseenter' || event.type === 'focus') && this.hidden) {
      this.hidden = false
    } else if (event.type === 'blur') {
      this.hidden = true
    } else if (
      event.type === 'mouseleave' &&
      (event as MouseEvent).relatedTarget !== this.control &&
      (event as MouseEvent).relatedTarget !== this
    ) {
      this.hidden = true
    } else if (event.type === 'keydown' && (event as KeyboardEvent).key === 'Escape' && !this.hidden) {
      this.hidden = true
    }
  }

  // `getAnchoredPosition` may calibrate `anchoredSide` but does not recalibrate `align`.
  //  Therefore, we need to determine which `align` is best based on the initial `getAnchoredPosition` calcluation.
  //  Related: https://github.com/primer/behaviors/issues/63
  #adjustedAnchorAlignment(anchorSide: AnchorSide): AnchorAlignment | undefined {
    if (!this.control) return

    const tooltipPosition = this.getBoundingClientRect()
    const targetPosition = this.control.getBoundingClientRect()
    const tooltipWidth = tooltipPosition.width

    const tooltipCenter = tooltipPosition.left + tooltipWidth / 2
    const targetCenter = targetPosition.x + targetPosition.width / 2

    if (Math.abs(tooltipCenter - targetCenter) < 2 || anchorSide === 'outside-left' || anchorSide === 'outside-right') {
      return 'center'
    } else if (tooltipPosition.left === targetPosition.left) {
      return 'start'
    } else if (tooltipPosition.right === targetPosition.right) {
      return 'end'
    } else if (tooltipCenter < targetCenter) {
      if (tooltipPosition.left === 0) return 'start'
      return 'end'
    } else {
      if (tooltipPosition.right === 0) return 'end'
      return 'start'
    }
  }

  #updatePosition() {
    if (!this.control) return
    if (!this.#allowUpdatePosition || this.hidden) return

    const TOOLTIP_OFFSET = 10
    this.style.left = `0px` // Ensures we have reliable tooltip width in `getAnchoredPosition` calculation

    let position = getAnchoredPosition(this, this.control, {
      side: this.#side,
      align: this.#align,
      anchorOffset: TOOLTIP_OFFSET
    })
    let anchorSide = position.anchorSide

    // We need to set tooltip position in order to determine ideal align.
    this.style.top = `${position.top}px`
    this.style.left = `${position.left}px`
    let direction: Direction = 's'

    const align = this.#adjustedAnchorAlignment(anchorSide)
    if (!align) return

    position = getAnchoredPosition(this, this.control, {side: anchorSide, align, anchorOffset: TOOLTIP_OFFSET})
    anchorSide = position.anchorSide

    this.style.top = `${position.top}px`
    this.style.left = `${position.left}px`

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

    this.classList.add(DIRECTION_TO_CLASS[direction])
  }
}

if (!window.customElements.get('tool-tip')) {
  window.TooltipElement = TooltipElement
  window.customElements.define('tool-tip', TooltipElement)
}

declare global {
  interface Window {
    TooltipElement: typeof TooltipElement
  }
}
