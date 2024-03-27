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

      // In some older browsers, such as Chrome 122, when a top layer element (such as a dialog)
      // opens from within a popover, the "hide all popovers" internal algorithm runs, hiding
      // any popover that is currently open, regardless of whether or not another top layer element,
      // such as a <dialog> is nested inside.
      // See https://github.com/whatwg/html/issues/9998.
      // This is fixed by https://github.com/whatwg/html/pull/10116, but while we still support browsers
      // that present this bug, we must undo the work they did to hide ancestral popovers of the dialog:
      let node: HTMLElement | null | undefined = button
      let fixed = false
      while (node) {
        node = node.parentElement?.closest('[popover]:not(:popover-open)')
        if (node && node.popover === 'auto') {
          node.classList.add('dialog-inside-popover-fix')
          node.popover = 'manual'
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
    this.ownerDocument.body.classList.toggle('has-modal', this.dialog.matches(':modal'))
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
