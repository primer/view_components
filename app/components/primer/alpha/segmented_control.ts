import {controller} from '@github/catalyst'

@controller
export class SegmentedControlElement extends HTMLElement {
  select(event: Event) {
    const button = event.currentTarget as HTMLButtonElement
    for (const item of this.querySelectorAll('li.SegmentedControl-item')) {
      item.classList.remove('SegmentedControl-item--selected')
      item.querySelector('.Button')?.setAttribute('aria-current', 'false')
    }

    button.closest('li.SegmentedControl-item')?.classList.add('SegmentedControl-item--selected')
    button.setAttribute('aria-current', 'true')
  }
}

declare global {
  interface Window {
    SegmentedControlElement: typeof SegmentedControlElement
  }
}

window.SegmentedControlElement = SegmentedControlElement
