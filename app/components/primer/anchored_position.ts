import type {AnchorAlignment, AnchorSide, PositionSettings} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const updateWhenVisible = (() => {
  const anchors = new Set<AnchoredPositionElement>()
  let intersectionObserver: IntersectionObserver | null = null
  function updateAnchorsOnResize() {
    for (const anchor of anchors) {
      anchor.update()
    }
  }
  return (el: AnchoredPositionElement) => {
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('resize', updateAnchorsOnResize)
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

  set anchorOffset(value: number | 'spacious' | 'compact') {
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

  connectedCallback() {
    this.update()
    this.addEventListener('beforetoggle', () => this.update())
    updateWhenVisible(this)
  }

  attributeChangedCallback() {
    this.update()
  }

  #animationFrame: ReturnType<typeof requestAnimationFrame>
  update() {
    if (!this.isConnected) return
    cancelAnimationFrame(this.#animationFrame)

    this.#animationFrame = requestAnimationFrame(() => {
      const anchor = this.anchorElement
      if (!anchor) return
      const {left, top, anchorSide, anchorAlign} = getAnchoredPosition(this, anchor, this)
      this.style.top = `${top}px`
      this.style.left = `${left}px`
      this.classList.remove(
        'Overlay--anchorAlign-start',
        'Overlay--anchorAlign-center',
        'Overlay--anchorAlign-end',
        'Overlay--anchorSide-insideTop',
        'Overlay--anchorSide-insideBottom',
        'Overlay--anchorSide-insideLeft',
        'Overlay--anchorSide-insideRight',
        'Overlay--anchorSide-insideCenter',
        'Overlay--anchorSide-outsideTop',
        'Overlay--anchorSide-outsideLeft',
        'Overlay--anchorSide-outsideRight'
      )
      this.classList.add(`Overlay--anchorAlign-${anchorAlign}`, `Overlay--anchorSide-${anchorSide}`)
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
