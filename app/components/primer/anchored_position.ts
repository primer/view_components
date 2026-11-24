import type {AnchorAlignment, AnchorSide, PositionSettings} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const alternateSides: Partial<Record<AnchorSide, AnchorSide[]>> = {
  'outside-top': ['outside-bottom', 'outside-right', 'outside-left', 'outside-bottom'],
  'outside-bottom': ['outside-top', 'outside-right', 'outside-left', 'outside-bottom'],
  'outside-left': ['outside-right', 'outside-bottom', 'outside-top', 'outside-bottom'],
  'outside-right': ['outside-left', 'outside-bottom', 'outside-top', 'outside-bottom'],
}
const alternateAlignments: Record<AnchorAlignment, AnchorAlignment[]> = {
  start: ['end', 'center'],
  end: ['start', 'center'],
  center: ['end', 'start'],
}

const updateWhenVisible = (() => {
  const anchors = new Set<AnchoredPositionElement>()
  let intersectionObserver: IntersectionObserver | null = null
  let resizeObserver: ResizeObserver | null = null
  function updateVisibleAnchors() {
    for (const anchor of anchors) {
      anchor.update()
    }
  }
  function updateVisibleViewportAnchors() {
    for (const anchor of anchors) {
      if (anchor.displayInViewport) anchor.update()
    }
  }
  return (el: AnchoredPositionElement) => {
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('resize', updateVisibleAnchors)
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('scroll', updateVisibleAnchors)
    const visualViewport = el.ownerDocument.defaultView?.visualViewport
    // eslint-disable-next-line github/prefer-observers
    visualViewport?.addEventListener('resize', updateVisibleViewportAnchors)
    // eslint-disable-next-line github/prefer-observers
    visualViewport?.addEventListener('scroll', updateVisibleViewportAnchors)
    intersectionObserver ||= new IntersectionObserver(entries => {
      for (const entry of entries) {
        const target = entry.target as AnchoredPositionElement
        if (entry.isIntersecting) {
          target.update()
          anchors.add(target)
        } else {
          anchors.delete(target)
        }
      }
    })
    resizeObserver ||= new ResizeObserver(() => {
      for (const anchor of anchors) {
        anchor.update()
      }
    })
    resizeObserver.observe(el.ownerDocument.documentElement)
    resizeObserver.observe(el)
    intersectionObserver.observe(el)
  }
})()

export default class AnchoredPositionElement extends HTMLElement implements PositionSettings {
  get align(): AnchorAlignment {
    const value = this.getAttribute('align')
    if (value === 'center' || value === 'end') return value
    return 'start'
  }

  set align(value: AnchorAlignment) {
    this.setAttribute('align', `${value}`)
  }

  get side(): AnchorSide {
    const value = this.getAttribute('side')
    if (
      value === 'inside-top' ||
      value === 'inside-bottom' ||
      value === 'inside-left' ||
      value === 'inside-right' ||
      value === 'inside-center' ||
      value === 'outside-top' ||
      value === 'outside-left' ||
      value === 'outside-right'
    ) {
      return value
    }
    return 'outside-bottom'
  }

  set side(value: AnchorSide) {
    this.setAttribute('side', `${value}`)
  }

  get anchorOffset(): number {
    const alias = this.getAttribute('anchor-offset')
    if (alias === 'spacious' || alias === '8') return 8
    return 4
  }

  set anchorOffset(value: number | 'normal' | 'spacious') {
    this.setAttribute('anchor-offset', `${value}`)
  }

  get anchor() {
    return this.getAttribute('anchor') || ''
  }

  set anchor(value: string) {
    this.setAttribute('anchor', `${value}`)
  }

