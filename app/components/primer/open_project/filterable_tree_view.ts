import {controller, target} from '@github/catalyst'
import {SegmentedControlElement} from '../alpha/segmented_control'
import {TreeViewElement} from './tree_view/tree_view'
import {TreeViewSubTreeNodeElement} from './tree_view/tree_view_sub_tree_node_element'
import {TreeViewNodeInfo} from '../shared_events'

// This function is expected to return the following values:
// 1. No match - return null
// 2. Match but no highlights - empty array (i.e. when showing all selected nodes but empty query string)
// 3. Match with highlights - non-empty array of Range objects
export type FilterFn = (node: HTMLElement, query: string, filterMode?: string) => Range[] | null

type NodeState = {
  checked: boolean
  disabled: boolean
}

@controller
export class FilterableTreeViewElement extends HTMLElement {
  @target filterInput: HTMLInputElement
  @target filterModeControlList: HTMLElement
  @target treeViewList: HTMLElement
  @target noResultsMessage: HTMLElement
  @target includeSubItemsCheckBox: HTMLInputElement

  #filterFn?: FilterFn
  #abortController: AbortController
  #stateMap: Map<TreeViewSubTreeNodeElement, Map<HTMLElement, NodeState>> = new Map()
  #defaultNodeState: NodeState = {checked: false, disabled: false}

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('treeViewNodeChecked', this, {signal})
    this.addEventListener('treeViewBeforeNodeChecked', this, {signal})
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
    } else if (event.target instanceof TreeViewElement || event.target instanceof TreeViewSubTreeNodeElement) {
      this.#handleTreeViewEvent(event)
    }
  }

  #handleTreeViewEvent(origEvent: Event) {
    const event = origEvent as CustomEvent<TreeViewNodeInfo[]>

    // This event only fires if someone actually activates the check mark, i.e. does not fire when
    // calling this.treeView.setNodeCheckedValue, which happens in this.#applyFilterOptions.
    switch (origEvent.type) {
      case 'treeViewNodeChecked':
        this.#handleTreeViewNodeChecked(event)
        break

      case 'treeViewBeforeNodeChecked':
        this.#handleTreeViewBeforeNodeChecked(event)
        break
    }
  }

  #handleTreeViewBeforeNodeChecked(event: CustomEvent<TreeViewNodeInfo[]>) {
    if (!this.treeView) return

    const nodeInfo = event.detail[0]
    if (this.treeView.getNodeType(nodeInfo.node) !== 'sub-tree') return

    const subTree = nodeInfo.node.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement

    if (this.includeSubItemsCheckBox.checked) {
      if (nodeInfo.checkedValue === 'true') {
        this.#saveNodeState(subTree)
        this.#disableSubTree(subTree)
      }
    }
  }

  #handleTreeViewNodeChecked(event: CustomEvent<TreeViewNodeInfo[]>) {
    if (!this.treeView) return
    if (!this.includeSubItemsCheckBox.checked) return

    // Although multiple nodes may have been checked (eg. if the TreeView is in descendants mode),
    // the one that actually received the click, i.e. the local root the user checked, is the first
    // entry. We only care about sub-tree nodes because checking them affects all leaf nodes, so
    // there's no need to check or uncheck individual leaves.
    const nodeInfo = event.detail[0]
    if (this.treeView.getNodeType(nodeInfo.node) !== 'sub-tree') return

    const subTree = nodeInfo.node.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement

    // If the sub-tree has been unchecked, allow all child nodes to be checked (i.e. enable them)
    // and restore whatever state they were in before.
    if (nodeInfo.checkedValue === 'false') {
      this.#enableSubTree(subTree)
      this.#restoreNodeState(subTree)
    }
  }

  #saveNodeState(subTree: TreeViewSubTreeNodeElement) {
    if (!this.treeView) return

    const descendantStates: Map<HTMLElement, NodeState> = new Map()

    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(subTree, subTree.level, [])) {
      for (const leafNode of leafNodes) {
        const checked = this.treeView.getNodeCheckedValue(leafNode) === 'true'

        // There is no need to record the state of a node that isn't checked, as a node cannot be
        // both disabled _and_ unchecked.
        if (checked) {
          descendantStates.set(leafNode, {
            checked,
            disabled: leafNode.getAttribute('aria-disabled') === 'true',
          })
        }
      }

      for (const ancestor of ancestors) {
        const checked = this.treeView.getNodeCheckedValue(ancestor.node) === 'true'

        // There is no need to record the state of a node that isn't checked, as a node cannot be
        // both disabled _and_ unchecked.
        if (checked) {
          descendantStates.set(ancestor.node, {
            checked,
            disabled: ancestor.node.getAttribute('aria-disabled') === 'true',
          })
        }
      }
    }

    this.#stateMap.set(subTree, descendantStates)
  }

  #restoreNodeState(subTree: TreeViewSubTreeNodeElement) {
    if (!this.treeView) return
    if (!this.#stateMap.has(subTree)) return

    const descendantStates = this.#stateMap.get(subTree)!

    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(subTree, subTree.level, [])) {
      for (const leafNode of leafNodes) {
        const descendantState = descendantStates.get(leafNode) || this.#defaultNodeState

        this.treeView.setNodeCheckedValue(leafNode, descendantState.checked ? 'true' : 'false')

        if (descendantState.disabled) {
          leafNode.setAttribute('aria-disabled', 'true')
        } else {
          leafNode.removeAttribute('aria-disabled')
        }
      }

      for (const ancestor of ancestors) {
        const descendantState = descendantStates.get(ancestor.node) || this.#defaultNodeState

        this.treeView.setNodeCheckedValue(ancestor.node, descendantState.checked ? 'true' : 'false')

        if (descendantState.disabled) {
          ancestor.node.setAttribute('aria-disabled', 'true')
        } else {
          ancestor.node.removeAttribute('aria-disabled')
        }
      }
    }

    this.#stateMap.delete(subTree)
  }

  #disableSubTree(subTree: TreeViewSubTreeNodeElement) {
    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(subTree, subTree.level, [])) {
      for (const leafNode of leafNodes) {
        leafNode.setAttribute('aria-disabled', 'true')
      }

      for (const ancestor of ancestors) {
        if (ancestor === subTree) continue
        ancestor.node.setAttribute('aria-disabled', 'true')
      }
    }
  }

  #enableSubTree(subTree: TreeViewSubTreeNodeElement) {
    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(subTree, subTree.level, [])) {
      for (const leafNode of leafNodes) {
        leafNode.removeAttribute('aria-disabled')
      }

      for (const ancestor of ancestors) {
        if (ancestor === subTree) continue
        ancestor.node.removeAttribute('aria-disabled')
      }
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

    this.#applyFilterOptions()
  }

  #handleFilterInputEvent(event: Event) {
    if (event.type !== 'input') return

    this.#applyFilterOptions()
  }

  #handleIncludeSubItemsCheckBoxEvent(event: Event) {
    if (!this.treeView) return
    if (event.type !== 'input') return

    if (this.includeSubItemsCheckBox.checked) {
      for (const [, ancestors] of this.eachDescendantDepthFirst(this.treeViewList, 1, [])) {
        for (const ancestor of ancestors) {
          if (this.treeView.getNodeCheckedValue(ancestor.node) === 'true') {
            if (!this.#stateMap.has(ancestor)) {
              this.#saveNodeState(ancestor)
            }

            for (const node of ancestor.eachDescendantNode()) {
              this.treeView.setNodeCheckedValue(node, 'true')
            }

            this.#disableSubTree(ancestor)

            break
          }

          if (this.#stateMap.has(ancestor)) break
        }
      }
    } else {
      for (const subTree of this.#stateMap.keys()) {
        this.#restoreNodeState(subTree)
      }

      this.#stateMap.clear()
    }

    this.#applyFilterOptions()
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

  /* This function does quite a bit. It's responsible for showing and hiding nodes that match the filter
   * criteria, disabling nodes under certain conditions, and rendering highlights for node text that
   * matches the query string. The filter criteria are as follows:
   *
   * 1. A free-form query string from a text input field.
   * 2. A SegmentedControl with two options:
   *    1. The "Selected" option causes the component to only show checked nodes, provided they also
   *       satisfy the other filter criteria described here.
   *    2. The "All" option causes the component to show all nodes, provided they also satisfy the other
   *       filter criteria described here.
   * 3. A check box labeled "Include sub-items" that affects how nodes are checked. Checking this box will
   *    automatically check and disable all child nodes under currently checked parents. Subsequently
   *    checking an unchecked parent will check and disable all child nodes. Unchecking a parent restores
   *    any previously checked children so as not to "undo" a user's selections.
   *
   * Whether or not a node matches is determined by a filter function with a `FilterFn` signature. The
   * component defines a default filter function, but a user-defined one can also be provided. The filter
   * function is expected to return an array of `Range` objects which #applyFilterOptions uses to highlight
   * node text that matches the query string. The default filter function identifies matching node text by
   * looking for an exact substring match, operating on a lowercased version of both the query string and
   * the node text.
   *
   * It should be noted that the returned `Range` objects must have starting and ending values that refer
   * to offsets inside the same text node. Not adhering to this rule may lead to undefined behavior.
   *
   * Applying the filter criteria can have the following effects on individual nodes:
   *
   * 1. Hidden: Nodes are hidden if:
   *    1. The filter function returns null.
   * 2. Disabled: Nodes are disabled if:
   *    1. The node is a child of a checked parent and the "Include sub-items" check box is checked.
   * 3. Checked: Nodes are checked if one of the following is true:
   *    1. The node was manually checked by the user.
   *    2. The node is a child of a checked parent and the "Include sub-items" check box is checked.
   * 4. Expanded: Sub-tree nodes are expanded if:
   *    1. For at least one of the node's children, including descendants, the filter function returns a
   *       truthy value.
   */
  #applyFilterOptions() {
    if (!this.treeView) return

    this.#removeHighlights()

    const query = this.queryString
    const mode = this.filterMode || undefined
    const generation = window.crypto.randomUUID()
    const filterRangesCache: Map<Element, Range[] | null> = new Map()

    const expandAncestors = (...ancestors: TreeViewSubTreeNodeElement[]) => {
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

    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(this.treeViewList, 1, [])) {
      const parent: TreeViewSubTreeNodeElement | undefined = ancestors[ancestors.length - 1]
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
        expandAncestors(...ancestors)
      } else {
        if (parent) {
          if (cachedFilterFn(parent.node, query, mode)) {
            expandAncestors(...ancestors)
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
    level: number,
    ancestry: TreeViewSubTreeNodeElement[],
  ): Generator<[NodeListOf<HTMLElement>, TreeViewSubTreeNodeElement[]]> {
    for (const subTreeItem of node.querySelectorAll<HTMLElement>(
      `[role=treeitem][data-node-type='sub-tree'][aria-level='${level}']`,
    )) {
      const subTree = subTreeItem.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement
      yield* this.eachDescendantDepthFirst(subTree, level + 1, [...ancestry, subTree])
    }

    const leafNodes = node.querySelectorAll<HTMLElement>(
      `[role=treeitem][data-node-type='leaf'][aria-level='${level}']`,
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
