// <tooltip-container> requires two children elements.
//
// The first element is the element that triggers the tooltip on mouseover or focus. This should have an [aria-describedby] or [aria-labelledby]
// attribute set to ID of the second element.
//
// The second element is the tooltip. It must have [role="tooltip"], and an id that matches the ID specified by the first element.
//
// Example usage:
// <tooltip-container class="some-tooltip-container-class">
//   <button aria-describedby="button-tooltip">🚀</button>
//   <p role="tooltip" id="button-tooltip" class="unique-tooltip-id"> This describes the button </p>
// </tooltip-container>

const states = new WeakMap()

const tooltipDirectionClasses = [
  'hx_tooltip-se',
  'hx_tooltip-s',
  'hx_tooltip-ne',
  'hx_tooltip-n',
  'hx_tooltip-nw',
  'hx_tooltip-sw',
  'hx_tooltip-e',
  'hx_tooltip-w'
]

class TooltipContainerElement extends HTMLElement {
  constructor() {
    super()
    this.globalEscape = this.globalEscape.bind(this)
  }

  connectedCallback() {
    const trigger: HTMLElement | null = getTriggerElement(this)
    const tooltip: HTMLElement | null = getTooltipElement(this)

    if (!trigger || !tooltip) return

    if (!tooltip.hasAttribute('hidden')) {
      tooltip.setAttribute('hidden', 'hidden')
    }

    const tooltipDirection = Array.from(tooltip.classList).filter(className =>
      tooltipDirectionClasses.includes(className)
    )[0]
    states.set(this, {tooltipDirection})

    this.addEventListener('mouseover', (event: MouseEvent) => {
      showTooltip(event, this)
    })
    this.addEventListener('mouseleave', (event: MouseEvent) => {
      hideTooltip(event, this)
    })
    trigger.addEventListener('focus', (event: FocusEvent) => {
      showTooltip(event, this)
    })
    trigger.addEventListener('blur', (event: FocusEvent) => {
      hideTooltip(event, this)
    })
    document.addEventListener('keydown', this.globalEscape)
  }

  disconnectedCallback() {
    const trigger: HTMLElement | null = getTriggerElement(this)
    const tooltip: HTMLElement | null = getTooltipElement(this)

    if (!trigger || !tooltip) return

    this.removeEventListener('mouseover', (event: MouseEvent) => {
      showTooltip(event, this)
    })
    this.removeEventListener('mouseleave', (event: MouseEvent) => {
      hideTooltip(event, this)
    })
    trigger.removeEventListener('focus', (event: FocusEvent) => {
      showTooltip(event, this)
    })
    trigger.removeEventListener('blur', (event: FocusEvent) => {
      hideTooltip(event, this)
    })
    document.removeEventListener('keydown', this.globalEscape)

    const state = states.get(this)
    if (!state) return
    states.delete(this)
  }

  globalEscape(event: KeyboardEvent) {
    const tooltip: HTMLElement | null = getTooltipElement(this)
    if (!tooltip) return

    // BUG: when tooltip is in a details-dialog and an element in dialog is focused, `details-dialog` event listener takes priority over this one causing
    // escape to close dialog instead of this tooltip.
    if ((event.key === 'Escape' || event.key === 'Esc') && !tooltip.hasAttribute('hidden')) {
      event.stopPropagation()
      event.preventDefault()
      closeTooltip(this)
    }
  }
}

declare global {
  interface Window {
    TooltipContainerElement: typeof TooltipContainerElement
  }
}

if (!window.customElements.get('tooltip-container')) {
  window.TooltipContainerElement = TooltipContainerElement
  window.customElements.define('tooltip-container', TooltipContainerElement)
}

export {}

function getTriggerElement(el: TooltipContainerElement): HTMLElement | null {
  return el.querySelector('[aria-describedby]') || el.querySelector('[aria-labelledby]')
}

function getTooltipElement(el: TooltipContainerElement): HTMLElement | null {
  return el.querySelector('[role=tooltip]')
}

function closeTooltip(el: TooltipContainerElement) {
  const tooltip: HTMLElement | null = getTooltipElement(el)
  if (!tooltip) return

  tooltip.classList.remove('hx_tooltip-open')
  removeDirectionClasses(tooltip)
  const state = states.get(el)
  if (state) {
    tooltip.classList.add(state.tooltipDirection)
  }

  tooltip.setAttribute('hidden', 'hidden')
}

function hideTooltip(event: FocusEvent | MouseEvent, el: TooltipContainerElement) {
  const target = event.target

  if (!(target instanceof HTMLElement)) return
  if (target.closest(el.tagName) !== el) return

  closeTooltip(el)
}

function showTooltip(event: FocusEvent | MouseEvent, el: TooltipContainerElement) {
  const target = event.target

  if (!(target instanceof HTMLElement)) return
  if (target.closest(el.tagName) !== el) return

  // Hide all tooltips
  for (const tip of document.querySelectorAll('[role=tooltip]')) {
    tip.classList.remove('hx_tooltip-open')
    tip.setAttribute('hidden', 'hidden')
  }

  const tooltip: HTMLElement | null = getTooltipElement(el)
  if (!tooltip) return

  tooltip.classList.add('hx_tooltip-open')
  tooltip.removeAttribute('hidden')
  checkBounds(tooltip)
}

function removeDirectionClasses(tooltip: HTMLElement) {
  for (const directionClass of tooltipDirectionClasses) {
    tooltip.classList.remove(directionClass)
  }
}

function checkBounds(tooltip: HTMLElement) {
  const bounding = tooltip.getBoundingClientRect()

  if (bounding.left >= 0 && bounding.right >= 0 && bounding.top >= 0 && bounding.bottom >= 0) return

  removeDirectionClasses(tooltip)

  if (bounding.left < 0) {
    tooltip.classList.add('hx_tooltip-se')
  } else if (bounding.right < 0) {
    tooltip.classList.add('hx_tooltip-sw')
  }
}