import {controller, targets} from '@github/catalyst'

@controller
export class SegmentedControlElement extends HTMLElement {
  @targets items: HTMLElement[]

  connectedCallback() {
    this.#updateButtonLabels()
  }

  select(event: Event) {
    const button = event.currentTarget as HTMLButtonElement
    for (const item of this.items) {
      item.classList.remove('SegmentedControl-item--selected')
      item.querySelector('[aria-current]')?.setAttribute('aria-current', 'false')
    }

    button.closest('li.SegmentedControl-item')?.classList.add('SegmentedControl-item--selected')
    button.setAttribute('aria-current', 'true')

    this.dispatchEvent(
      new CustomEvent('itemActivated', {
        bubbles: true,
        detail: {
          item: button,
          checked: false,
          value: button.querySelector('.Button-label')?.textContent,
        },
      }),
    )
  }

  get current(): HTMLElement | null {
    return this.querySelector('[aria-current=true]')
  }

  // Updates the button labels to have a data-content attribute with the text
  // This is for selection styling to avoid the text jumping. It only needs to be
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

if (!window.customElements.get('segmented-control')) {
  window.SegmentedControlElement = SegmentedControlElement
  window.customElements.define('segmented-control', SegmentedControlElement)
}
