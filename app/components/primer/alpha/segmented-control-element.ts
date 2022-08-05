/* eslint-disable custom-elements/no-constructor */
function getControls(el: SegmentedControlElement): HTMLElement[] {
  return Array.from(el.querySelectorAll<HTMLElement>('[role="toolbar"] button')).filter(
    tab => tab instanceof HTMLElement && tab.closest(el.tagName) === el
  )
}

export default class SegmentedControlElement extends HTMLElement {
  constructor() {
    super()

    this.addEventListener('click', (event: MouseEvent) => {
      const controls = getControls(this)

      if (!(event.target instanceof Element)) return
      if (event.target.closest(this.tagName) !== this) return

      const selectedControl = event.target.closest('button')
      if (!(selectedControl instanceof HTMLElement) || !selectedControl.closest('[role="toolbar"]')) return

      for (const control of controls) {
        control.classList.remove('SegmentedControl-button--selected')
        control.setAttribute('aria-selected', 'false')
      }

      selectedControl.classList.add('SegmentedControl-button--selected')
      selectedControl.setAttribute('aria-selected', 'true')
      selectedControl.focus()
    })
  }
}

declare global {
  interface Window {
    SegmentedControlElement: typeof SegmentedControlElement
  }
}

if (!window.customElements.get('segmented-control')) {
  window.SegmentedControlElement = SegmentedControlElement
  window.customElements.define('segmented-control', SegmentedControlElement)
}
