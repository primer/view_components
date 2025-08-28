# frozen_string_literal: true

module Primer
  module OpenProject
    class FilterableTreeView
      # A `FilterableTreeView` sub-tree node.
      #
      # This component is part of the <%= link_to_component(Primer::OpenProject::FilterableTreeView) %> component and
      # should not be used directly.
      class SubTree < Primer::Alpha::TreeView::SubTree
        def with_sub_tree(**system_arguments, &block)
          super(
            sub_tree_component_klass: self.class,
            **system_arguments,
            select_variant: :multiple,
            select_strategy: :self,
            &block
          )
        end

        def with_leaf(**system_arguments, &block)
          super(
            **system_arguments,
            select_variant: :multiple,
            &block
          )
        end

        def with_loading_spinner(**system_arguments)
          raise ArgumentError, "FilteredTreeView does not support asynchronous loading"
        end

        def with_loading_skeleton(**system_arguments)
          raise ArgumentError, "FilteredTreeView does not support asynchronous loading"
        end
      end
    end
  end
end
