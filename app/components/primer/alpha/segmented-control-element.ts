/* eslint-disable custom-elements/no-constructor */
export default class SegmentedControlElement extends HTMLElement {
  constructor() {
    super()

    this.addEventListener('click', (event: MouseEvent) => {
      const controls = Array.from(this.querySelectorAll<HTMLElement>('ul li')).filter(
        tab => tab instanceof HTMLElement && tab.closest(this.tagName) === this
      ) as HTMLElement[]

      if (!(event.target instanceof Element)) return
      if (event.target.closest(this.tagName) !== this) return

      const selectedControl = event.target.closest('li')
      if (!(selectedControl instanceof HTMLElement) || !selectedControl.closest('ul')) return

      for (const control of controls) {
        control.setAttribute('aria-current', 'false')
      }

      selectedControl.setAttribute('aria-current', 'true')
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