  #anchorElement: HTMLElement | null = null
  get anchorElement(): HTMLElement | null {
    if (this.#anchorElement) return this.#anchorElement
    const idRef = this.anchor
    if (!idRef) return null
    return this.ownerDocument.getElementById(idRef)
  }

  set anchorElement(value: HTMLElement | null) {
    this.#anchorElement = value
    if (!this.#anchorElement) {
      this.removeAttribute('anchor')
    }
  }

  get alignmentOffset(): number {
    return Number(this.getAttribute('alignment-offset'))
  }

  set alignmentOffset(value: number) {
    this.setAttribute('alignment-offset', `${value}`)
  }

  get allowOutOfBounds() {
    return this.hasAttribute('allow-out-of-bounds')
  }

  set allowOutOfBounds(value: boolean) {
    this.toggleAttribute('allow-out-of-bounds', value)
  }

  get displayInViewport() {
    return this.hasAttribute('display-in-viewport')
  }

  set displayInViewport(value: boolean) {
    this.toggleAttribute('display-in-viewport', value)
  }

  connectedCallback() {
    this.update()
    this.addEventListener('beforetoggle', () => this.update())
    updateWhenVisible(this)
  }

  static observedAttributes = [
    'align',
    'side',
    'anchor',
    'alignment-offset',
    'allow-out-of-bounds',
    'display-in-viewport',
  ]
  attributeChangedCallback() {
    this.update()
  }

  #getPositionInViewport(anchor: HTMLElement, viewport: DOMRect) {
    // The library returns parent-relative coordinates, even for DOMRect anchors.
    const origin = getAnchoredPosition(this, viewport, {
      side: 'inside-top',
      align: 'start',
      anchorOffset: 0,
      alignmentOffset: 0,
      allowOutOfBounds: true,
    })
    const {width, height} = this.getBoundingClientRect()
    const right = origin.left + viewport.width
    const bottom = origin.top + viewport.height
    const settings: PositionSettings = {
      side: this.side,
      align: this.align,
      anchorOffset: this.anchorOffset,
      alignmentOffset: this.alignmentOffset,
      allowOutOfBounds: true,
    }
    let position = getAnchoredPosition(this, anchor, settings)
    for (const side of alternateSides[this.side] || []) {
      const vertical = position.anchorSide === 'outside-top' || position.anchorSide === 'outside-bottom'
      const fits = vertical
        ? position.top >= origin.top && position.top + height <= bottom
        : position.left >= origin.left && position.left + width <= right
      if (fits) break
      position = getAnchoredPosition(this, anchor, {...settings, side})
    }
    for (const align of alternateAlignments[this.align]) {
      if (position.left >= origin.left && position.left + width <= right) break
      position = getAnchoredPosition(this, anchor, {...settings, side: position.anchorSide, align})
    }
    return {
      top: Math.max(origin.top, Math.min(position.top, bottom - height)),
      left: Math.max(origin.left, Math.min(position.left, right - width)),
    }
  }

  #animationFrame: ReturnType<typeof requestAnimationFrame>
  #previousClientHeight = 0
  update() {
    if (!this.isConnected) return
    cancelAnimationFrame(this.#animationFrame)

    this.#animationFrame = requestAnimationFrame(() => {
      const anchor = this.anchorElement
      const visualViewport = this.ownerDocument.defaultView?.visualViewport
      const viewport = new DOMRect(
        visualViewport?.offsetLeft ?? 0,
        visualViewport?.offsetTop ?? 0,
        visualViewport?.width ?? this.ownerDocument.documentElement.clientWidth,
        visualViewport?.height ?? this.ownerDocument.documentElement.clientHeight,
      )
      this.classList.toggle('not-anchored', !anchor)
      if (anchor && this.displayInViewport) {
        // Constrain the height before positioning so the overlay can fit on either side of its anchor.
        const anchorRect = anchor.getBoundingClientRect()
        const availableHeight = Math.min(
          viewport.height,
          Math.max(
            anchorRect.top - viewport.top - this.anchorOffset,
            viewport.bottom - anchorRect.bottom - this.anchorOffset,
            0,
          ),
        )
        this.style.setProperty('--anchored-position-available-height', `${availableHeight}px`)
      } else {
        this.style.removeProperty('--anchored-position-available-height')
      }
      if (anchor) {
        const {left, top} =
          this.displayInViewport && visualViewport && !this.allowOutOfBounds
            ? this.#getPositionInViewport(anchor, viewport)
            : getAnchoredPosition(this, anchor, this)
        this.style.top = `${top}px`
        this.style.left = `${left}px`
        this.style.bottom = 'auto'
        this.style.right = 'auto'
        const clientHeight = this.clientHeight
        if (this.displayInViewport && clientHeight > 0 && clientHeight < this.#previousClientHeight) {
          const activeId = anchor.getAttribute('aria-activedescendant')
          const activeOption = activeId ? this.ownerDocument.getElementById(activeId) : null
          if (activeOption && this.contains(activeOption)) {
            const topEdge = this.getBoundingClientRect().top + this.clientTop
            const bottomEdge = topEdge + clientHeight
            const activeRect = activeOption.getBoundingClientRect()
            if (activeRect.top < topEdge) {
              this.scrollTop += activeRect.top - topEdge
            } else if (activeRect.bottom > bottomEdge) {
              this.scrollTop += activeRect.bottom - bottomEdge
            }
          }
        }
        this.#previousClientHeight = clientHeight
      } else {
        this.style.top = '0'
        this.style.left = '0'
        this.style.bottom = '0'
        this.style.right = '0'
        this.#previousClientHeight = 0
      }
    })
  }
}

if (!customElements.get('anchored-position')) {
  window.AnchoredPositionElement = AnchoredPositionElement
  customElements.define('anchored-position', AnchoredPositionElement)
}

declare global {
  interface Window {
    AnchoredPositionElement: typeof AnchoredPositionElement
  }
}
