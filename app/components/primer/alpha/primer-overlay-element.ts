const visibleElements = new Set()

function globalPopUpHandler(event: Event) {
  const target = event.target
  if (!(target instanceof HTMLElement)) return
  const doc = target.ownerDocument
  let effectedPopup: HTMLElement | null = target.closest('[popup]')
  const isButton = target instanceof HTMLButtonElement

  // Handle popup triggers
  if (isButton && target.hasAttribute('popupshowtarget')) {
    effectedPopup = doc.getElementById(target.getAttribute('popupshowtarget') || '')

    if (effectedPopup instanceof PrimerOverlayElement && effectedPopup.popUp && !visibleElements.has(effectedPopup)) {
      effectedPopup.showPopUp()
    }
  } else if (isButton && target.hasAttribute('popuphidetarget')) {
    effectedPopup = doc.getElementById(target.getAttribute('popuphidetarget') || '')

    if (effectedPopup instanceof PrimerOverlayElement && effectedPopup.popUp && visibleElements.has(effectedPopup)) {
      effectedPopup.hidePopUp()
    }
  } else if (isButton && target.hasAttribute('popuptoggletarget')) {
    effectedPopup = doc.getElementById(target.getAttribute('popuptoggletarget') || '')

    if (effectedPopup instanceof PrimerOverlayElement && effectedPopup.popUp) {
      if (visibleElements.has(effectedPopup)) {
        effectedPopup.hidePopUp()
      } else if (effectedPopup instanceof PrimerOverlayElement) {
        effectedPopup.showPopUp()
      }
    }
  }

  // Dismiss open popups
  for (const popup of doc.querySelectorAll('[popup="" i].\\:open, [popup=auto i].\\:open, [popup=hint i].\\:open')) {
    if (popup instanceof PrimerOverlayElement && popup !== effectedPopup) popup.hidePopUp()
  }
}

class PrimerOverlayElement extends HTMLElement {
  static get observedAttributes() {
    return ['popup', 'defaultopen']
  }

  get defaultOpen(): boolean {
    return this.hasAttribute('defaultopen')
  }

  set defaultOpen(value: boolean) {
    this.toggleAttribute('defaultopen', value)
  }

  get popUp(): 'auto' | 'hint' | 'manual' | null {
    const value = this.getAttribute('popup')?.toLowerCase() || ''
    if (value === 'hint') return 'hint'
    if (value === 'manual') return 'manual'
    if (value === '' || value === 'auto') return 'auto'
    return null
  }

  set popUp(value: string | null) {
    this.setAttribute('popup', String(value))
  }

  private connectedCallback() {
    if (!('showPopUp' in HTMLElement.prototype)) {
      this.ownerDocument.addEventListener('click', globalPopUpHandler)
    }

    if (this.defaultOpen) {
      if (this.popUp === 'auto') {
        // eslint-disable-next-line custom-elements/no-dom-traversal-in-connectedcallback
        const popup = document.querySelector('primer-overlay[popup=auto i][defaultopen]')
        if (popup === this) this.showPopUp()
      } else if (this.popUp === 'manual') {
        this.showPopUp()
      }
    }
  }

  showPopUp() {
    if (visibleElements.has(this)) throw new DOMException('Invalid on already-showing popups', 'InvalidStateError')
    this.style.display = 'block'
    this.style.position = 'fixed'
    visibleElements.add(this)
  }

  hidePopUp() {
    if (visibleElements.has(this)) throw new DOMException('Invalid on already-showing popups', 'InvalidStateError')
    this.style.display = 'none'
    visibleElements.delete(this)
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
