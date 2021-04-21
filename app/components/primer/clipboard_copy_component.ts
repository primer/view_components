import '@github/clipboard-copy-element'

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

  if (clippyIcon) {
    toggleSVG(clippyIcon)
  }
  if (checkIcon) {
    toggleSVG(checkIcon)
  }
}

document.addEventListener('clipboard-copy', function ({target}) {
  if (!(target instanceof HTMLElement)) return
  toggleCopyButton(target)

  setTimeout(toggleCopyButton, 2000, target)
})
