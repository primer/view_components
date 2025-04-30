# frozen_string_literal: true

module Primer
  module OpenProject
    class FileTreeView < TreeView
      def with_file(**system_arguments, &block)
        with_leaf(**system_arguments, component_klass: FileNode, &block)
      end

      def with_directory(**system_arguments, &block)
        with_sub_tree(**system_arguments, component_klass: DirectoryNode, &block)
      end
    end
  end
end
