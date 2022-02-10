import type {AnchorAlignment, AnchorSide} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const TOOLTIP_OPEN_CLASS = 'hx_tooltip-open'
const TOOLTIP_CLASS = 'hx_tooltip'
const TOOLTIP_ARROW_MARGIN = 6

type Direction = 'n' | 's' | 'e' | 'w' | 'ne' | 'se' | 'nw' | 'sw'

const DIRECTION_CLASSES = [
  'hx_tooltip-n',
  'hx_tooltip-s',
  'hx_tooltip-e',
  'hx_tooltip-w',
  'hx_tooltip-ne',
  'hx_tooltip-se',
  'hx_tooltip-nw',
  'hx_tooltip-sw'
]
type DirectionClass = typeof DIRECTION_CLASSES[number]

const DIRECTION_TO_CLASS: Record<Direction, DirectionClass> = {
  n: 'hx_tooltip-n',
  s: 'hx_tooltip-s',
  e: 'hx_tooltip-e',
  w: 'hx_tooltip-w',
  ne: 'hx_tooltip-ne',
  se: 'hx_tooltip-se',
  nw: 'hx_tooltip-nw',
  sw: 'hx_tooltip-sw'
}

class PrimerTooltipElement extends HTMLElement {
  static observedAttributes = ['data-type', 'data-direction', 'id', 'hidden']

  #abortController: AbortController

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

  #direction: Direction = 's'
  get direction(): Direction {
    return this.#direction
  }

  set direction(value: Direction) {
    this.setAttribute('data-direction', value)
  }

  #align: AnchorAlignment = 'center'
  get align(): AnchorAlignment {
    return this.#align
  }

  #side: AnchorSide = 'outside-bottom'
  get side(): AnchorSide {
    return this.#side
  }

  #allowUpdatePosition = false

  connectedCallback() {
    this.hidden = true
    this.#allowUpdatePosition = true

    if (!this.id) {
      this.id = `tooltip-${Date.now()}-${(Math.random() * 10000).toFixed(0)}`
    }

    if (!this.control) return

    this.classList.add(TOOLTIP_CLASS)
    this.setAttribute('role', 'tooltip')

    this.addEvents()
  }

  attributeChangedCallback(name: string, oldValue: string | null, newValue: string | null) {
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
      const hidden = newValue === ''
      if (hidden) {
        this.classList.remove(TOOLTIP_OPEN_CLASS, ...DIRECTION_CLASSES)
      } else {
        this.classList.add(TOOLTIP_OPEN_CLASS, TOOLTIP_CLASS)
        for (const tooltip of this.ownerDocument.querySelectorAll<HTMLElement>(this.tagName)) {
          if (tooltip !== this) tooltip.hidden = true
        }
        this.updatePosition()
      }
    } else if (name === 'data-direction') {
      this.classList.remove(...DIRECTION_CLASSES)
      const direction = (this.#direction = (newValue || 's') as Direction)
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
      this.updatePosition()
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  private addEvents() {
    if (!this.control) return

    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.addEventListener('mouseleave', this, {signal})
    this.control.addEventListener('mouseenter', this, {signal})
    this.control.addEventListener('mouseleave', this, {signal})
    this.control.addEventListener('focus', this, {signal})
    this.control.addEventListener('blur', this, {signal})
    this.ownerDocument.addEventListener('keydown', this, {signal})
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

  private updatePosition() {
    if (!this.control) return
    if (!this.#allowUpdatePosition || this.hidden) return

    const position = getAnchoredPosition(this, this.control, this)
    const {anchorSide} = position
    let {top, left} = position
    // We must set new tooltip position before we can predict alignment.
    this.style.top = `${top}px`
    this.style.left = `${left}px`

    const tooltipPosition = this.getBoundingClientRect()
    const targetPosition = this.control.getBoundingClientRect()
    const tooltipWidth = tooltipPosition.width

    const tooltipCenter = tooltipPosition.left + tooltipWidth / 2
    const targetCenter = targetPosition.x + targetPosition.width / 2
    const centerDiff = Math.abs(tooltipCenter - targetCenter)

    const startDiff = Math.abs(tooltipPosition.left - targetPosition.x)
    const endDiff = Math.abs(tooltipPosition.left + tooltipWidth - targetPosition.right)
    const smallestDiff = Math.min(centerDiff, startDiff, endDiff)

    if (smallestDiff === centerDiff) {
      this.#align = 'center'
      if (anchorSide === 'outside-top') {
        this.#direction = 'n'
        top -= TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-bottom') {
        this.#direction = 's'
        top += TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-left') {
        this.#direction = 'w'
        left -= TOOLTIP_ARROW_MARGIN
      } else {
        this.#direction = 'e'
        left += TOOLTIP_ARROW_MARGIN
      }
    } else if (smallestDiff === endDiff) {
      this.#align = 'end'
      if (anchorSide === 'outside-top') {
        this.#direction = 'nw'
        top -= TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-bottom') {
        this.#direction = 'sw'
        top += TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-left') {
        this.#direction = 'w'
        left -= TOOLTIP_ARROW_MARGIN
      } else {
        this.#direction = 'e'
        left += TOOLTIP_ARROW_MARGIN
      }
    } else {
      this.#align = 'start'
      if (anchorSide === 'outside-top') {
        this.#direction = 'ne'
        top -= TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-bottom') {
        this.#direction = 'se'
        top += TOOLTIP_ARROW_MARGIN
      } else if (anchorSide === 'outside-left') {
        this.#direction = 'w'
        left -= TOOLTIP_ARROW_MARGIN
      } else {
        this.#direction = 'e'
        left += TOOLTIP_ARROW_MARGIN
      }
    }

    this.style.top = `${top}px`
    this.style.left = `${left}px`

    this.classList.add(DIRECTION_TO_CLASS[this.direction])
  }
}

if (!window.customElements.get('primer-tooltip')) {
  window.PrimerTooltipElement = PrimerTooltipElement
  window.customElements.define('primer-tooltip', PrimerTooltipElement)
}

declare global {
  interface Window {
    PrimerTooltipElement: typeof PrimerTooltipElement
  }
}
