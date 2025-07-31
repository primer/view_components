import {TreeViewElement} from './tree_view'
import {FocusKeys, focusZone} from '@primer/behaviors'

// This code was adapted from the roving tab index implementation in primer/react, see:
// https://github.com/primer/react/blob/f9785343716435f43e3d82482b057a17bd345c25/packages/react/src/TreeView/useRovingTabIndex.ts
export function useRovingTabIndex(containerEl: TreeViewElement) {
  // TODO: Initialize focus to the aria-current item if it exists
  focusZone(containerEl, {
    bindKeys: FocusKeys.ArrowVertical | FocusKeys.ArrowHorizontal | FocusKeys.HomeAndEnd | FocusKeys.Backspace,
    getNextFocusable: (_direction, from, event) => {
      if (!(from instanceof HTMLElement)) return

      // Skip elements within a modal dialog
      // This need to be in a try/catch to avoid errors in
      // non-supported browsers
      try {
        if (from.closest('dialog:modal')) {
          return
        }
      } catch {
        // Don't return
      }

      return getNextFocusableElement(from, event) ?? from
    },
    focusInStrategy: () => {
      let currentItem = containerEl.querySelector('[aria-current]')
      currentItem = currentItem?.checkVisibility() ? currentItem : null

      const firstItem = containerEl.querySelector('[role="treeitem"]')

      // Focus the aria-current item if it exists
      if (currentItem instanceof HTMLElement) {
        return currentItem
      }

      // Otherwise, focus the activeElement if it's a treeitem
      if (
        document.activeElement instanceof HTMLElement &&
        containerEl.contains(document.activeElement) &&
        document.activeElement.getAttribute('role') === 'treeitem'
      ) {
        return document.activeElement
      }

      // Otherwise, focus the first treeitem
      return firstItem instanceof HTMLElement ? firstItem : undefined
    },
  })
}

// DOM utilities used for focus management

function getNextFocusableElement(activeElement: HTMLElement, event: KeyboardEvent): HTMLElement | undefined {
  const elementState = getElementState(activeElement)

  // Reference: https://www.w3.org/WAI/ARIA/apg/patterns/treeview/#keyboard-interaction-24
  switch (`${elementState} ${event.key}`) {
    case 'open ArrowRight':
      // Focus first child node
      return getFirstChildElement(activeElement)

    case 'open ArrowLeft':
      // Close node; don't change focus
      return

    case 'closed ArrowRight':
      // Open node; don't change focus
      return

    case 'closed ArrowLeft':
      // Focus parent element
      return getParentElement(activeElement)

    case 'end ArrowRight':
      // Do nothing
      return

    case 'end ArrowLeft':
      // Focus parent element
      return getParentElement(activeElement)
  }

  // ArrowUp and ArrowDown behavior is the same regardless of element state
  switch (event.key) {
    case 'ArrowUp':
      // Focus previous visible element
      return getVisibleElement(activeElement, 'previous')

    case 'ArrowDown':
      // Focus next visible element
      return getVisibleElement(activeElement, 'next')

    case 'Backspace':
      return getParentElement(activeElement)
  }
}

export function getElementState(element: HTMLElement): 'open' | 'closed' | 'end' {
  if (element.getAttribute('role') !== 'treeitem') {
    throw new Error('Element is not a treeitem')
  }

  switch (element.getAttribute('aria-expanded')) {
    case 'true':
      return 'open'
    case 'false':
      return 'closed'
    default:
      return 'end'
  }
}

function getVisibleElement(element: HTMLElement, direction: 'next' | 'previous'): HTMLElement | undefined {
  const root = element.closest('[role=tree]')

  if (!root) return

  const walker = document.createTreeWalker(root, NodeFilter.SHOW_ELEMENT, node => {
    if (!(node instanceof HTMLElement)) return NodeFilter.FILTER_SKIP
    return node.getAttribute('role') === 'treeitem' ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP
  })

  let current = walker.firstChild()

  while (current !== element) {
    current = walker.nextNode()
  }

  let next = direction === 'next' ? walker.nextNode() : walker.previousNode()

  // If next element is nested inside a collapsed subtree, continue iterating
  while (next instanceof HTMLElement && collapsedParent(next, root)) {
    next = direction === 'next' ? walker.nextNode() : walker.previousNode()
  }

  return next instanceof HTMLElement ? next : undefined
}

function collapsedParent(node: Element, root: Element): Element | null {
  for (const ancestor of root.querySelectorAll('[role=treeitem][aria-expanded=false]')) {
    if (node === ancestor) continue

    if (ancestor.closest('li')?.contains(node)) {
      return ancestor
    }
  }

  return null
}

function getFirstChildElement(element: HTMLElement): HTMLElement | undefined {
  const firstChild = element.querySelector('[role=treeitem]')
  return firstChild instanceof HTMLElement ? firstChild : undefined
}

function getParentElement(element: HTMLElement): HTMLElement | undefined {
  const group = element.closest('[role=group]')
  const parent = group?.closest('[role=treeitem]')
  return parent instanceof HTMLElement ? parent : undefined
}
