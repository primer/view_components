const visibleElements = new WeakSet()


function globalPopoverHandler(event: Event) {
  const target = event.target
  if (!(target instanceof Element)) return
  const doc = target.ownerDocument
  let effectedPopover: HTMLElement | null = target.closest('[popover]')
  const button = target.closest('[popovertoggletarget],[popoverhidetarget],[popovershowtarget]')
  const isButton = button instanceof HTMLButtonElement

  // Handle popover triggers
  if (isButton && button.hasAttribute('popovershowtarget')) {
    effectedPopover = doc.getElementById(button.getAttribute('popovershowtarget') || '')

    if (
      effectedPopover instanceof PrimerOverlayElement &&
      effectedPopover.popover &&
      !visibleElements.has(effectedPopover)
    ) {
      effectedPopover.showPopover()
    }
  } else if (isButton && button.hasAttribute('popoverhidetarget')) {
    effectedPopover = doc.getElementById(button.getAttribute('popoverhidetarget') || '')

    if (
      effectedPopover instanceof PrimerOverlayElement &&
      effectedPopover.popover &&
      visibleElements.has(effectedPopover)
    ) {
      effectedPopover.hidePopover()
    }
  } else if (isButton && button.hasAttribute('popovertoggletarget')) {
    effectedPopover = doc.getElementById(button.getAttribute('popovertoggletarget') || '')

    if (effectedPopover instanceof PrimerOverlayElement && effectedPopover.popover) {
      effectedPopover.togglePopover()
    }
  }

  // Dismiss open popovers
  for (const popover of doc.querySelectorAll('[popover="" i].\\:open, [popover=auto i].\\:open')) {
    if (popover instanceof PrimerOverlayElement && popover !== effectedPopover) popover.hidePopover()
  }
}

const supportsPopover = 'popover' in HTMLElement.prototype
declare global {
  interface HTMLElement {
    popover: 'auto' | 'manual' | null
    showPopover(): void
    hidePopover(): void
  }
}

export class PrimerOverlayElement extends HTMLElement {
  static get observedAttributes() {
    return ['popover']
  }

  get popover(): 'auto' | 'manual' | null {
    if (supportsPopover) return super.popover
    const value = this.getAttribute('popover')?.toLowerCase() || ''
    if (value === 'manual') return 'manual'
    if (value === '' || value === 'auto') return 'auto'
    return null
  }

  set popover(value: string | null) {
    this.setAttribute('popover', String(value))
  }

  private connectedCallback() {
    if (!supportsPopover) {
      this.ownerDocument.addEventListener('click', globalPopoverHandler)
    }
  }

  showPopover() {
    if (supportsPopover) return super.showPopover()
    if (visibleElements.has(this)) throw new DOMException('Invalid on already showing popover', 'InvalidStateError')
    this.classList.add(':open')
    visibleElements.add(this)
  }

  hidePopover() {
    if (supportsPopover) return super.hidePopover()
    if (!visibleElements.has(this)) throw new DOMException('Invalid on already hidden Popover', 'InvalidStateError')
    this.classList.remove(':open')
    visibleElements.delete(this)
  }

  togglePopover() {
    if (supportsPopover) return super.hidePopover()
    if (visibleElements.has(this)) {
      this.hidePopover()
    } else {
      this.showPopover()
    }
  }
}

declare global {
  interface Window {
    PrimerOverlayElement: typeof PrimerOverlayElement
  }
  interface HTMLElementTagNameMap {
    'primer-overlay': PrimerOverlayElement
  }
}

if (!window.customElements.get('primer-overlay')) {
  window.PrimerOverlayElement = PrimerOverlayElement
  window.customElements.define('primer-overlay', PrimerOverlayElement)
}
