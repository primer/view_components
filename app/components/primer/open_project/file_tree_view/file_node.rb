# frozen_string_literal: true

module Primer
  module OpenProject
    class FileTreeView
      class FileNode < TreeView::LeafNode
        def initialize(icon_arguments: {}, **system_arguments)
          @icon_arguments = icon_arguments
          super(**system_arguments)
        end
      end
    end
  end
end
