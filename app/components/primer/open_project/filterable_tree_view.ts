import {controller, target} from '@github/catalyst'
import {SegmentedControlElement} from '../alpha/segmented_control'
import {TreeViewElement} from './tree_view/tree_view'
import {TreeViewSubTreeNodeElement} from './tree_view/tree_view_sub_tree_node_element'

export type FilterFn = (item: HTMLElement, query: string, filterMode?: string) => boolean

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

  defaultFilterFn(node: HTMLElement, query: string, filterMode?: string): boolean {
    const matches = query === '' || node.textContent?.toLocaleLowerCase().includes(query.toLocaleLowerCase()) || false

    switch (filterMode) {
      case 'selected': {
        return matches && this.treeView?.getNodeCheckedValue(node) !== 'false'
      }

      case 'all': {
        return matches
      }

      default: {
        return matches
      }
    }
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

    const query = this.queryString
    const mode = this.filterMode || undefined
    const generation = window.crypto.randomUUID()

    const expandAncestors = (ancestors: TreeViewSubTreeNodeElement[]) => {
      for (const ancestor of ancestors) {
        ancestor.expand()
        ancestor.removeAttribute('hidden')
        ancestor.setAttribute('data-generation', generation)

        if (this.filterFn(ancestor.node, query, mode)) {
          ancestor.node.removeAttribute('aria-disabled')
        } else {
          ancestor.node.setAttribute('aria-disabled', 'true')
        }
      }
    }

    for (const [leafNodes, ancestors] of this.eachDescendantDepthFirst(this.treeViewList, [])) {
      let atLeastOneLeafMatches = false

      for (const leafNode of leafNodes) {
        if (this.filterFn(leafNode, query, mode)) {
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
          if (this.filterFn(parent.node, query, mode)) {
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
