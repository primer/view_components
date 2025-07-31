export type ItemActivatedEvent = {
  item: Element
  checked: boolean
  value: string | null
}

export type TreeViewNodeType = 'leaf' | 'sub-tree'
export type TreeViewCheckedValue = 'true' | 'false' | 'mixed'

export type TreeViewNodeInfo = {
  node: Element
  type: TreeViewNodeType
  path: string[]
  checkedValue: TreeViewCheckedValue
  previousCheckedValue: TreeViewCheckedValue
}

declare global {
  interface HTMLElementEventMap {
    itemActivated: CustomEvent<ItemActivatedEvent>
    beforeItemActivated: CustomEvent<ItemActivatedEvent>

    treeViewNodeActivated: CustomEvent<TreeViewNodeInfo>
    treeViewBeforeNodeActivated: CustomEvent<TreeViewNodeInfo>
    treeViewNodeExpanded: CustomEvent<TreeViewNodeInfo>
    treeViewNodeCollapsed: CustomEvent<TreeViewNodeInfo>

    treeViewNodeChecked: CustomEvent<TreeViewNodeInfo[]>
    treeViewBeforeNodeChecked: CustomEvent<TreeViewNodeInfo[]>
  }
}
