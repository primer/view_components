function dialogInvokerButtonHandler(event: Event) {
  const target = event.target as HTMLElement
  const button = target?.closest('button')

  if (!button || button.hasAttribute('disabled') || button.getAttribute('aria-disabled') === 'true') return

  // If the user is clicking a valid dialog trigger
  let dialogId = button?.getAttribute('data-show-dialog-id')
  if (dialogId) {
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof HTMLDialogElement) {
      dialog.showModal()
      // A buttons default behaviour in some browsers it to send a pointer event
      // If the behaviour is allowed through the dialog will be shown but then
      // quickly hidden- as if it were never shown. This prevents that.
      event.preventDefault()

      // When a <dialog> is opened with showModal() from inside a popover with popover="auto",
      // there are two related issues:
      //
      // 1. In older browsers (e.g. Chrome 122), the "hide all popovers" algorithm runs when a
      //    top layer element opens, closing any ancestor popover. We must re-open those popovers.
      //    See https://github.com/whatwg/html/issues/9998,
      //    fixed by https://github.com/whatwg/html/pull/10116.
      //
      // 2. In newer browsers where the popover stays open, the popover="auto" behavior still
      //    interferes with the native <dialog> focus trap, causing focus to escape the dialog
      //    when tabbing past the last focusable element. Converting the popover to "manual"
      //    prevents this interference.
      //
      // In both cases, the fix is the same: convert ancestor auto popovers to manual.
      let node: HTMLElement | null | undefined = button
      let fixed = false
      while (node) {
        node = node.parentElement?.closest('[popover]')
        if (node && node.popover === 'auto') {
          node.classList.add('dialog-inside-popover-fix')
          node.popover = 'manual'
          // Changing popover from "auto" to "manual" closes the popover,
          // so we need to re-show it regardless of whether it was previously open.
          node.showPopover()
          fixed = true
        }
      }
      if (fixed) {
        // We need to re-open the dialog as modal, and also ensure no close event listeners
        // are trying to act on the close
        /* eslint-disable-next-line no-restricted-syntax */
        dialog.addEventListener('close', e => e.stopImmediatePropagation(), {once: true})
        dialog.close()
        dialog.showModal()
        dialog.addEventListener(
          'close',
          () => {
            for (const el of dialog.ownerDocument.querySelectorAll<HTMLElement>('.dialog-inside-popover-fix')) {
              if (el.contains(dialog)) {
                el.classList.remove('dialog-inside-popover-fix')
                el.popover = 'auto'
                el.showPopover()
              }
            }
          },
          {once: true},
        )
      }
    }
  }

  dialogId = button.getAttribute('data-close-dialog-id') || button.getAttribute('data-submit-dialog-id')
  if (dialogId) {
    const dialog = document.getElementById(dialogId)
    if (dialog instanceof HTMLDialogElement && dialog.open) {
      dialog.close()
    }
  }
}

export class DialogHelperElement extends HTMLElement {
  get dialog() {
    return this.querySelector('dialog')
  }

  #abortController: AbortController | null = null
  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    document.addEventListener('click', dialogInvokerButtonHandler, true)
    document.addEventListener('click', this, {signal})
    this.ownerDocument.body.style.setProperty(
      '--dialog-scrollgutter',
      `${window.innerWidth - this.ownerDocument.body.clientWidth}px`,
    )
    new MutationObserver(records => {
      for (const record of records) {
        if (record.target === this.dialog) {
          this.#handleDialogOpenAttribute()
        }
      }
    }).observe(this, {subtree: true, attributeFilter: ['open']})
    this.#handleDialogOpenAttribute()
  }

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  #handleDialogOpenAttribute() {
    if (!this.dialog) return
    // We don't want to show the Dialog component as non-modal
    if (this.dialog.matches('[open]:not(:modal)')) {
      // eslint-disable-next-line no-restricted-syntax
      this.dialog.addEventListener('close', e => e.stopImmediatePropagation(), {once: true})
      this.dialog.close()
      this.dialog.showModal()
    }
  }

  handleEvent(event: MouseEvent) {
    const target = event.target as HTMLElement
    const dialog = this.dialog
    // The click target _must_ be the dialog element itself, and not elements underneath or inside.
    if (target !== dialog || !dialog?.open) return

    // If the dialog contains a form, do not close the dialog when clicking outside of the dialog
    if (dialog.querySelector('form')) return

    const rect = dialog.getBoundingClientRect()
    const clickWasInsideDialog =
      rect.top <= event.clientY &&
      event.clientY <= rect.top + rect.height &&
      rect.left <= event.clientX &&
      event.clientX <= rect.left + rect.width

    if (!clickWasInsideDialog) {
      dialog.close()
    }
  }
}

declare global {
  interface Window {
    DialogHelperElement: typeof DialogHelperElement
  }
  interface HTMLElementTagNameMap {
    'dialog-helper': DialogHelperElement
  }
}

if (!window.customElements.get('dialog-helper')) {
  window.DialogHelperElement = DialogHelperElement
  window.customElements.define('dialog-helper', DialogHelperElement)
}
