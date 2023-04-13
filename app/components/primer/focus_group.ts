import '@oddbird/popover-polyfill'

const menuItemSelector = '[role="menuitem"],[role="menuitemcheckbox"],[role="menuitemradio"],a'

const popoverSelector = (() => {
  try {
    document.querySelector(':open')
    return ':open'
  } catch {
    return '.\\:open'
  }
})()

const getMnemonicFor = (item: Element) => item.textContent?.trim()[0].toLowerCase()

const printable = /^\S$/

export default class FocusGroupElement extends HTMLElement {
  get nowrap(): boolean {
    return this.hasAttribute('nowrap')
  }

  set nowrap(value: boolean) {
    this.toggleAttribute('nowrap', value)
  }

  get direction(): 'horizontal' | 'vertical' | 'both' {
    if (this.getAttribute('direction') === 'horizontal') return 'horizontal'
    return 'vertical'
  }

  set direction(value: 'horizontal' | 'vertical' | 'both') {
    this.setAttribute('direction', `${value}`)
  }

  get retain() {
    return this.hasAttribute('retain')
  }

  set retain(value: boolean) {
    this.toggleAttribute('retain', value)
  }

  get mnemonics() {
    return this.hasAttribute('mnemonics')
  }

  #abortController: AbortController | null = null
  connectedCallback() {
    this.#abortController = new AbortController()
    const {signal} = this.#abortController

    this.addEventListener('keydown', this, {signal})
    this.addEventListener('click', this, {signal})
    this.addEventListener('mouseover', this, {signal})
    this.addEventListener('focusin', this, {signal})
  }

  disconnectedCallback() {
    this.#abortController?.abort()
  }

  get #items() {
    return this.querySelectorAll(menuItemSelector)
  }

  handleEvent(event: Event) {
    const {direction, nowrap} = this
    if (event.type === 'focusin') {
      if (this.retain && event.target instanceof Element && event.target.matches(menuItemSelector)) {
        for (const item of this.#items) {
          item.setAttribute('tabindex', item === event.target ? '0' : '-1')
        }
      }
    } else if (event instanceof KeyboardEvent) {
      const items = Array.from(this.#items)
      let index = items.indexOf(event.target as Element)
      const key = event.key
      if (key === 'Up' || key === 'ArrowUp') {
        if (direction === 'vertical' || direction === 'both') {
          index -= index < 0 ? 0 : 1
        }
      } else if (key === 'Down' || key === 'ArrowDown') {
        if (direction === 'vertical' || direction === 'both') {
          index += 1
        }
      } else if (event.key === 'Left' || event.key === 'ArrowLeft') {
        if (direction === 'horizontal' || direction === 'both') {
          index -= 1
        }
      } else if (event.key === 'Right' || event.key === 'ArrowRight') {
        if (direction === 'horizontal' || direction === 'both') {
          index += 1
        }
      } else if (event.key === 'Home' || event.key === 'PageUp') {
        index = 0
      } else if (event.key === 'End' || event.key === 'PageDown') {
        index = items.length - 1
      } else if (this.mnemonics && printable.test(key)) {
        const mnemonic = key.toLowerCase()
        const offset = index > 0 && getMnemonicFor(event.target as Element) === mnemonic ? index : 0
        index = items.findIndex((item, i) => i > offset && getMnemonicFor(item) === mnemonic)
        if (index < 0 && !nowrap) {
          index = items.findIndex(item => getMnemonicFor(item) === mnemonic)
        }
      } else {
        return
      }
      if (nowrap && index < 0) index = 0
      if (!nowrap && index >= items.length) index = 0
      const focusEl = items.at(Math.min(index, items.length - 1)) as HTMLElement
      {
        let el: HTMLElement | null = focusEl
        do {
          el = el.closest(`[popover]:not(${popoverSelector})`)
          if (el?.popover === 'auto') {
            el.showPopover()
          } else {
            el = el?.parentElement || null
          }
        } while (el)
      }
      focusEl?.focus()
    }
  }
}

if (!customElements.get('focus-group')) {
  window.FocusGroupElement = FocusGroupElement
  customElements.define('focus-group', FocusGroupElement)
}

declare global {
  interface Window {
    FocusGroupElement: typeof FocusGroupElement
  }
}
