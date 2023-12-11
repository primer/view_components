export const isKeyboardActivation = (event: Event): boolean => {
  return isKeyboardActivationViaEnter(event) || isKeyboardActivationViaSpace(event)
}

export const isKeyboardActivationViaEnter = (event: Event): boolean => {
  return (
    event instanceof KeyboardEvent &&
    event.type === 'keydown' &&
    !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
    event.key === 'Enter'
  )
}

export const isKeyboardActivationViaSpace = (event: Event): boolean => {
  return (
    event instanceof KeyboardEvent &&
    event.type === 'keydown' &&
    !(event.ctrlKey || event.altKey || event.metaKey || event.shiftKey) &&
    event.key === ' '
  )
}

export const isMouseActivation = (event: Event): boolean => {
  return event instanceof MouseEvent && event.type === 'click'
}

export const isActivation = (event: Event): boolean => {
  return isMouseActivation(event) || isKeyboardActivation(event)
}
