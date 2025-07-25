# frozen_string_literal: true

module Primer
  module Alpha
    class FileTreeView
      class DirectoryNode < TreeView::SubTreeNode
        def initialize(icon_arguments: nil, expanded_icon_arguments: nil, collapsed_icon_arguments: nil, **system_arguments)
          @expanded_icon_arguments = expanded_icon_arguments || icon_arguments || {}
          @collapsed_icon_arguments = collapsed_icon_arguments || icon_arguments || {}

          super(**system_arguments)
        end

        def with_file(**system_arguments, &block)
          with_leaf(**system_arguments, component_klass: FileNode, &block)
        end

        def with_directory(**system_arguments, &block)
          with_sub_tree(**system_arguments, component_klass: DirectoryNode, &block)
        end
      end
    end
  end
end
