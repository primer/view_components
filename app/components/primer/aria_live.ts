const safeDocument = typeof document === 'undefined' ? undefined : document

// Announce an element's text to the screen reader.
export function announceFromElement(el: HTMLElement, options?: {assertive?: boolean; element?: HTMLElement}) {
  announce(getTextContent(el), options)
}

// Announce message update to screen reader.
// Note: Use caution when using this function while a dialog is active.
// If the message is updated while the dialog is open, the screen reader may not announce the live region.
export function announce(message: string, options?: {assertive?: boolean; element?: HTMLElement}) {
  const {assertive, element} = options ?? {}

  setContainerContent(message, assertive, element)
}

// Set aria-live container to message.
function setContainerContent(message: string, assertive?: boolean, element?: HTMLElement) {
  const getQuerySelector = () => {
    return assertive ? '#js-global-screen-reader-notice-assertive' : '#js-global-screen-reader-notice'
  }
  const container = element ?? safeDocument?.querySelector(getQuerySelector())
  if (!container) return
  if (container.textContent === message) {
    /* This is a hack due to the way the aria live API works.
    A screen reader will not read a live region again
    if the text is the same. Adding a space character tells
    the browser that the live region has updated,
    which will cause it to read again, but with no audible difference. */
    container.textContent = `${message}\u00A0`
  } else {
    container.textContent = message
  }
}

// Gets the trimmed text content of an element.
function getTextContent(el: HTMLElement): string {
  // innerText does not contain hidden text
  /* eslint-disable-next-line github/no-innerText */
  return (el.getAttribute('aria-label') || el.innerText || '').trim()
}
