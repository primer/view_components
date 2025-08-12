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

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('treeViewNodeChecked', this, {signal})
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

    // NOTE: This event only fires if someone actually activates the check mark, i.e. does not fire
    // when calling this.treeView.setNodeCheckedValue.
    switch (origEvent.type) {
      case 'treeViewNodeChecked':
        this.#handleTreeViewNodeChecked(event)
        break
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

    if (nodeInfo.checkedValue === 'false') {
      // If the sub-tree has been unchecked, restore whatever state they were in before. We don't
      // need to explicitly enable the sub-tree because restoring will handle setting the enabled
      // or disabled state per-node.
      this.#restoreNodeState(subTree)
    } else {
      this.#includeSubItemsUnder(subTree)
    }
  }

  #restoreNodeState(subTree: TreeViewSubTreeNodeElement) {
    if (!this.treeView) return
    if (!this.#stateMap.has(subTree)) return

    const descendantStates = this.#stateMap.get(subTree)!

    for (const [element, state] of descendantStates.entries()) {
      let node = element

      if (element instanceof TreeViewSubTreeNodeElement) {
        node = element.node
      }

      this.treeView.setNodeCheckedValue(node, state.checked ? 'true' : 'false')
      this.treeView.setNodeDisabledValue(node, state.disabled)
    }

    // once node state has been restored, there's no reason to keep it around - it will be saved
    // again if this sub-tree gets checked
    this.#stateMap.delete(subTree)
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

    this.#applyFilterOptions()

    if (this.includeSubItemsCheckBox.checked) {
      this.#includeSubItems()
    } else {
      this.#restoreAllNodeStates()
    }
  }

  // Automatically checks all children of checked nodes, including leaf nodes and sub-trees. It does so
  // by finding the set of shallowest checked sub-tree nodes, i.e. the set of checked sub-tree nodes with
  // the lowest level value. It then saves their node state, disables them, and checks all their children.
  // Rather than storing child node information for every checked sub-tree regardless of depth, finding
  // the set of shallowest sub-tree nodes allows the component to store the minimum amount of node
  // information and simplifies the process of restoring it later.
  #includeSubItems() {
    if (!this.treeView) return

    for (const subTree of this.treeView.rootSubTreeNodes()) {
      for (const checkedSubTree of this.eachShallowestCheckedSubTree(subTree)) {
        this.#includeSubItemsUnder(checkedSubTree)
      }
    }
  }

  // Records the state of all the nodes in the given sub-tree. Node state includes whether or not the
  // node is checked, and whether or not it is disabled. Or at least, that's what it included when this
  // comment was first written. Check the members of the NodeState type above for up-to-date info.
  #includeSubItemsUnder(subTree: TreeViewSubTreeNodeElement) {
    if (!this.treeView) return

    const descendantStates: Map<HTMLElement, NodeState> = new Map()

    for (const node of subTree.eachDescendantNode()) {
      descendantStates.set(node as HTMLElement, {
        checked: this.treeView.getNodeCheckedValue(node) === 'true',
        disabled: this.treeView.getNodeDisabledValue(node),
      })

      this.treeView.setNodeCheckedValue(node, 'true')
      this.treeView.setNodeDisabledValue(node, true)
    }

    this.#stateMap.set(subTree, descendantStates)
  }

  // Revert all nodes back to their saved state, i.e. from before we automatically checked and disabled
  // everything.
  #restoreAllNodeStates() {
    for (const subTree of this.#stateMap.keys()) {
      this.#restoreNodeState(subTree)
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
        // Only match nodes that have been checked
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
   *
   * Whether or not a node matches is determined by a filter function with a `FilterFn` signature. The
   * component defines a default filter function, but a user-defined one can also be provided. The filter
   * function is expected to return an array of `Range` objects which #applyFilterOptions uses to highlight
   * node text that matches the query string. The default filter function identifies matching node text by
   * looking for an exact substring match, operating on a lowercased version of both the query string and
   * the node text. For an exact description of the expected return values of the filter function, please
   * see the FilterFn type above.
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

    // This function is called in the loop below for both leaf  nodes and sub-tree nodes to determine
    // if they match, and subsequently whether or not to hide them. However, it serves a secondary purpose
    // as well in that it remembers the range information returned by the filter function so it can be
    // used to highlight matching ranges later.
    const cachedFilterFn = (node: HTMLElement, queryStr: string, filterMode?: string): boolean => {
      if (!filterRangesCache.has(node)) {
        filterRangesCache.set(node, this.filterFn(node, queryStr, filterMode))
      }

      return filterRangesCache.get(node)! !== null
    }

    /* We iterate depth-first here in order to be able to examine the most deeply nested leaf nodes
     * before their parents. This enables us to easily hide the parent if none of its children match.
     * To handle expanding and collapsing ancestors, the algorithm iterates over the provided ancestor
     * chain, expanding "upwards" to the root.
     *
     * Using this technique does mean it's possible to iterate over the same ancestor multiple times.
     * For example, consider two nodes that share the same ancestor. Node A contains matching children,
     * but node B does not. The algorithm below will visit node A first and expand it and all its
     * ancestors. Next, the algorithm will visit node B and collapse all its ancestors. To avoid this,
     * the algorithm attaches a random "generation ID" to each node visited. If the generation ID
     * matches when visiting a particular node, we know that node has already been visited and should
     * not be hidden or collapsed.
     */
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
      }

      if (atLeastOneLeafMatches) {
        expandAncestors(...ancestors)
      } else {
        if (parent) {
          if (cachedFilterFn(parent.node, query, mode)) {
            // sub-tree matched, so expand ancestors
            expandAncestors(...ancestors)
          } else {
            // this node has already been marked by the current generation and is therefore
            // a shared ancestor - don't collapse or hide it
            if (parent.getAttribute('data-generation') !== generation) {
              parent.collapse()
              parent.setAttribute('hidden', 'hidden')
            }
          }
        }
      }
    }

    // convert range map into a 1-dimensional array with no nulls so it can be given to
    // #applyHighlights (and therefore CSS.highlights.set) more easily
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
    const textNode = ranges[0].startContainer
    const parent = textNode.parentNode!
    const originalText = textNode.textContent!
    const fragments = []
    let lastIndex = 0

    for (const {startOffset, endOffset} of ranges) {
      // text before the highlight
      if (startOffset > lastIndex) {
        fragments.push(document.createTextNode(originalText.slice(lastIndex, startOffset)))
      }

      // highlighted text
      const mark = document.createElement('mark')
      mark.textContent = originalText.slice(startOffset, endOffset)
      fragments.push(mark)

      lastIndex = endOffset
    }

    // remaining text after the last highlight
    if (lastIndex < originalText.length) {
      fragments.push(document.createTextNode(originalText.slice(lastIndex)))
    }

    // replace original text node with our text + <mark> elements
    for (const frag of fragments.reverse()) {
      parent.insertBefore(frag, textNode.nextSibling)
    }

    parent.removeChild(textNode)
  }

  #removeHighlights() {
    // quick-and-dirty way of ignoring any existing <mark> elements and restoring
    // the original text
    for (const mark of this.querySelectorAll('mark')) {
      if (!mark.parentElement) continue
      mark.parentElement.replaceChildren(mark.parentElement.textContent!)
    }
  }

  // Iterates over the nodes in the given sub-tree in depth-first order, yielding a list of leaf nodes
  // and an array of ancestor nodes. It uses the aria-level information attached to each node to determine
  // the next level of the tree to visit.
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

  // Yields only the shallowest (i.e. lowest depth) sub-tree nodes that are checked, i.e. does not
  // visit a sub-tree's children if that sub-tree is checked.
  *eachShallowestCheckedSubTree(root: TreeViewSubTreeNodeElement): Generator<TreeViewSubTreeNodeElement> {
    if (this.treeView?.getNodeCheckedValue(root.node) === 'true') {
      yield root
      return // do not descend further
    }

    for (const childSubTree of root.eachDirectDescendantSubTreeNode()) {
      yield* this.eachShallowestCheckedSubTree(childSubTree)
    }
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
