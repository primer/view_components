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
  const [clippyIcon, checkIcon] = button.querySelectorAll<SVGElement>('.octicon')

  if (!clippyIcon || !checkIcon) return

  showSVG(clippyIcon)
  hideSVG(checkIcon)
}

// Toggle a copy button.
function showCheck(button: HTMLElement) {
  const [clippyIcon, checkIcon] = button.querySelectorAll<SVGElement>('.octicon')

  if (!clippyIcon || !checkIcon) return

  hideSVG(clippyIcon)
  showSVG(checkIcon)
}

const clipboardCopyElementTimers = new WeakMap<HTMLElement, number>()

document.addEventListener('clipboard-copy', function ({target}) {
  if (!(target instanceof HTMLElement)) return
  if (!target.hasAttribute('data-view-component')) return

  const currentTimeout = clipboardCopyElementTimers.get(target)

  if (currentTimeout) {
    clearTimeout(currentTimeout)
    clipboardCopyElementTimers.delete(target)
  } else {
    showCheck(target)
  }

  clipboardCopyElementTimers.set(target, setTimeout(() => {
    showCopy(target)
    clipboardCopyElementTimers.delete(target)
  }, CLIPBOARD_COPY_TIMER_DURATION))
})
