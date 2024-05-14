import '@github/clipboard-copy-element'

const CLIPBOARD_COPY_TIMER_DURATION = 2000

function showSVG(svg: SVGElement) {
  svg.style.display = 'inline-block'
}

function hideSVG(svg: SVGElement) {
  svg.style.display = 'none'
}

// Toggle a copy button.
function showCopy(button: HTMLElement) {
  const [copyIcon, checkIcon] = button.querySelectorAll<SVGElement>('.octicon')

  if (!copyIcon || !checkIcon) return

  showSVG(copyIcon)
  hideSVG(checkIcon)
}

// Toggle a copy button.
function showCheck(button: HTMLElement) {
  const [copyIcon, checkIcon] = button.querySelectorAll<SVGElement>('.octicon')

  if (!copyIcon || !checkIcon) return

  hideSVG(copyIcon)
  showSVG(checkIcon)
}

const clipboardCopyElementTimers = new WeakMap<HTMLElement, number>()

document.addEventListener('clipboard-copy', ({target}) => {
  if (!(target instanceof HTMLElement)) return
  if (!target.hasAttribute('data-view-component')) return

  const currentTimeout = clipboardCopyElementTimers.get(target)
  const clipboardCopyLiveRegion = document.querySelector<HTMLDivElement>('[data-clipboard-copy-live-region]')
  const copiedAnnouncement = 'Copied!'

  if (currentTimeout) {
    clearTimeout(currentTimeout)
    clipboardCopyElementTimers.delete(target)
  } else {
    showCheck(target)
    if (clipboardCopyLiveRegion) {
      if (clipboardCopyLiveRegion.textContent === copiedAnnouncement) {
        /* This is a hack due to the way the aria live API works.
    A screen reader will not read a live region again
    if the text is the same. Adding a space character tells
    the browser that the live region has updated,
    which will cause it to read again, but with no audible difference. */
        clipboardCopyLiveRegion.textContent = `${copiedAnnouncement}\u00A0`
      } else {
        clipboardCopyLiveRegion.textContent = copiedAnnouncement
      }
    }
  }

  clipboardCopyElementTimers.set(
    target,
    setTimeout(() => {
      showCopy(target)
      // if (clipboardCopyLiveRegion) {
      //   clipboardCopyLiveRegion.textContent = ''
      // }
      clipboardCopyElementTimers.delete(target)
    }, CLIPBOARD_COPY_TIMER_DURATION),
  )
})
