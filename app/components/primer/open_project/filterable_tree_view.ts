import {controller, target} from '@github/catalyst'
import {SegmentedControlElement} from '../alpha/segmented_control'
import {TreeViewElement} from './tree_view/tree_view'
import {TreeViewSubTreeNodeElement} from './tree_view/tree_view_sub_tree_node_element'

// This function is expected to return the following values:
// 1. No match - return null
// 2. Match but no highlights - empty array (i.e. when showing all selected nodes but empty query string)
// 3. Match with highlights - non-empty array of Range objects
export type FilterFn = (node: HTMLElement, query: string, filterMode?: string) => Range[] | null

@controller
export class FilterableTreeViewElement extends HTMLElement {
  @target filterInput: HTMLInputElement
  @target filterModeControlList: HTMLElement
  @target treeViewList: HTMLElement
  @target noResultsMessage: HTMLElement
  @target includeSubItemsCheckBox: HTMLInputElement

  #filterFn?: FilterFn
  #abortController: AbortController

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('itemActivated', this, {signal})
    this.addEventListener('input', this, {signal})
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    if (event.target === this.filterModeControl) {
      this.#handleFilterModeEvent(event)
    } else if (event.target === this.filterInput) {
      this.#handleFilterInputEvent(event)
    } else if (event.target === this.includeSubItemsCheckBox) {
      this.#handleIncludeSubItemsCheckBoxEvent(event)
    }
  }

  get filterModeControl(): SegmentedControlElement | null {
    return this.filterModeControlList.closest('segmented-control')
  }

  get treeView(): TreeViewElement | null {
    return this.treeViewList.closest('tree-view')
  }

  #handleFilterModeEvent(event: Event) {
    if (event.type !== 'itemActivated') return

    this.#update()
  }

  #handleFilterInputEvent(event: Event) {
    if (event.type !== 'input') return

    this.#update()
  }

  #handleIncludeSubItemsCheckBoxEvent(event: Event) {
    if (event.type !== 'input') return

    if (this.includeSubItemsCheckBox.checked) {
      this.treeView?.changeSelectStrategy('descendants')
    } else {
      this.treeView?.changeSelectStrategy('self')
    }
  }

  set filterFn(newFn: FilterFn) {
    this.#filterFn = newFn
  }

  get filterFn(): FilterFn {
    if (this.#filterFn) {
      return this.#filterFn
    } else {
      return this.defaultFilterFn
    }
  }

  defaultFilterFn(node: HTMLElement, query: string, filterMode?: string): Range[] | null {
    const ranges = []

    if (query.length > 0) {
      const lowercaseQuery = query.toLowerCase()
      const treeWalker = document.createTreeWalker(node, NodeFilter.SHOW_TEXT)
      let currentNode = treeWalker.nextNode()

      while (currentNode) {
        const lowercaseNodeText = currentNode.textContent?.toLocaleLowerCase() || ''
        let startIndex = 0

        while (startIndex < lowercaseNodeText.length) {
          const index = lowercaseNodeText.indexOf(lowercaseQuery, startIndex)
          if (index === -1) break

          const range = new Range()
          range.setStart(currentNode, index)
          range.setEnd(currentNode, index + lowercaseQuery.length)
          ranges.push(range)

          startIndex = index + lowercaseQuery.length
        }

        currentNode = treeWalker.nextNode()
      }
    }

    if (ranges.length === 0 && query.length > 0) {
      return null
    }

    switch (filterMode) {
      case 'selected': {
        if (this.treeView?.getNodeCheckedValue(node) !== 'false') {
          return ranges
        }

        break
      }

      case 'all': {
        return ranges
      }
    }

    return null
  }

  get filterMode(): string | null {
    const current = this.filterModeControl?.current

    if (current) {
      return current.getAttribute('data-name')
    } else {
      return null
    }
  }

  get queryString(): string {
    return this.filterInput.value
  }

  #update() {
    if (!this.treeView) return

    this.#removeHighlights()

    const query = this.queryString
    const mode = this.filterMode || undefined
    const generation = window.crypto.randomUUID()
    const filterRangesCache: Map<Element, Range[] | null> = new Map()

    const expandAncestors = (ancestors: TreeViewSubTreeNodeElement[]) => {
      for (const ancestor of ancestors) {
        ancestor.expand()
        ancestor.removeAttribute('hidden')
        ancestor.setAttribute('data-generation', generation)

        if (cachedFilterFn(ancestor.node, query, mode)) {
          ancestor.node.removeAttribute('aria-disabled')
        } else {
          ancestor.node.setAttribute('aria-disabled', 'true')
        }
      }
    }

    const cachedFilterFn = (node: HTMLElement, queryStr: string, filterMode?: string): boolean => {
      if (!filterRangesCache.has(node)) {
        filterRangesCache.set(node, this.filterFn(node, queryStr, filterMode))
      }

      return filterRangesCache.get(node)! !== null
    }

    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(this.treeViewList, [])) {
      let atLeastOneLeafMatches = false

      for (const leafNode of leafNodes) {
        if (cachedFilterFn(leafNode, query, mode)) {
          leafNode.closest('li')?.removeAttribute('hidden')
          atLeastOneLeafMatches = true
        } else {
          leafNode.closest('li')?.setAttribute('hidden', 'hidden')
        }

        leafNode.setAttribute('data-generation', generation)
      }

      if (atLeastOneLeafMatches) {
        expandAncestors(ancestors)
      } else {
        const parent: TreeViewSubTreeNodeElement | undefined = ancestors.pop()

        if (parent) {
          if (cachedFilterFn(parent.node, query, mode)) {
            expandAncestors(ancestors)
          } else {
            if (parent.getAttribute('data-generation') !== generation) {
              parent.collapse()
              parent.setAttribute('hidden', 'hidden')
            }
          }
        }
      }
    }

    const allRanges = Array.from(filterRangesCache.values())
      .flat()
      .filter(r => r !== null)

    if (allRanges.length === 0 && query.length > 0) {
      this.treeViewList.setAttribute('hidden', 'hidden')
      this.noResultsMessage.removeAttribute('hidden')
    } else {
      this.treeViewList.removeAttribute('hidden')
      this.noResultsMessage.setAttribute('hidden', 'hidden')

      this.#applyHighlights(allRanges)
    }
  }

  #applyHighlights(ranges: Range[]) {
    // Attempt to use the new-ish custom highlight API:
    // https://developer.mozilla.org/en-US/docs/Web/API/CSS_Custom_Highlight_API
    if (CSS.highlights) {
      CSS.highlights.set('primer-filterable-tree-view-search-results', new Highlight(...ranges))
    } else {
      this.#applyManualHighlights(ranges)
    }
  }

  #applyManualHighlights(ranges: Range[]) {
    // Rebuild the text node's parent contents
    const textNode = ranges[0].startContainer
    const parent = textNode.parentNode!
    const originalText = textNode.textContent!
    const fragments = []
    let lastIndex = 0

    for (const {startOffset, endOffset} of ranges) {
      // Text before the highlight
      if (startOffset > lastIndex) {
        fragments.push(document.createTextNode(originalText.slice(lastIndex, startOffset)))
      }

      // Highlighted text
      const mark = document.createElement('mark')
      mark.textContent = originalText.slice(startOffset, endOffset)
      fragments.push(mark)

      lastIndex = endOffset
    }

    // Remaining text after the last highlight
    if (lastIndex < originalText.length) {
      fragments.push(document.createTextNode(originalText.slice(lastIndex)))
    }

    // Replace original text node with fragments
    for (const frag of fragments.reverse()) {
      parent.insertBefore(frag, textNode.nextSibling)
    }

    parent.removeChild(textNode)
  }

  #removeHighlights() {
    for (const mark of this.querySelectorAll('mark')) {
      if (!mark.parentElement) continue
      mark.parentElement.replaceChildren(mark.parentElement.textContent!)
    }
  }

  *eachDescendantDepthFirst(
    node: HTMLElement,
    ancestry: TreeViewSubTreeNodeElement[],
  ): Generator<[NodeListOf<HTMLElement>, TreeViewSubTreeNodeElement[]]> {
    for (const subTreeItem of node.querySelectorAll<HTMLElement>(
      `[role=treeitem][data-node-type='sub-tree'][aria-level='${ancestry.length + 1}']`,
    )) {
      const subTree = subTreeItem.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement
      yield* this.eachDescendantDepthFirst(subTree, [...ancestry, subTree])
    }

    const leafNodes = node.querySelectorAll<HTMLElement>(
      `[role=treeitem][data-node-type='leaf'][aria-level='${ancestry.length + 1}']`,
    )

    yield [leafNodes, ancestry]
  }
}

if (!window.customElements.get('filterable-tree-view')) {
  window.FilterableTreeViewElement = FilterableTreeViewElement
  window.customElements.define('filterable-tree-view', FilterableTreeViewElement)
}

declare global {
  interface Window {
    FilterableTreeViewElement: typeof FilterableTreeViewElement
  }
}
