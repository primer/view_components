import '@primer/behaviors'

/* Testing a theory: can we include in progress TypeScript code here? */

class ModalDialogElement extends HTMLElement {

  constructor(){
    super();

    console.log(this.querySelector('.close-button'));
    this.querySelector('.close-button')?.addEventListener('click', (e:Event) => this.close());
  }

  connectedCallback(): void {
    if (!this.hasAttribute('role')) this.setAttribute('role', 'dialog')
  }

  disconnectedCallback(): void {
    const state = states.get(this)
    if (!state) return
    states.delete(this)
    for (const sub of state.subscriptions) {
      sub.unsubscribe()
    }
  }

  open() {
    //TODO: Is an `open` attribute a good idea?
    const wasOpen = this.hasAttribute('open')
    if (wasOpen) return
    this.setAttribute('open', '')
    //TODO: handle focus here?
  }

  close() {
    const wasOpen = this.hasAttribute('open')
    if (!wasOpen) return
    this.removeAttribute('open')
    //TODO: handle focus here?
  }
}

const states = new WeakMap()

type Subscription = {unsubscribe(): void}
const NullSubscription = {
  unsubscribe() {
    /* Do nothing */
  }
}

function fromEvent(
  target: EventTarget,
  eventName: string,
  onNext: EventListenerOrEventListenerObject,
  options: boolean | AddEventListenerOptions = false
): Subscription {
  target.addEventListener(eventName, onNext, options)
  return {
    unsubscribe: () => {
      target.removeEventListener(eventName, onNext, options)
    }
  }
}

function keydown(dialog: ModalDialogElement, event: Event) {
  if (!(event instanceof KeyboardEvent)) return
  const state = states.get(dialog)
  if (!state || state.isComposing) return

  switch (event.key) {
    case 'Escape':
      if (dialog.hasAttribute('open')) {
        dialog.close()
        event.preventDefault()
        event.stopPropagation()
      }
      break
  }
}

declare global {
  interface Window {
    ModalDialogElement: typeof ModalDialogElement
  }
  interface HTMLElementTagNameMap {
    'modal-dialog': ModalDialogElement
  }
}

export default ModalDialogElement

if (!window.customElements.get('modal-dialog')) {
  window.ModalDialogElement = ModalDialogElement
  window.customElements.define('modal-dialog', ModalDialogElement)
}