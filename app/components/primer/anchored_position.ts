import type {AnchorAlignment, AnchorSide, PositionSettings} from '@primer/behaviors'
import {getAnchoredPosition} from '@primer/behaviors'

const pixelTolerance = 1
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

function isVisible(element: HTMLElement) {
  return typeof element.checkVisibility === 'function' ? element.checkVisibility() : element.getClientRects().length > 0
}

const updateWhenVisible = (() => {
  const anchors = new Set<AnchoredPositionElement>()
  const connectedAnchors = new Set<AnchoredPositionElement>()
  let intersectionObserver: IntersectionObserver | null = null
  let resizeObserver: ResizeObserver | null = null
  function updateAnchors() {
    for (const anchor of connectedAnchors) {
      if (anchor.displayInViewport ? isVisible(anchor) : anchors.has(anchor)) anchor.update()
    }
  }
  function updateViewportAnchors() {
    for (const anchor of connectedAnchors) {
      if (anchor.displayInViewport && isVisible(anchor)) anchor.update()
    }
  }
  function updateScrollingViewportAnchors(event: Event) {
    const target = event.target
    if (!(target instanceof Node)) return
    for (const anchor of connectedAnchors) {
      if (
        anchor.displayInViewport &&
        !anchor.contains(target) &&
        target.contains(anchor.anchorElement) &&
        isVisible(anchor)
      ) {
        anchor.update()
      }
    }
  }
  return (el: AnchoredPositionElement) => {
    connectedAnchors.add(el)
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('resize', updateAnchors)
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('scroll', updateAnchors)
    // eslint-disable-next-line github/prefer-observers
    window.addEventListener('scroll', updateScrollingViewportAnchors, true)
    const visualViewport = el.ownerDocument.defaultView?.visualViewport
    // eslint-disable-next-line github/prefer-observers
    visualViewport?.addEventListener('resize', updateViewportAnchors)
    // eslint-disable-next-line github/prefer-observers
    visualViewport?.addEventListener('scroll', updateViewportAnchors)
    intersectionObserver ||= new IntersectionObserver(entries => {
      for (const entry of entries) {
        const target = entry.target as AnchoredPositionElement
        if (entry.isIntersecting && connectedAnchors.has(target)) {
          target.update()
          anchors.add(target)
        } else {
          anchors.delete(target)
        }
      }
    })
    resizeObserver ||= new ResizeObserver(updateAnchors)
    resizeObserver.observe(el.ownerDocument.documentElement)
    resizeObserver.observe(el)
    intersectionObserver.observe(el)
    return () => {
      connectedAnchors.delete(el)
      anchors.delete(el)
      resizeObserver?.unobserve(el)
      intersectionObserver?.unobserve(el)
    }
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

  #stopObserving: (() => void) | undefined
  #beforeToggle = () => this.update()
  connectedCallback() {
    this.addEventListener('beforetoggle', this.#beforeToggle)
    // eslint-disable-next-line github/prefer-observers
    this.addEventListener('scroll', this.#rememberActiveOption)
    this.#stopObserving = updateWhenVisible(this)
    this.update()
  }

  disconnectedCallback() {
    this.#stopObserving?.()
    this.#stopObserving = undefined
    this.#mutationObserver?.disconnect()
    this.#optionResizeObserver?.disconnect()
    this.#observedOptions.clear()
    this.#observedAnchor = null
    this.removeEventListener('beforetoggle', this.#beforeToggle)
    this.removeEventListener('scroll', this.#rememberActiveOption)
    cancelAnimationFrame(this.#animationFrame)
    this.#activeOptionState = null
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
    const settings: PositionSettings = {
      side: this.side,
      align: this.align,
      anchorOffset: this.anchorOffset,
      alignmentOffset: this.alignmentOffset,
      allowOutOfBounds: true,
    }
    let position = getAnchoredPosition(this, anchor, settings)
    const anchorRect = anchor.getBoundingClientRect()
    if (
      anchorRect.bottom <= viewport.top ||
      anchorRect.top >= viewport.bottom ||
      anchorRect.right <= viewport.left ||
      anchorRect.left >= viewport.right
    ) {
      return position
    }
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
  #activeOptionState: {
    id: string
    restore: boolean
    pendingSelection: boolean
    clientWidth: number
    clientHeight: number
    scrollHeight: number
    scrollTop: number
    scrollLeft: number
    top: number
    height: number
  } | null = null
  #mutationObserver: MutationObserver | null = null
  #observedAnchor: HTMLElement | null = null
  #optionResizeObserver: ResizeObserver | null = null
  #observedOptions = new Set<HTMLElement>()

  #observeOptions() {
    if (!this.isConnected || !this.displayInViewport || !this.anchorElement || !isVisible(this)) {
      this.#optionResizeObserver?.disconnect()
      this.#observedOptions.clear()
      return
    }
    this.#optionResizeObserver ||= new ResizeObserver(() => {
      if (this.isConnected && this.displayInViewport && isVisible(this)) this.update()
    })
    const options = new Set(this.querySelectorAll<HTMLElement>('[role="option"], [data-no-result-found]'))
    for (const option of this.#observedOptions) {
      if (!options.has(option)) this.#optionResizeObserver.unobserve(option)
    }
    for (const option of options) {
      if (!this.#observedOptions.has(option)) this.#optionResizeObserver.observe(option, {box: 'border-box'})
    }
    this.#observedOptions = options
  }

  #getActiveOption() {
    const id = this.anchorElement?.getAttribute('aria-activedescendant')
    const option = id ? this.ownerDocument.getElementById(id) : null
    return option && this.contains(option) ? option : null
  }

  #getMinimumHeight() {
    const activeOption = this.#getActiveOption()
    let optionHeight = activeOption?.getBoundingClientRect().height ?? 0
    if (!activeOption) {
      for (const option of this.querySelectorAll<HTMLElement>('[role="option"], [data-no-result-found]')) {
        optionHeight = Math.max(optionHeight, option.getBoundingClientRect().height)
      }
    }
    const style = getComputedStyle(this)
    return (
      optionHeight +
      parseFloat(style.paddingTop) +
      parseFloat(style.paddingBottom) +
      parseFloat(style.borderTopWidth) +
      parseFloat(style.borderBottomWidth)
    )
  }

  #getActiveOptionState() {
    if (!this.isConnected || !this.displayInViewport || !isVisible(this)) return null
    const option = this.#getActiveOption()
    if (!option) return null
    const rect = option.getBoundingClientRect()
    const popup = this.getBoundingClientRect()
    const top = popup.top + this.clientTop
    const left = popup.left + this.clientLeft
    return {
      id: option.id,
      pendingSelection: false,
      clientWidth: this.clientWidth,
      clientHeight: this.clientHeight,
      scrollHeight: this.scrollHeight,
      scrollTop: this.scrollTop,
      scrollLeft: this.scrollLeft,
      top: rect.top - top + this.scrollTop,
      height: rect.height,
      restore:
        rect.height > 0 &&
        rect.width > 0 &&
        rect.top >= top - pixelTolerance &&
        rect.bottom <= top + this.clientHeight + pixelTolerance &&
        rect.left >= left - pixelTolerance &&
        rect.right <= left + this.clientWidth + pixelTolerance,
    }
  }

  #rememberActiveOption = () => {
    const state = this.#getActiveOptionState()
    const previous = this.#activeOptionState
    // Keep restoration eligibility through reflow and our own scroll writes.
    if (
      state &&
      previous &&
      state.id === previous.id &&
      (state.clientWidth !== previous.clientWidth ||
        state.clientHeight !== previous.clientHeight ||
        state.scrollHeight !== previous.scrollHeight ||
        Math.abs(state.top - previous.top) > pixelTolerance ||
        Math.abs(state.height - previous.height) > pixelTolerance ||
        (state.scrollTop === previous.scrollTop && state.scrollLeft === previous.scrollLeft))
    ) {
      return
    }
    this.#activeOptionState = state
  }

  update() {
    if (!this.isConnected) return
    cancelAnimationFrame(this.#animationFrame)

    this.#animationFrame = requestAnimationFrame(() => {
      const anchor = this.anchorElement
      const observedAnchor = this.displayInViewport ? anchor : null
      if (this.#observedAnchor !== observedAnchor) {
        this.#mutationObserver?.disconnect()
        this.#observedAnchor = observedAnchor
        this.#activeOptionState = null
        if (observedAnchor) {
          this.#mutationObserver ||= new MutationObserver(records => {
            const previousId = this.#activeOptionState?.id
            this.#rememberActiveOption()
            if (
              this.#activeOptionState &&
              this.#activeOptionState.id !== previousId &&
              records.some(record => record.type === 'attributes')
            ) {
              this.#activeOptionState.pendingSelection = true
            }
            if (records.some(record => record.type !== 'attributes')) {
              this.#observeOptions()
            }
            if (this.displayInViewport && isVisible(this)) this.update()
          })
          this.#mutationObserver.observe(observedAnchor, {
            attributes: true,
            attributeFilter: ['aria-activedescendant'],
          })
          this.#mutationObserver.observe(this, {childList: true, characterData: true, subtree: true})
        }
      }
      this.#observeOptions()
      this.#rememberActiveOption()
      const previousActiveOption = this.#activeOptionState
      const visualViewport = this.ownerDocument.defaultView?.visualViewport
      const viewport = new DOMRect(
        visualViewport?.offsetLeft ?? 0,
        visualViewport?.offsetTop ?? 0,
        visualViewport?.width ?? this.ownerDocument.documentElement.clientWidth,
        visualViewport?.height ?? this.ownerDocument.documentElement.clientHeight,
      )
      this.classList.toggle('not-anchored', !anchor)
      if (anchor && this.displayInViewport && !this.allowOutOfBounds) {
        // Constrain the width before measuring options and choosing a fitting side.
        const anchorRect = anchor.getBoundingClientRect()
        const scrollTop = this.scrollTop
        this.style.setProperty('--anchored-position-available-width', `${viewport.width}px`)
        const availableHeight = Math.min(
          viewport.height,
          Math.max(
            anchorRect.top - viewport.top - this.anchorOffset,
            viewport.bottom - anchorRect.bottom - this.anchorOffset,
            0,
          ),
        )
        this.style.setProperty('--anchored-position-available-height', `${availableHeight}px`)
        const horizontalSpace = Math.max(
          anchorRect.left - viewport.left - this.anchorOffset,
          viewport.right - anchorRect.right - this.anchorOffset,
        )
        const heightDeficit = this.#getMinimumHeight() - this.getBoundingClientRect().height
        if (heightDeficit > pixelTolerance) {
          const minWidth = parseFloat(getComputedStyle(this).minWidth) || 0
          if (horizontalSpace >= minWidth) {
            this.style.setProperty(
              '--anchored-position-available-width',
              `${Math.min(viewport.width, horizontalSpace)}px`,
            )
          }
          this.style.setProperty('--anchored-position-available-height', `${viewport.height}px`)
          const candidate = this.getBoundingClientRect()
          // If neither candidate fits, keep the one that clips less content.
          if (candidate.width > horizontalSpace || this.#getMinimumHeight() - candidate.height >= heightDeficit) {
            this.style.setProperty('--anchored-position-available-width', `${viewport.width}px`)
            this.style.setProperty('--anchored-position-available-height', `${availableHeight}px`)
          }
        }
        // Measuring the configured width must not change the results' scroll position.
        this.scrollTop = scrollTop
      } else {
        this.style.removeProperty('--anchored-position-available-width')
        this.style.removeProperty('--anchored-position-available-height')
      }
      if (anchor) {
        const {left, top} =
          this.displayInViewport && !this.allowOutOfBounds
            ? this.#getPositionInViewport(anchor, viewport)
            : getAnchoredPosition(this, anchor, this)
        this.style.top = `${top}px`
        this.style.left = `${left}px`
        this.style.bottom = 'auto'
        this.style.right = 'auto'
        const clientHeight = this.clientHeight
        const activeOption = this.#getActiveOption()
        if (
          this.displayInViewport &&
          clientHeight > 0 &&
          activeOption &&
          (previousActiveOption?.restore || previousActiveOption?.pendingSelection) &&
          activeOption.id === previousActiveOption.id
        ) {
          const topEdge = this.getBoundingClientRect().top + this.clientTop
          const bottomEdge = topEdge + clientHeight
          const activeRect = activeOption.getBoundingClientRect()
          if (activeRect.height <= clientHeight + pixelTolerance) {
            if (activeRect.top < topEdge) {
              this.scrollTop += activeRect.top - topEdge
            } else if (activeRect.bottom > bottomEdge) {
              this.scrollTop += activeRect.bottom - bottomEdge
            }
          }
        }
        const state = this.#getActiveOptionState()
        if (
          state &&
          previousActiveOption?.restore &&
          state.id === previousActiveOption.id &&
          state.height > state.clientHeight + pixelTolerance
        ) {
          state.restore = true
        }
        this.#activeOptionState = state
      } else {
        this.style.top = '0'
        this.style.left = '0'
        this.style.bottom = '0'
        this.style.right = '0'
        this.#activeOptionState = null
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
