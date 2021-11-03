class TooltipContainerElement extends HTMLElement {
  constructor() {
    super()
    this.globalEscape = this.globalEscape.bind(this)
  }

  connectedCallback() {
    const trigger: HTMLElement | null =
      this.querySelector('[aria-describedby]') || this.querySelector('[aria-labelledby]')
    const tooltip: HTMLElement | null = this.querySelector('[role="tooltip"]')

    if (!trigger || !tooltip) return

    this.addEventListener('mouseover', (event: MouseEvent) => {
      this.open(event)
    })

    this.addEventListener('mouseleave', (event: MouseEvent) => {
      this.close(event)
    })
    trigger.addEventListener('focus', (event: FocusEvent) => {
      this.open(event)
    })
    trigger.addEventListener('blur', (event: FocusEvent) => {
      this.close(event)
    })
  }
  open(event: FocusEvent | MouseEvent) {
    showTooltip(event, this)
    document.addEventListener('keydown', this.globalEscape)
  }

  close(event: FocusEvent | MouseEvent) {
    hideTooltip(event, this)
    document.removeEventListener('keydown', this.globalEscape)
  }

  globalEscape(event: KeyboardEvent) {
    if (event.key === 'Escape' || event.key === 'Esc') {
      closeTooltip(this)
    }
  }
}

// function checkBounds(tooltip: HTMLElement) {
//   const bounding = tooltip.getBoundingClientRect()
//   console.log(bounding)
//   // if (bounding.left < 0) {
//   //   tooltip.style.left = '0'
//   //   tooltip.style.right = 'auto'
//   //   tooltip.style.transform = `translateX(${-bounding.x + 16}px)`
//   // }
// }

function closeTooltip(el: TooltipContainerElement) {
  const tooltip = el.querySelector('[role=tooltip]') as HTMLElement

  if (!tooltip) return

  tooltip.setAttribute('hidden', 'hidden')
  tooltip.classList.remove('hx-tooltip-visible')
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

  for (const tooltip of document.querySelectorAll('[role=tooltip]')) {
    tooltip.setAttribute('hidden', 'hidden')
    tooltip.classList.remove('hx-tooltip-visible')
  }

  const tooltip = el.querySelector('[role=tooltip]') as HTMLElement

  if (!tooltip) return

  // checkBounds(tooltip)
  tooltip.removeAttribute('hidden')
  tooltip.classList.add('hx-tooltip-visible')
}

export default TooltipContainerElement

if (!window.customElements.get('tooltip-container')) {
  window.TooltipContainerElement = TooltipContainerElement
  window.customElements.define('tooltip-container', TooltipContainerElement)
}

declare global {
  interface Window {
    TooltipContainerElement: typeof TooltipContainerElement
  }
}
