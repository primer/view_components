# frozen_string_literal: true

# The TreeView component is made up of a number of smaller components, quite a few more than have been created
# to construct complex components in the past. The current architecture was designed to achieve reusability for
# certain features like loading indicators, different icons for expanded and collapsed sub trees, etc. The
# following describes how the components fit together at a high level, using React-like syntax. Each element
# in the diagram corresponds to one of three types of object:
#
# 1. Elements with TitleCase tags represent components in the Primer::OpenProject::TreeView namespace, eg. <LeafNode>.
# 2. Elements with dasherized-tags are web components/custom elements, eg. <tree-view>.
# 3. Elements with lowercase tags are regular 'ol HTML elements, eg. <ul>.
#
# ### Overall structure
#
# <TreeView>
#   <tree-view>
#     <ul role="tree">
#       <LeafNode>
#         <Node>
#           <li role="none">
#             <div role="treeitem">
#               ...
#             </div>
#           </li>
#         </Node>
#       </LeafNode>
#
#       <SubTreeNode>
#         <tree-view-sub-tree-node>
#           <li role="none">
#
#             <SubTreeContainer>
#               <ul role="group">
#                 <SubTree>
#                   <LeafNode>
#                     <Node>
#                       <li role="none">
#                         <div role="treeitem">
#                           ...
#                         </div>
#                       </li>
#                     </Node>
#                   </LeafNode>
#
#                   <SubTreeNode>
#                     <tree-view-sub-tree-node>
#                       <Node>
#                         <li role="none">
#                           <div role="treeitem">
#                             ...
#                           </div>
#                         </li>
#                       </Node>
#                       <SubTreeContainer>
#                         <ul role="group">
#                           ...
#                         </ul>
#                       </SubTreeContainer>
#                     </tree-view-sub-tree-node>
#                   </SubTreeNode>
#                 </SubTree>
#               </ul>
#             </SubTreeContainer>
#
#           </li>
#         </tree-view-sub-tree-node>
#       </SubTreeNode>
#     </ul>
#   </tree-view>
# </TreeView>
#
# ### Leading visuals
#
# TreeView nodes (i.e. both leaf and sub tree nodes) support leading and trailing visuals. At the time of this
# writing, only octicons are supported. The single icon case is achieved by using a standard slot, but the
# component also supports rendering distinct icons for both the expanded and collapsed states. An overview of the
# markup for this more complicated multi-icon feature is described below.
#
# <LeafNode>
#   <Node>
#     <li role="none">
#       <div role="treeitem">
#         <Visual>
#           <IconPair>
#             <tree-view-icon-pair>
#               <Icon slot="expanded_icon">
#                 <Primer::Beta::Octicon />
#               </Icon>
#               <Icon slot="collapsed_icon">
#                 <Primer::Beta::Octicon />
#               </Icon>
#             </tree-view-icon-pair>
#           </IconPair>
#         </Visual>
#       </div>
#     </li>
#   </Node>
# </LeafNode>
#
# ### Loaders
#
# TreeViews support two types of loader: a loading spinner and a loading skeleton.
#
# #### Loading spinner
#
# <SubTree>
#   <SpinnerLoader>
#     <tree-view-include-fragment>
#       <SubTreeContainer>
#         <Node>
#           <Primer::Beta::Spinner />
#         </Node>
#         <Node>
#           <LoadingFailureMessage />
#         </Node>
#       </SubTreeContainer>
#     </tree-view-include-fragment>
#   </SpinnerLoader>
# </SubTree>
#
# #### Loading skeleton
#
# <SubTree>
#   <SkeletonLoader>
#     <tree-view-include-fragment>
#       <SubTreeContainer>
#         <Node>
#           <span>
#             <Primer::Alpha::SkeletonBox width="16px" />
#             <Primer::Alpha::SkeletonBox width="100%" />
#           </span>
#           <span>
#             ...
#           </span>
#           ...
#         </Node>
#         <Node>
#           <LoadingFailureMessage />
#         </Node>
#       </SubTreeContainer>
#     </tree-view-include-fragment>
#   </SkeletonLoader>
# </SubTree>

