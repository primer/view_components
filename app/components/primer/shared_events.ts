export type ItemActivatedEvent = {
  item: Element
  checked: boolean
}

declare global {
  interface HTMLElementEventMap {
    itemActivated: CustomEvent<ItemActivatedEvent>
  }
}
