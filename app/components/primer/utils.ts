// Waits for condition to return true. If it returns false initially, this function creates a
// MutationObserver that calls body() whenever the contents of the component change.
export const observeMutationsUntilConditionMet = (element: Element, condition: () => boolean, body: () => void) => {
  if (condition()) {
    body()
  } else {
    const mutationObserver = new MutationObserver(() => {
      if (condition()) {
        body()
        mutationObserver.disconnect()
      }
    })

    mutationObserver.observe(element, {childList: true, subtree: true})
  }
}
