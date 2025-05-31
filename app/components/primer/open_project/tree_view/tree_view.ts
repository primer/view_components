import {controller} from '@github/catalyst'
import {SelectStrategy, TreeViewSubTreeNodeElement} from './tree_view_sub_tree_node_element'
import {useRovingTabIndex} from './tree_view_roving_tab_index'
import type {TreeViewNodeType, TreeViewCheckedValue, TreeViewNodeInfo} from '../../shared_events'

@controller
export class TreeViewElement extends HTMLElement {
  #abortController: AbortController

  connectedCallback() {
    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('click', this, {signal})
    this.addEventListener('focusin', this, {signal})
    this.addEventListener('keydown', this, {signal})

    useRovingTabIndex(this)

    // catch-all for any straggler nodes that aren't available when connectedCallback runs
    new MutationObserver(mutations => {
      for (const mutation of mutations) {
        for (const addedNode of mutation.addedNodes) {
          if (!(addedNode instanceof HTMLElement)) continue

          // eslint-disable-next-line custom-elements/no-dom-traversal-in-connectedcallback
          if (addedNode.querySelector('[aria-expanded=true]')) {
            this.#autoExpandFrom(addedNode)
          }
        }
      }
    }).observe(this, {childList: true, subtree: true})

    // eslint-disable-next-line github/no-then -- We don't want to wait for this to resolve, just get on with it
    customElements.whenDefined('tree-view-sub-tree-node').then(() => {
      // depends on TreeViewSubTreeNodeElement#eachAncestorSubTreeNode, which may not be defined yet
      this.#autoExpandFrom(this)
    })
  }

  #autoExpandFrom(root: HTMLElement) {
    for (const element of root.querySelectorAll('[aria-expanded=true]')) {
      this.expandAncestorsForNode(element as HTMLElement)
    }
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    const node = this.#nodeForEvent(event)

