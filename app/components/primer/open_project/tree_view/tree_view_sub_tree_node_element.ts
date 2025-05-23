import {controller, target} from '@github/catalyst'
import {TreeViewIconPairElement} from './tree_view_icon_pair_element'
import {observeMutationsUntilConditionMet} from '../../utils'
import {TreeViewIncludeFragmentElement} from './tree_view_include_fragment_element'
import {TreeViewElement} from './tree_view'
import type {TreeViewNodeInfo} from '../../shared_events'

type LoadingState = 'loading' | 'error' | 'success'

@controller
export class TreeViewSubTreeNodeElement extends HTMLElement {
  @target node: HTMLElement
  @target subTree: HTMLElement
  @target iconPair: TreeViewIconPairElement
  @target toggleButton: HTMLElement
  @target expandedToggleIcon: HTMLElement
  @target collapsedToggleIcon: HTMLElement
  @target includeFragment: TreeViewIncludeFragmentElement
  @target loadingIndicator: HTMLElement
  @target loadingFailureMessage: HTMLElement
  @target retryButton: HTMLButtonElement

  #expanded: boolean | null = null
  #loadingState: LoadingState = 'success'
  #abortController: AbortController
  #activeElementIsLoader: boolean = false

  connectedCallback() {
    observeMutationsUntilConditionMet(
      this,
      () => Boolean(this.node) && Boolean(this.subTree),
      () => {
        this.#update()
      },
    )

    const {signal} = (this.#abortController = new AbortController())
    this.addEventListener('click', this, {signal})
    this.addEventListener('keydown', this, {signal})

    observeMutationsUntilConditionMet(
      this,
      () => Boolean(this.includeFragment),
      () => {
        this.includeFragment.addEventListener('loadstart', this, {signal})
        this.includeFragment.addEventListener('error', this, {signal})
        this.includeFragment.addEventListener('include-fragment-replace', this, {signal})
        this.includeFragment.addEventListener(
          'include-fragment-replaced',
          (e: Event) => {
            this.#handleIncludeFragmentEvent(e)
          },
          {signal},
        )
      },
    )

    observeMutationsUntilConditionMet(
      this,
      () => Boolean(this.retryButton),
      () => {
        this.retryButton.addEventListener(
          'click',
          event => {
            this.#handleRetryButtonEvent(event)
          },
          {signal},
        )
      },
    )

    const checkedMutationObserver = new MutationObserver(() => {
      if (this.selectStrategy !== 'descendants') return

      let checkType = 'unknown'

      for (const node of this.eachDirectDescendantNode()) {
        switch (`${checkType} ${node.getAttribute('aria-checked') || 'false'}`) {
          case 'unknown mixed':
          case 'false mixed':
          case 'true mixed':
          case 'false true':
          case 'true false':
            checkType = 'mixed'
            break

          case 'unknown false':
            checkType = 'false'
            break

          case 'unknown true':
            checkType = 'true'
        }
      }

      if (checkType !== 'unknown' && this.node?.getAttribute('aria-checked') !== checkType) {
        this.node?.setAttribute('aria-checked', checkType)
      }
    })

    checkedMutationObserver.observe(this, {
      childList: true,
      subtree: true,
      attributeFilter: ['aria-checked'],
    })
  }

  get expanded(): boolean {
    if (this.#expanded === null) {
      this.#expanded = this.node.getAttribute('aria-expanded') === 'true'
    }

    return this.#expanded
  }

  set expanded(newValue: boolean) {
    this.#expanded = newValue
    this.#update()
  }

  get loadingState(): LoadingState {
    return this.#loadingState
  }

  set loadingState(newState: LoadingState) {
    this.#loadingState = newState
    this.#update()
  }

  get selectStrategy(): string {
    return this.node.getAttribute('data-select-strategy') || 'descendants'
  }

  disconnectedCallback() {
    this.#abortController.abort()
  }

  handleEvent(event: Event) {
    const checkbox = (event.target as Element).closest('.TreeViewItemCheckbox')

    if (checkbox && checkbox === this.#checkboxElement) {
      this.#handleCheckboxEvent(event)
    } else if (event.target === this.toggleButton) {
      this.#handleToggleEvent(event)
    } else if (event.target === this.includeFragment) {
      this.#handleIncludeFragmentEvent(event)
    } else if (event instanceof KeyboardEvent) {
      this.#handleKeyboardEvent(event)
    }
  }

  expand() {
    const alreadyExpanded = this.expanded

    this.expanded = true

    if (!alreadyExpanded && this.treeView) {
      this.treeView.dispatchEvent(
        new CustomEvent('treeViewNodeExpanded', {
          bubbles: true,
          detail: this.treeView?.infoFromNode(this.node),
        }),
      )
    }
  }

  collapse() {
    const alreadyCollapsed = !this.expanded

    this.expanded = false

    if (!alreadyCollapsed && this.treeView) {
      // Prevent issue where currently focusable node is stuck inside a collapsed
      // sub-tree and no node in the entire tree can be focused
      const previousNode = this.subTree.querySelector("[tabindex='0']")
      previousNode?.setAttribute('tabindex', '-1')
      this.node.setAttribute('tabindex', '0')

      this.treeView.dispatchEvent(
        new CustomEvent('treeViewNodeCollapsed', {
          bubbles: true,
          detail: this.treeView?.infoFromNode(this.node),
        }),
      )
    }
  }

  toggle() {
    if (this.expanded) {
      this.collapse()
    } else {
      this.expand()
    }
  }

  get nodes(): NodeListOf<Element> {
    return this.querySelectorAll(':scope > [role=treeitem]')
  }

  *eachDirectDescendantNode(): Generator<Element> {
    for (const leaf of this.subTree.querySelectorAll(':scope > [role=treeitem]')) {
      yield leaf
    }

    for (const subTree of this.subTree.querySelectorAll(':scope > tree-view-sub-tree-node > [role=treeitem]')) {
      yield subTree
    }
  }

  *eachDescendantNode(): Generator<Element> {
    for (const node of this.subTree.querySelectorAll('[role=treeitem]')) {
      yield node
    }
  }

  *eachAncestorSubTreeNode(): Generator<TreeViewSubTreeNodeElement> {
    if (!this.treeView) return

    // eslint-disable-next-line @typescript-eslint/no-this-alias
    let current: TreeViewSubTreeNodeElement | null = this

    while (current && this.treeView.contains(current)) {
      yield current

      current = current.parentElement?.closest('tree-view-sub-tree-node') as TreeViewSubTreeNodeElement | null
    }
  }

  get isEmpty(): boolean {
    return this.nodes.length === 0
  }

  get treeView(): TreeViewElement | null {
    return this.closest('tree-view')
  }

  #handleToggleEvent(event: Event) {
    if (event.type === 'click') {
      this.toggle()
    }
  }

