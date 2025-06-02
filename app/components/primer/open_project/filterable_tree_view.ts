import {controller, target} from '@github/catalyst'
import {SegmentedControlElement} from '../alpha/segmented_control'
import {TreeViewElement} from './tree_view/tree_view'
import {TreeViewSubTreeNodeElement} from './tree_view/tree_view_sub_tree_node_element'

export type FilterFn = (item: HTMLElement, query: string, filterMode?: string) => Range[] | boolean

@controller
export class FilterableTreeViewElement extends HTMLElement {
  @target filterInput: HTMLInputElement
  @target filterModeControlList: HTMLElement
  @target treeViewList: HTMLElement
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

  defaultFilterFn(node: HTMLElement, query: string, filterMode?: string): Range[] | boolean {
    if (query.length === 0) {
      return true
    }

    const ranges = []
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

      default: {
        return ranges
      }
    }

    return false
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
    const filterRangesCache: Map<Element, Range[] | boolean> = new Map()

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

    const cachedFilterFn = (item: HTMLElement, queryStr: string, filterMode?: string): boolean => {
      if (!filterRangesCache.has(item)) {
        filterRangesCache.set(item, this.filterFn(item, queryStr, filterMode))
      }

      const cachedResult = filterRangesCache.get(item)!

      if (cachedResult === true || cachedResult === false) {
        return cachedResult
      } else {
        return cachedResult.length > 0
      }
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
        const parent: TreeViewSubTreeNodeElement | undefined = ancestors[ancestors.length - 1]

        if (parent) {
          if (cachedFilterFn(parent.node, query, mode)) {
            expandAncestors(ancestors.slice(1))
          } else {
            if (parent.getAttribute('data-generation') !== generation) {
              parent.collapse()
              parent.setAttribute('hidden', 'hidden')
            }
          }
        }
      }
    }

    if (CSS.highlights) {
      const allRanges = []

      for (const [, ranges] of filterRangesCache) {
        if (ranges === true || ranges === false) continue
        allRanges.push(...ranges)
      }

      CSS.highlights.set('primer-filterable-tree-view-search-results', new Highlight(...allRanges))
    } else {
      this.#applyHighlights(filterRangesCache)
    }
  }

  #removeHighlights() {
    for (const mark of this.querySelectorAll('mark')) {
      if (!mark.parentElement) continue
      mark.parentElement.replaceChildren(mark.parentElement.textContent!)
    }
  }

  #applyHighlights(rangeMap: Map<Element, Range[] | boolean>) {
    for (const ranges of rangeMap.values()) {
      if (ranges === true || ranges === false) continue
      if (ranges.length === 0) continue

      // We’ll rebuild the text node's parent contents
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
