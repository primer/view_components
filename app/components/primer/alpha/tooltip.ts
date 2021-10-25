class TooltipContainer extends HTMLElement {
  constructor() {
    super()

    this.addEventListener('mouseenter', (event: MouseEvent) => {
      const target = event.target
      if (!(target instanceof HTMLElement)) return
      if (target.closest(this.tagName) !== this) return
      const tooltip = target.querySelector('[role=tooltip]')

      if (!tooltip) return
      tooltip.removeAttribute('hidden')
    })

    this.addEventListener('mouseleave', (event: MouseEvent) => {
      hideTooltip(event, this)
    })

    const trigger: HTMLElement | null =
      this.querySelector('[aria-describedby]') || this.querySelector('[aria-labelledby]')

    if (trigger) {
      trigger.addEventListener('focus', (event: FocusEvent) => {
        showTooltip(event, this)
      })
      trigger.addEventListener('blur', (event: FocusEvent) => {
        hideTooltip(event, this)
      })
    }
  }
}

function hideTooltip(event: FocusEvent | MouseEvent, el: TooltipContainer) {
  const target = event.target
  if (!(target instanceof HTMLElement)) return
  if (target.closest(el.tagName) !== el) return
  const tooltip = target.querySelector('[role=tooltip]')

  if (!tooltip) return
  tooltip.setAttribute('hidden', 'hidden')
}

function showTooltip(event: FocusEvent | MouseEvent, el: TooltipContainer) {
  const target = event.target
  if (!(target instanceof HTMLElement)) return
  if (target.closest(el.tagName) !== el) return
  const tooltip = target.querySelector('[role=tooltip]')

  if (!tooltip) return
  tooltip.removeAttribute('hidden')
}

export default TooltipContainer

if (!window.customElements.get('tooltip-container')) {
  window.TooltipContainer = TooltipContainer
  window.customElements.define('tooltip-container', TooltipContainer)
}

declare global {
  interface Window {
    TooltipContainer: typeof TooltipContainer
  }
}
