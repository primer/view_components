/* eslint-disable custom-elements/expose-class-on-global */
import {controller, targets} from '@github/catalyst'

@controller
class PrimerMultiInputElement extends HTMLElement {
  @targets fields: HTMLInputElement[]

  activateField(name: string) {
    const fieldWithName = this.findField(name)
    if (!fieldWithName) return

    for (const field of this.fields) {
      if (field === fieldWithName) continue

      field.setAttribute('disabled', 'disabled')
      field.setAttribute('hidden', 'hidden')

      field.parentElement?.setAttribute('hidden', 'hidden')
    }

    fieldWithName.removeAttribute('disabled')
    fieldWithName.removeAttribute('hidden')
    fieldWithName.parentElement?.removeAttribute('hidden')
  }

  private findField(name: string): HTMLElement | null {
    for (const field of this.fields) {
      if (field.getAttribute('data-name') === name) {
        return field
      }
    }

    return null
  }
}

declare global {
  interface Window {
    PrimerMultiInputElement: typeof PrimerMultiInputElement
  }
}

if (!window.customElements.get('primer-multi-input')) {
  Object.assign(window, {PrimerMultiInputElement})
  window.customElements.define('primer-multi-input', PrimerMultiInputElement)
}
