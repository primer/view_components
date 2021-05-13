import '@github/clipboard-copy-element'

const CLIPBOARD_COPY_TIMER_DURATION = 2000

function toggleSVG(svg: SVGElement) {
  if (svg.style.display === '' || svg.style.display === 'block') {
    svg.style.display = 'none'
  } else {
    svg.style.display = 'block'
  }
}

// Toggle a copy button.
function toggleCopyButton(button: HTMLElement) {
  const [clippyIcon, checkIcon] = button.querySelectorAll<SVGElement>('.octicon')

  if (!clippyIcon || !checkIcon) return

  toggleSVG(clippyIcon)
  toggleSVG(checkIcon)
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
    toggleCopyButton(target)
  }

  clipboardCopyElementTimers.set(target, setTimeout(toggleCopyButton, CLIPBOARD_COPY_TIMER_DURATION, target))
})
