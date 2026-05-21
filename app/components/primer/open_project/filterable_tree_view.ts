import {controller, target} from '@github/catalyst'
import {SegmentedControlElement} from '../alpha/segmented_control'
import {TreeViewElement} from '../alpha/tree_view/tree_view'
import {TreeViewSubTreeNodeElement} from '../alpha/tree_view/tree_view_sub_tree_node_element'
// eslint-disable-next-line import/named
import {TreeViewCheckedValue, TreeViewNodeInfo} from '../shared_events'

// This function is expected to return the following values:
// 1. No match - return null
// 2. Match but no highlights - empty array (i.e. when showing all selected nodes but empty query string)
// 3. Match with highlights - non-empty array of Range objects
export type FilterFn = (node: HTMLElement, query: string, filterMode?: string) => Range[] | null

type NodeState = {
  checked: boolean
  disabled: boolean
}

const ASYNC_DEBOUNCE_MS = 300

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

  // Async mode state
  #debounceTimer: ReturnType<typeof setTimeout> | null = null
  #fetchAbortController: AbortController | null = null
  // nodeId → wasExpanded: taken once before the first filter query is entered, cleared when filter is removed
  #expansionSnapshot: Map<string, boolean> | null = null
  // nodeId → wasExpanded: taken before entering "selected" mode, cleared when leaving it
  #selectedModeSnapshot: Map<string, boolean> | null = null
  // nodeId → checkedValue: persists across tree replacements, updated on every treeViewNodeChecked event
  #checkedNodeIds: Map<string, TreeViewCheckedValue> = new Map()
  // nodeId → form payload: mirrors #checkedNodeIds but stores the data needed to synthesise a hidden
  // form input for nodes that are checked but not currently in the DOM (e.g. filtered out).
  #checkedNodeFormPayloads: Map<string, {path: string[]; value?: string}> = new Map()
  #isFiltered = false

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('treeViewNodeChecked', this, {signal})
    this.addEventListener('itemActivated', this, {signal})
    this.addEventListener('input', this, {signal})

    if (this.#isAsyncMode) {
      void this.#fetchAndReplaceTree()
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
    this.#fetchAbortController?.abort()
    if (this.#debounceTimer !== null) clearTimeout(this.#debounceTimer)
  }

  get #src(): string | null {
    return this.getAttribute('src')
  }

  get #isAsyncMode(): boolean {
    return !!this.#src
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
        // Always track checked node IDs before delegating, so async replacements can restore selection.
        this.#updateCheckedNodeIds(event)
        this.#handleTreeViewNodeChecked(event)
        break
    }
  }

  // Keeps #checkedNodeIds and #checkedNodeFormPayloads in sync with every user-triggered check event
  // so we can restore selection and synthesise form inputs after async tree replacements, even for
  // nodes that are no longer visible (e.g. filtered out by the server).
  #updateCheckedNodeIds(event: CustomEvent<TreeViewNodeInfo[]>) {
    if (!this.#isAsyncMode) return

    for (const nodeInfo of event.detail) {
      const node = nodeInfo.node as HTMLElement
      const nodeId = node.getAttribute('data-node-id')
      if (nodeId) {
        if (nodeInfo.checkedValue === 'false') {
          this.#checkedNodeIds.delete(nodeId)
          this.#checkedNodeFormPayloads.delete(nodeId)
        } else {
          // In single-select mode, TreeView clears the previous selection internally
          // (via checkOnlyAtPath) but the treeViewNodeChecked event only contains the
          // newly selected node. Clear our tracked state so #restoreSelectionState does
          // not re-check previously selected nodes after a tree replacement.
          if (node.getAttribute('data-select-variant') === 'single') {
            this.#checkedNodeIds.clear()
            this.#checkedNodeFormPayloads.clear()
          }

          this.#checkedNodeIds.set(nodeId, nodeInfo.checkedValue)
          const payload: {path: string[]; value?: string} = {path: nodeInfo.path}
          const dataValue = node.getAttribute('data-value')
          if (dataValue) payload.value = dataValue
          this.#checkedNodeFormPayloads.set(nodeId, payload)
        }
      }
    }

    this.#updateRetainedSelections()
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

    if (this.#isAsyncMode) {
      if (this.filterMode === 'selected') {
        // "selected" mode is client-side: snapshot expansion state before the filter collapses nodes,
        // then apply client-side filter without a server round-trip.
        this.#selectedModeSnapshot = this.#captureExpansionState()
        this.#applyFilterOptions()
      } else if (this.#selectedModeSnapshot !== null && this.queryString.length === 0) {
        // Leaving "selected" mode with no active query: undo client-side filter and restore expansion
        // state without a server round-trip (the full tree is already in the DOM).
        this.#undoClientSideFilter()
        this.#applyExpansionSnapshot(this.#selectedModeSnapshot)
        this.#selectedModeSnapshot = null
      } else {
        // "all" mode with an active query, or switching away from a custom mode: use async fetch.
        this.#selectedModeSnapshot = null
        this.#scheduleAsyncFetch()
      }
    } else {
      this.#applyFilterOptions()
    }
  }

  // Removes `hidden` attributes added by the client-side filter from leaf list items and sub-tree nodes.
  #undoClientSideFilter() {
    for (const el of this.querySelectorAll<HTMLElement>('tree-view li[hidden], tree-view-sub-tree-node[hidden]')) {
      el.removeAttribute('hidden')
    }
  }

  #handleFilterInputEvent(event: Event) {
    if (event.type !== 'input') return

    // "selected" mode is always client-side – the server doesn't know the selection state.
    if (this.#isAsyncMode && this.filterMode !== 'selected') {
      this.#scheduleAsyncFetch()
    } else {
      this.#applyFilterOptions()
    }
  }

  #handleIncludeSubItemsCheckBoxEvent(event: Event) {
    if (!this.treeView) return
    if (event.type !== 'input') return

    // In async mode, toggling include-sub-items does not require a server round-trip: the client
    // handles the visual state entirely (checking/disabling visible descendants). The flag will be
    // included automatically in the next filter request triggered by a query or filter-mode change.
    if (!this.#isAsyncMode) {
      this.#applyFilterOptions()
    }

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

  // ─── Async mode ────────────────────────────────────────────────────────────

  #scheduleAsyncFetch() {
    if (this.#debounceTimer !== null) clearTimeout(this.#debounceTimer)

    this.#debounceTimer = setTimeout(() => {
      this.#debounceTimer = null
      void this.#fetchAndReplaceTree()
    }, ASYNC_DEBOUNCE_MS)
  }

  async #fetchAndReplaceTree() {
    const src = this.#src
    if (!src) return

    const query = this.queryString
    const filterMode = this.filterMode || 'all'
    const includeSubItems = this.includeSubItemsCheckBox?.checked ?? false

    // Snapshot expansion state the first time the user enters a filter query
    if (!this.#isFiltered && query.length > 0) {
      this.#snapshotExpansionState()
      this.#isFiltered = true
    } else if (this.#isFiltered && query.length === 0) {
      this.#isFiltered = false
    }

    // Remember which filter state this particular request was for so we apply
    // the correct post-processing even if the user types quickly.
    const requestWasFiltered = query.length > 0

    // Abort any in-flight request
    this.#fetchAbortController?.abort()
    const {signal} = (this.#fetchAbortController = new AbortController())

    const url = new URL(src, window.location.href)
    url.searchParams.set('query', query)
    url.searchParams.set('filter_mode', filterMode)
    url.searchParams.set('include_sub_items', String(includeSubItems))

    // Send currently-checked node IDs so the server can apply include-sub-items
    // logic even for nodes that are no longer visible due to filtering / pagination.
    for (const nodeId of this.#checkedNodeIds.keys()) {
      url.searchParams.append('checked_ids[]', nodeId)
    }

    this.setAttribute('data-loading', '')
    this.setAttribute('aria-busy', 'true')

    try {
      const response = await fetch(url.toString(), {
        signal,
        headers: {Accept: 'text/html'},
        credentials: 'same-origin',
        method: 'GET',
      })
      if (!response.ok) return

      const html = await response.text()
      const doc = new DOMParser().parseFromString(html, 'text/html')
      const newTreeView = doc.querySelector('tree-view')
      if (!newTreeView) return

      const oldTreeView = this.treeViewList?.closest('tree-view')
      if (!oldTreeView) return

      // Invalidate old stateMap entries – the referenced DOM nodes no longer exist after replacement.
      this.#stateMap.clear()

      oldTreeView.replaceWith(newTreeView)
      // Catalyst re-resolves @target treeViewList dynamically on next access.

      // Restore checked state for all nodes that now appear in the new tree.
      this.#restoreSelectionState()

      // Re-apply include-sub-items visually if the checkbox is still checked.
      if (includeSubItems) {
        this.#includeSubItems()
      }

      if (requestWasFiltered) {
        this.#expandAllSubTrees()
        this.#applyAsyncHighlights(query)
        const hasResults = !!this.treeViewList?.querySelector('[role=treeitem]')
        this.noResultsMessage.toggleAttribute('hidden', hasResults)
        this.treeViewList?.toggleAttribute('hidden', !hasResults)
      } else {
        this.#removeHighlights()
        this.#restoreExpansionState()
        this.noResultsMessage.setAttribute('hidden', 'hidden')
        this.treeViewList?.removeAttribute('hidden')
      }

      // Synthesise form inputs for nodes that are checked but absent from the current DOM
      // (e.g. filtered out). Must run after restoreSelectionState so we know what is in the DOM.
      this.#updateRetainedSelections()
    } catch (e) {
      if ((e as Error).name === 'AbortError') return
      throw e
    } finally {
      this.removeAttribute('data-loading')
      this.setAttribute('aria-busy', 'false')
    }
  }

  // Captures the current expanded/collapsed state of every sub-tree node as a nodeId → boolean map.
  #captureExpansionState(): Map<string, boolean> {
    const snapshot = new Map<string, boolean>()
    for (const treeitem of this.querySelectorAll<HTMLElement>(
      '[role=treeitem][data-node-id][data-node-type=sub-tree]',
    )) {
      snapshot.set(treeitem.getAttribute('data-node-id')!, treeitem.getAttribute('aria-expanded') === 'true')
    }
    return snapshot
  }

  // Applies a previously captured expansion snapshot to the current tree.
  #applyExpansionSnapshot(snapshot: Map<string, boolean>) {
    for (const [nodeId, wasExpanded] of snapshot) {
      const treeitem = this.querySelector<HTMLElement>(`[role=treeitem][data-node-id="${CSS.escape(nodeId)}"]`)
      const subTreeNode = treeitem?.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement | null
      if (subTreeNode) {
        if (wasExpanded) {
          subTreeNode.expand()
        } else {
          subTreeNode.collapse()
        }
      }
    }
  }

  // Saves the expanded/collapsed state of every sub-tree node before the first filter query is applied.
  #snapshotExpansionState() {
    this.#expansionSnapshot = this.#captureExpansionState()
  }

  // Restores the expansion state that was saved before filtering began, then discards the snapshot.
  #restoreExpansionState() {
    if (!this.#expansionSnapshot) return
    this.#applyExpansionSnapshot(this.#expansionSnapshot)
    this.#expansionSnapshot = null
  }

  // Re-applies checked values from #checkedNodeIds to every node that exists in the current tree.
  #restoreSelectionState() {
    if (!this.treeView) return

    for (const treeitem of this.querySelectorAll<HTMLElement>('[role=treeitem][data-node-id]')) {
      const nodeId = treeitem.getAttribute('data-node-id')!
      const savedValue = this.#checkedNodeIds.get(nodeId)
      if (savedValue !== undefined) {
        this.treeView.setNodeCheckedValue(treeitem, savedValue)
      }
    }
  }

  // Expands every sub-tree node in the current tree – used after a filtered result is rendered so all
  // matches and their ancestors are visible.
  #expandAllSubTrees() {
    for (const subTreeNode of this.querySelectorAll<TreeViewSubTreeNodeElement>('tree-view-sub-tree-node')) {
      subTreeNode.expand()
    }
  }

  // Applies highlights based on the current query string to whatever tree is in the DOM.  Unlike the
  // client-side path, filtering is already done by the server, so we only need to produce highlights.
  #applyAsyncHighlights(query: string) {
    this.#removeHighlights()
    const ranges: Range[] = []

    for (const treeitem of this.querySelectorAll<HTMLElement>('[role=treeitem]')) {
      const result = this.defaultFilterFn(treeitem, query, 'all')
      if (result) ranges.push(...result)
    }

    if (ranges.length > 0) this.#applyHighlights(ranges)
  }

  // Maintains hidden form inputs (with the same name as the TreeView's own inputs) for nodes that are
  // checked but currently absent from the DOM (e.g. filtered out by the server). These inputs live
  // directly inside <filterable-tree-view> – outside <tree-view> – so they survive tree replacements.
  // The server therefore receives a complete set of checked paths regardless of what is currently visible.
  #updateRetainedSelections() {
    // Only relevant when a form is wired up.
    const prototype = this.treeView?.formInputPrototype
    if (!prototype) return

    // Remove previously injected retained inputs.
    for (const el of this.querySelectorAll('[data-filterable-tree-view-retained]')) {
      el.remove()
    }

    for (const [nodeId, payload] of this.#checkedNodeFormPayloads) {
      // Nodes currently in the DOM are already covered by TreeView's updateHiddenFormInputs.
      const inDom = !!this.querySelector(`[role=treeitem][data-node-id="${CSS.escape(nodeId)}"]`)
      if (inDom) continue

      const input = document.createElement('input')
      input.type = 'hidden'
      input.name = prototype.name
      input.value = JSON.stringify(payload)
      input.setAttribute('data-filterable-tree-view-retained', '')
      this.appendChild(input)
    }
  }

  // ─── End async mode ─────────────────────────────────────────────────────────

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
