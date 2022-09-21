import {controller, targets} from '@github/catalyst'

@controller
export class SegmentedControlElement extends HTMLElement {
  @targets buttons: HTMLElement[]

  connectedCallback() {
    this.#updateButtonLabels()
  }

  select(event: Event) {
    const button = event.currentTarget as HTMLButtonElement
    for (const item of this.querySelectorAll('li.SegmentedControl-item')) {
      item.classList.remove('SegmentedControl-item--selected')
      item.querySelector('.Button')?.setAttribute('aria-current', 'false')
    }

    button.closest('li.SegmentedControl-item')?.classList.add('SegmentedControl-item--selected')
    button.setAttribute('aria-current', 'true')
  }

  // Updates the button labels to have a data-content attribute with the text
  // This if for selection styling to avoid the text jumping. It only needs to be
  // setup when the component is first loaded.
  #updateButtonLabels() {
    for (const label of this.querySelectorAll('.Button-label')) {
      label.setAttribute('data-content', label.textContent || '')
    }
  }
}

declare global {
  interface Window {
    SegmentedControlElement: typeof SegmentedControlElement
  }
}

window.SegmentedControlElement = SegmentedControlElement