  #handleIncludeFragmentEvent(event: Event) {
    switch (event.type) {
      // the request has started
      case 'loadstart':
        this.loadingState = 'loading'
        break

      // the request failed
      case 'error':
        this.loadingState = 'error'
        break

      // request succeeded but element has not yet been replaced
      case 'include-fragment-replace':
        this.#activeElementIsLoader = document.activeElement === this.loadingIndicator.closest('li')
        this.loadingState = 'success'
        break

      case 'include-fragment-replaced':
        if (this.#activeElementIsLoader) {
          const firstItem = this.querySelector('[role=treeitem] [role=group] > :first-child') as HTMLElement | null
          if (!firstItem) return

          if (firstItem.tagName.toLowerCase() === 'tree-view-sub-tree-node') {
            const firstChild = firstItem.querySelector('[role=treeitem]') as HTMLElement | null
            firstChild?.focus()
          } else {
            firstItem?.focus()
          }
        }

        this.#activeElementIsLoader = false
        break
    }
  }

  #handleRetryButtonEvent(event: Event) {
    if (event.type === 'click') {
      this.loadingState = 'loading'
      this.includeFragment.refetch()
    }
  }

  #handleKeyboardEvent(event: KeyboardEvent) {
    const node = (event.target as HTMLElement).closest('[role=treeitem]')
    if (!node || this.treeView?.getNodeType(node) !== 'sub-tree') {
      return
    }

    switch (event.key) {
      case 'Enter':
        // eslint-disable-next-line no-restricted-syntax
        event.stopPropagation()
        this.toggle()
        break

      case 'ArrowRight':
        // eslint-disable-next-line no-restricted-syntax
        event.stopPropagation()
        this.expand()
        break

      case 'ArrowLeft':
        // eslint-disable-next-line no-restricted-syntax
        event.stopPropagation()
        this.collapse()
        break

      case ' ':
        // eslint-disable-next-line no-restricted-syntax
        event.stopPropagation()
        event.preventDefault()
        this.toggleChecked()
        break
    }
  }

  #handleCheckboxEvent(event: Event) {
    if (event.type !== 'click') return

    this.toggleChecked()

    // prevent receiving this event twice
    // eslint-disable-next-line no-restricted-syntax
    event.stopPropagation()
  }

  toggleChecked() {
    const checkValue = this.node.getAttribute('aria-checked') || 'false'
    const newCheckValue = checkValue === 'false' ? 'true' : 'false'
    const nodeInfos: TreeViewNodeInfo[] = []
    const rootInfo = this.treeView?.infoFromNode(this.node, newCheckValue)
    if (rootInfo) nodeInfos.push(rootInfo)

    if (this.selectStrategy === 'descendants') {
      for (const node of this.eachDescendantNode()) {
        const info = this.treeView?.infoFromNode(node, newCheckValue)
        if (info) nodeInfos.push(info)
      }
    }

    const checkSuccess = this.dispatchEvent(
      new CustomEvent('treeViewBeforeNodeChecked', {
        bubbles: true,
        cancelable: true,
        detail: nodeInfos,
      }),
    )

    if (!checkSuccess) return

    for (const nodeInfo of nodeInfos) {
      nodeInfo.node.setAttribute('aria-checked', newCheckValue)
    }

    this.dispatchEvent(
      new CustomEvent('treeViewNodeChecked', {
        bubbles: true,
        cancelable: true,
        detail: nodeInfos,
      }),
    )
  }

  #update() {
    if (this.expanded) {
      if (this.subTree) this.subTree.hidden = false
      this.node.setAttribute('aria-expanded', 'true')
      this.treeView?.expandAncestorsForNode(this)

      if (this.iconPair) {
        this.iconPair.showExpanded()
      }

      if (this.expandedToggleIcon && this.collapsedToggleIcon) {
        this.expandedToggleIcon.removeAttribute('hidden')
        this.collapsedToggleIcon.setAttribute('hidden', 'hidden')
      }
    } else {
      if (this.subTree) this.subTree.hidden = true
      this.node.setAttribute('aria-expanded', 'false')

      if (this.iconPair) {
        this.iconPair.showCollapsed()
      }

      if (this.expandedToggleIcon && this.collapsedToggleIcon) {
        this.expandedToggleIcon.setAttribute('hidden', 'hidden')
        this.collapsedToggleIcon.removeAttribute('hidden')
      }
    }

    switch (this.loadingState) {
      case 'loading':
        if (this.loadingFailureMessage) this.loadingFailureMessage.hidden = true
        if (this.loadingIndicator) this.loadingIndicator.hidden = false
        break

      case 'error':
        if (this.loadingIndicator) this.loadingIndicator.hidden = true
        if (this.loadingFailureMessage) this.loadingFailureMessage.hidden = false
        break

      // success/init case
      default:
        if (this.loadingIndicator) this.loadingIndicator.hidden = true
        if (this.loadingFailureMessage) this.loadingFailureMessage.hidden = true
    }
  }

  get #checkboxElement(): HTMLElement | null {
    return this.querySelector('.TreeViewItemCheckbox')
  }
}

if (!window.customElements.get('tree-view-sub-tree-node')) {
  window.TreeViewSubTreeNodeElement = TreeViewSubTreeNodeElement
  window.customElements.define('tree-view-sub-tree-node', TreeViewSubTreeNodeElement)
}

declare global {
  interface Window {
    TreeViewSubTreeNodeElement: typeof TreeViewSubTreeNodeElement
  }
}
