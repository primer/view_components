/* eslint-disable custom-elements/no-constructor */
function getControls(el: SegmentedControlElement): HTMLElement[] {
  return Array.from(el.querySelectorAll<HTMLElement>('[role="toolbar"] button')).filter(
    tab => tab instanceof HTMLElement && tab.closest(el.tagName) === el
  )
}

export default class SegmentedControlElement extends HTMLElement {
  constructor() {
    super()

    this.addEventListener('keydown', (event: KeyboardEvent) => {
      const target = event.target
      if (!(target instanceof HTMLElement)) return
      if (target.closest(this.tagName) !== this) return
      if (!target.closest('[role="toolbar"]')) return
      const controls = getControls(this)
      const currentIndex = controls.indexOf(controls.find(control => control === document.activeElement)!)

      if (event.code === 'ArrowRight') {
        let index = currentIndex + 1
        if (index >= controls.length) index = 0
        controls[index].focus()
      } else if (event.code === 'ArrowLeft') {
        let index = currentIndex - 1
        if (index < 0) index = controls.length - 1
        controls[index].focus()
      } else if (event.code === 'Home') {
        controls[0].focus()
        event.preventDefault()
      } else if (event.code === 'End') {
        controls[controls.length - 1].focus()
        event.preventDefault()
      }
    })

    this.addEventListener('click', (event: MouseEvent) => {
      const controls = getControls(this)

      if (!(event.target instanceof Element)) return
      if (event.target.closest(this.tagName) !== this) return

      const selectedControl = event.target.closest('button')
      if (!(selectedControl instanceof HTMLElement) || !selectedControl.closest('[role="toolbar"]')) return

      for (const control of controls) {
        control.classList.remove('SegmentedControl-button--selected')
        control.setAttribute('aria-selected', 'false')
        control.setAttribute('tabindex', '-1')
      }

      selectedControl.classList.add('SegmentedControl-button--selected')
      selectedControl.setAttribute('aria-selected', 'true')
      selectedControl.setAttribute('tabindex', '0')
      selectedControl.focus()
    })
  }

  connectedCallback(): void {
    for (const control of getControls(this)) {
      if (!control.hasAttribute('aria-selected')) {
        control.setAttribute('aria-selected', 'false')
      }
      if (!control.hasAttribute('tabindex')) {
        if (control.getAttribute('aria-selected') === 'true') {
          control.setAttribute('tabindex', '0')
        } else {
          control.setAttribute('tabindex', '-1')
        }
      }
    }
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