    if (node) {
      this.#handleNodeEvent(node, event)
    }
  }

  #eventIsActivation(event: Event): boolean {
    return event.type === 'click'
  }

  #nodeForEvent(event: Event): Element | null {
    const target = event.target as Element
    const node = target.closest('[role=treeitem]')
    if (!node) return null

    if (target.closest('.TreeViewItemToggle')) return null
    if (target.closest('.TreeViewItemLeadingAction')) return null

    return node
  }

  #handleNodeEvent(node: Element, event: Event) {
    if (this.#eventIsCheckboxToggle(event, node)) {
      this.#handleCheckboxToggle(event, node)
    } else if (this.#eventIsActivation(event)) {
      this.#handleNodeActivated(event, node)
    } else if (event.type === 'focusin') {
      this.#handleNodeFocused(node)
    } else if (event instanceof KeyboardEvent) {
      this.#handleNodeKeyboardEvent(event, node)
    }
  }

  #eventIsCheckboxToggle(event: Event, node: Element) {
    return event.type === 'click' && this.nodeHasCheckBox(node)
  }

  #handleCheckboxToggle(event: Event, node: Element) {
    if (this.getNodeDisabledValue(node)) {
      event.preventDefault()
      return
    }

    // only handle checking of leaf nodes
    const type = this.getNodeType(node)
    if (type !== 'leaf') return

    if (this.getNodeCheckedValue(node) === 'true') {
      this.#setNodeCheckedValue(node, 'false')
    } else {
      this.#setNodeCheckedValue(node, 'true')
    }
  }

  #handleNodeActivated(event: Event, node: Element) {
    if (this.getNodeDisabledValue(node)) {
      event.preventDefault()
      return
    }

    // do not emit activation events for buttons and anchors, since it is assumed any activation
    // behavior for these element types is user- or browser-defined
    if (!(node instanceof HTMLDivElement)) return

    const path = this.getNodePath(node)

    const activationSuccess = this.dispatchEvent(
      new CustomEvent('treeViewBeforeNodeActivated', {
        bubbles: true,
        cancelable: true,
        detail: this.infoFromNode(node),
      }),
    )

    if (!activationSuccess) return

    // navigate or trigger button, don't toggle
    if (!this.nodeHasNativeAction(node)) {
      this.toggleAtPath(path)
    }

    this.dispatchEvent(
      new CustomEvent('treeViewNodeActivated', {
        bubbles: true,
        detail: this.infoFromNode(node),
      }),
    )
  }

  #handleNodeFocused(node: Element) {
    const previousNode = this.querySelector('[aria-selected=true]')
    previousNode?.setAttribute('aria-selected', 'false')
    node.setAttribute('aria-selected', 'true')
  }

  #handleNodeKeyboardEvent(event: KeyboardEvent, node: Element) {
    if (!node || this.getNodeType(node) !== 'leaf') {
      return
    }

    switch (event.key) {
      case ' ':
      case 'Enter':
        if (this.getNodeDisabledValue(node)) {
          event.preventDefault()
          break
        }

        if (this.nodeHasCheckBox(node)) {
          event.preventDefault()

          if (this.getNodeCheckedValue(node) === 'true') {
            this.#setNodeCheckedValue(node, 'false')
          } else {
            this.#setNodeCheckedValue(node, 'true')
          }
        } else if (node instanceof HTMLAnchorElement) {
          // simulate click on space
          node.click()
        }

        break
    }
  }

  getNodePath(node: Element): string[] {
    const rawPath = node.getAttribute('data-path')

    if (rawPath) {
      return JSON.parse(rawPath)
    }

    return []
  }

  getNodeType(node: Element): TreeViewNodeType | null {
    return node.getAttribute('data-node-type') as TreeViewNodeType | null
  }

  markCurrentAtPath(path: string[]) {
    const pathStr = JSON.stringify(path)
    const nodeToMark = this.querySelector(`[data-path="${CSS.escape(pathStr)}"`)
    if (!nodeToMark) return

    this.currentNode?.setAttribute('aria-current', 'false')
    nodeToMark.setAttribute('aria-current', 'true')
  }

  get currentNode(): HTMLLIElement | null {
    return this.querySelector('[aria-current=true]')
  }

  expandAtPath(path: string[]) {
    const node = this.subTreeAtPath(path)
    if (!node) return

    node.expand()
  }

  collapseAtPath(path: string[]) {
    const node = this.subTreeAtPath(path)
    if (!node) return

    node.collapse()
  }

  toggleAtPath(path: string[]) {
    const node = this.subTreeAtPath(path)
    if (!node) return

    node.toggle()
  }

  checkAtPath(path: string[]) {
    const node = this.nodeAtPath(path)
    if (!node) return

    this.#setNodeCheckedValue(node, 'true')
  }

  uncheckAtPath(path: string[]) {
    const node = this.nodeAtPath(path)
    if (!node) return

    this.#setNodeCheckedValue(node, 'false')
  }

  toggleCheckedAtPath(path: string[]) {
    const node = this.nodeAtPath(path)
    if (!node) return

    if (this.getNodeType(node) === 'leaf') {
      if (this.getNodeCheckedValue(node) === 'true') {
        this.uncheckAtPath(path)
      } else {
        this.checkAtPath(path)
      }
    }
  }

  checkedValueAtPath(path: string[]): TreeViewCheckedValue {
    const node = this.nodeAtPath(path)
    if (!node) return 'false'

    return this.getNodeCheckedValue(node)
  }

  disabledValueAtPath(path: string[]): boolean {
    const node = this.nodeAtPath(path)
    if (!node) return false

    return this.getNodeDisabledValue(node)
  }

  nodeAtPath(path: string[], selector?: string): Element | null {
    const pathStr = JSON.stringify(path)
    return this.querySelector(`${selector || ''}[data-path="${CSS.escape(pathStr)}"]`)
  }

  subTreeAtPath(path: string[]): TreeViewSubTreeNodeElement | null {
    const node = this.nodeAtPath(path, '[data-node-type=sub-tree]')
    if (!node) return null

    return node.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement | null
  }

  leafAtPath(path: string[]): HTMLLIElement | null {
    return this.nodeAtPath(path, '[data-node-type=leaf]') as HTMLLIElement | null
  }

  #setNodeCheckedValue(node: Element, value: TreeViewCheckedValue) {
    node.setAttribute('aria-checked', value.toString())
  }

  getNodeCheckedValue(node: Element): TreeViewCheckedValue {
    return (node.getAttribute('aria-checked') || 'false') as TreeViewCheckedValue
  }

  getNodeDisabledValue(node: Element): boolean {
    return node.getAttribute('aria-disabled') === 'true'
  }

  nodeHasCheckBox(node: Element): boolean {
    return node.querySelector('.TreeViewItemCheckbox') !== null
  }

  nodeHasNativeAction(node: Element): boolean {
    return node instanceof HTMLAnchorElement || node instanceof HTMLButtonElement
  }

  expandAncestorsForNode(node: HTMLElement) {
    const subTreeNode = node.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement
    if (!subTreeNode) return

    for (const ancestor of subTreeNode.eachAncestorSubTreeNode()) {
      if (!ancestor.expanded) {
        ancestor.expand()
      }
    }
  }

  changeSelectStrategy(newStrategy: SelectStrategy) {
    for (const subTreeNode of this.querySelectorAll<TreeViewSubTreeNodeElement>('tree-view-sub-tree-node')) {
      subTreeNode.changeSelectStrategy(newStrategy)
    }
  }

  // PRIVATE API METHOD
  //
  // This would normally be marked private, but it's called by TreeViewSubTreeNodes
  // and thus must be public.
  infoFromNode(node: Element, newCheckedValue?: TreeViewCheckedValue): TreeViewNodeInfo | null {
    const type = this.getNodeType(node)
    if (!type) return null

    const checkedValue = this.getNodeCheckedValue(node)

    return {
      node,
      type,
      path: this.getNodePath(node),
      checkedValue: newCheckedValue || checkedValue,
      previousCheckedValue: checkedValue,
    }
  }
}

if (!window.customElements.get('tree-view')) {
  window.TreeViewElement = TreeViewElement
  window.customElements.define('tree-view', TreeViewElement)
}

declare global {
  interface Window {
    TreeViewElement: typeof TreeViewElement
  }
}