module Primer
  module OpenProject
    # TreeView is a hierarchical list of items that may have a parent-child relationship where children
    # can be toggled into view by expanding or collapsing their parent item.
    #
    # ## Terminology
    #
    # Consider the following tree structure:
    #
    # src
    # ├ button.rb
    # └ action_list
    #   ├ item.rb
    #   └ header.rb
    #
    # 1. **Node**. A node is an item in the tree. Nodes can either be "leaf" nodes (i.e. have no children), or "sub-tree"
    # nodes, which do have children. In the example above, button.rb, item.rb, and header.rb are all leaf nodes, while
    # action_list is a sub-tree node.
    # 2. **Path**. A node's path is like its ID. It's an array of strings containing the current node's label and all the
    # labels of its ancestors, in order. In the example above, header.rb's path is ["src", "action_list", "header.rb"].
    #
    # ## Static nodes
    #
    # The `TreeView` component allows items to be provided statically or loaded dynamically from the server.
    # Providing items statically is done using the `leaf` and `sub_tree` slots:
    #
    # ```erb
    # <%= render(Primer::OpenProject::TreeView.new) do |tree| %>
    #   <% tree.with_sub_tree(label: "Directory") do |sub_tree| %>
    #     <% sub_tree.with_leaf(label: "File 1")
    #   <% end %>
    #   <% tree.with_leaf(label: "File 2") %>
    # <% end %>
    # ```
    #
    # ## Dynamic nodes
    #
    # Tree nodes can also be fetched dynamically from the server and will require creating a Rails controller action
    # to respond with the list of nodes. Unlike other Primer components, `TreeView` allows the programmer to specify
    # loading behavior on a per-sub-tree basis, i.e. each sub-tree must specify how its nodes are loaded. To load nodes
    # dynamically for a given sub-tree, configure it with either a loading spinner or a loading skeleton, and provide
    # the URL to fetch nodes from:
    #
    # ```erb
    # <%= render(Primer::OpenProject::TreeView.new) do |tree| %>
    #   <% tree.with_sub_tree(label: "Directory") do |sub_tree| %>
    #     <% sub_tree.with_loading_spinner(src: tree_view_items_path) %>
    #   <% end %>
    # <% end %>
    # ```
    #
    # Define a controller action to serve the list of nodes. The `TreeView` component automatically includes the
    # sub-tree's path as a GET parameter, encoded as a JSON array.
    #
    # ```ruby
    # class TreeViewItemsController < ApplicationController
    #   def show
    #     @path = JSON.parse(params[:path])
    #     @results = get_tree_items(starting_at: path)
    #   end
    # end
    # ```
    #
    # Responses must be HTML fragments, eg. have a content type of `text/html+fragment`. This content type isn't
    # available by default in Rails, so you may have to register it eg. in an initializer:
    #
    # ```ruby
    # Mime::Type.register("text/fragment+html", :html_fragment)
    # ```
    #
    # Render a `Primer::OpenProject::TreeView::SubTree` in the action's template, tree_view_items/show.html_fragment.erb:
    #
    # ```erb
    # <%= render(Primer::OpenProject::TreeView::SubTree.new(path: @path)) do |tree| %>
    #   <% tree.with_leaf(...) %>
    #   <% tree.with_sub_tree(...) do |sub_tree| %>
    #     ...
    #   <% end %>
    # <% end %>
    # ```
    #
    # ## Multi-select mode
    #
    # Passing `select_variant: :multiple` to both sub-tree and leaf nodes will add a check box to the left of the node's
    # label. These check boxes behave according to the value of a second argument, `select_strategy:`.
    #
    # The default select strategy, `:descendants`, will cause all child nodes to be checked when the node is checked.
    # This includes both sub-tree and leaf nodes. When the node is unchecked, all child nodes will also be unchecked.
    # Unchecking a child node of a checked parent will cause the parent to enter a mixed or indeterminate state, which
    # is represented by a horizontal line icon instead of a check mark. This icon indicates that some children are
    # checked, but not all.
    #
    # A secondary select strategy, `:self`, is provided to allow disabling the automatic checking of child nodes. When
    # `select_strategy: :self` is specified, checking sub-tree nodes does not check child nodes, and sub-tree nodes
    # cannot enter a mixed or indeterminate state.
    #
    # Nodes can be checked via the keyboard by pressing the space key.
    #
    # ## Node tags
    #
    # `TreeView` nodes support three different HTML tags: `:a` (anchor), `:button`, and `:div` (the default). Both
    # anchors and buttons are browser-native elements, and can be activated (i.e. "clicked") using the mouse or keyboard
    # via the enter or space keys.
    #
    # Nodes with tags other than `:div` cannot have check boxes.
    #
    # ## Interaction behavior matrix
    #
    # |Interaction     |Select variant|Tag          |Result                     |
    # |:---------------|:-------------|:------------|:--------------------------|
    # |Enter/space     |none          |div          |Expands/collapses          |
    # |Enter/space     |none          |anchor/button|Activates anchor/button    |
    # |Enter/space     |multiple      |div          |Enter expands, space checks|
    # |Enter/space     |multiple      |anchor/button|N/A (not allowed)          |
    # |Left/right arrow|none          |div          |Expands/collapses          |
    # |Left/right arrow|none          |anchor/button|Expands/collapses          |
    # |Left/right arrow|multiple      |div          |Expands/collapses          |
    # |Left/right arrow|multiple      |anchor/button|Expands/collapses          |
    # |Click           |none          |div          |Expands/collapses          |
    # |Click           |none          |anchor/button|Activates anchor/button    |
    # |Click           |multiple      |div          |Expands/collapses          |
    # |Click           |multiple      |anchor/button|N/A (not allowed)          |
    #
    # ## JavaScript API
    #
    # `TreeView`s render a `<tree-view>` custom element that exposes behavior to the client.
    #
    # |Name                                                              |Notes                                                                                                                                             |
    # |:-----------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------|
    # |`getNodePath(node: Element): string[]`                            |Returns the path to the given node.                                                                                                               |
    # |`getNodeType(node: Element): TreeViewNodeType | null`             |Returns either `"leaf"` or `"sub-tree"`.                                                                                                          |
    # |`markCurrentAtPath(path: string[])`                               |Marks the node as the "current" node, which appears visually distinct from other nodes.                                                           |
    # |`get currentNode(): HTMLLIElement | null`                         |Returns the current node.                                                                                                                         |
    # |`expandAtPath(path: string[])`                                    |Expands the sub-tree at `path`.                                                                                                                   |
    # |`collapseAtPath(path: string[])`                                  |Collapses the sub-tree at `path`.                                                                                                                 |
    # |`toggleAtPath(path: string[])`                                    |If the sub-tree at `path` is collapsed, this function expands it, and vice-versa.                                                                 |
    # |`checkAtPath(path: string[])`                                     |If the node at `path` has a checkbox, this function checks it.                                                                                    |
    # |`uncheckAtPath(path: string[])`                                   |If the node at `path` has a checkbox, this function unchecks it.                                                                                  |
    # |`toggleCheckedAtPath(path: string[])`                             |If the sub-tree at `path` is checked, this function unchecks it, and vice-versa.                                                                  |
    # |`checkedValueAtPath(path: string[]): TreeViewCheckedValue`        |Returns `"true"` (all child nodes are checked), `"false"` (no child nodes are checked), or `"mixed"` (some child nodes are checked, some are not).|
    # |`nodeAtPath(path: string[], selector?: string): Element | null`   |Returns the node for the given `path`, either a leaf node or sub-tree node.                                                                       |
    # |`subTreeAtPath(path: string[]): TreeViewSubTreeNodeElement | null`|Returns the sub-tree at the given `path`, if it exists.                                                                                           |
    # |`leafAtPath(path: string[]): HTMLLIElement | null`                |Returns the leaf node at the given `path`, if it exists.                                                                                          |
    # |`getNodeCheckedValue(node: Element): TreeViewCheckedValue`        |The same as `checkedValueAtPath`, but accepts a node instead of a path.                                                                           |
    #
    # ### Events
    #
    # The events enumerated below include node information by way of the `TreeViewNodeInfo` object, which has the
    # following signature:
    #
    # ```typescript
    # type TreeViewNodeType = 'leaf' | 'sub-tree'
    # type TreeViewCheckedValue = 'true' | 'false' | 'mixed'
    #
    # type TreeViewNodeInfo = {
    #   node: Element
    #   type: TreeViewNodeType
    #   path: string[]
    #   checkedValue: TreeViewCheckedValue
    #   previousCheckedValue: TreeViewCheckedValue
    # }
    # ```
    #
    # |Name                         |Type                                       |Bubbles |Cancelable |
    # |:----------------------------|:------------------------------------------|:-------|:----------|
    # |`treeViewNodeActivated`      |`CustomEvent<TreeViewNodeInfo>`            |Yes     |No         |
    # |`treeViewBeforeNodeActivated`|`CustomEvent<TreeViewNodeInfo>`            |Yes     |Yes        |
    # |`treeViewNodeExpanded`       |`CustomEvent<TreeViewNodeInfo>>`           |Yes     |No         |
    # |`treeViewNodeCollapsed`      |`CustomEvent<TreeViewNodeInfo>>`           |Yes     |No         |
    # |`treeViewNodeChecked`        |`CustomEvent<TreeViewNodeInfo[]>`          |Yes     |Yes        |
    # |`treeViewBeforeNodeChecked`  |`CustomEvent<TreeViewNodeInfo[]>`          |Yes     |No         |
    #
    # _Item activation_
    #
    # The `<tree-view>` element fires an `treeViewNodeActivated` event whenever a node is activated (eg. clicked)
    # via the mouse or keyboard.
    #
    # The `treeViewBeforeNodeActivated` event fires before a node is activated. Canceling this event will prevent the
    # node from being activated.
    #
    # ```typescript
    # document.querySelector("select-panel").addEventListener(
    #   "treeViewBeforeNodeActivated",
    #   (event: CustomEvent<TreeViewNodeInfo>) => {
    #     event.preventDefault() // Cancel the event to prevent activation (eg. expanding/collapsing)
    #   }
    # )
    # ```
    #
    # _Item checking/unchecking_
    #
    # The `tree-view` element fires a `treeViewNodeChecked` event whenever a node is checked or unchecked.
    #
    # The `treeViewBeforeNodeChecked` event fires before a node is checked or unchecked. Canceling this event will
    # prevent the check/uncheck operation.
    #
    # ```typescript
    # document.querySelector("select-panel").addEventListener(
    #   "treeViewBeforeNodeChecked",
    #   (event: CustomEvent<TreeViewNodeInfo[]>) => {
    #     event.preventDefault() // Cancel the event to prevent activation (eg. expanding/collapsing)
    #   }
    # )
    # ```
    #
    # Because checking or unchecking a sub-tree results in the checking or unchecking of all its children recursively,
    # both the `treeViewNodeChecked` and `treeViewBeforeNodeChecked` events provide an array of `TreeViewNodeInfo`
    # objects, which contain entries for every modified node in the tree.
    class TreeView < Primer::Component
      # @!parse
      #   # Adds an leaf node to the tree. Leaf nodes are nodes that do not have children.
      #   #
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::OpenProject::TreeView::LeafNode) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::OpenProject::TreeView::LeafNode) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_leaf(**system_arguments, &block)
      #   end

      # @!parse
      #   # Adds a sub-tree node to the tree. Sub-trees are nodes that have children, which can be both leaf nodes and other sub-trees.
      #   #
      #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::OpenProject::TreeView::SubTreeNode) %>
      #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::OpenProject::TreeView::SubTreeNode) %>, or whatever class is passed as the `component_klass` argument.
      #   def with_sub_tree(**system_arguments, &block)
      #   end

      renders_many :nodes, types: {
        leaf: {
          renders: lambda { |component_klass: LeafNode, label:, **system_arguments|
            component_klass.new(
              **system_arguments,
              path: [label],
              label: label
            )
          },

          as: :leaf
        },

        sub_tree: {
          renders: lambda { |component_klass: SubTreeNode, label:, **system_arguments|
            component_klass.new(
              **system_arguments,
              path: [label],
              label: label
            )
          },

          as: :sub_tree
        }
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>.
      def initialize(**system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:tag] = :ul
        @system_arguments[:role] = :tree
        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "TreeViewRootUlStyles"
        )
      end

      private

      def before_render
        if (first_node = nodes.first)
          first_node.merge_system_arguments!(tabindex: 0)
        end
      end
    end
  end
end
