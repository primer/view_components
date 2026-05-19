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
          system_arguments[:select_variant] ||= :multiple

          unless FilterableTreeView::SUPPORTED_SELECT_VARIANTS.include?(system_arguments[:select_variant])
            raise ArgumentError, "FilterableTreeView only supports #{SUPPORTED_SELECT_VARIANTS.map(&:inspect).to_sentence} as select_variant"
          end

          super(
            sub_tree_component_klass: self.class,
            **system_arguments,
            select_strategy: :self,
            &block
          )
        end

        def with_leaf(**system_arguments, &block)
          system_arguments[:select_variant] ||= :multiple

          unless FilterableTreeView::SUPPORTED_SELECT_VARIANTS.include?(system_arguments[:select_variant])
            raise ArgumentError, "FilterableTreeView only supports #{SUPPORTED_SELECT_VARIANTS.map(&:inspect).to_sentence} as select_variant"
          end

          super(
            **system_arguments,
            &block
          )
        end

        def with_loading_spinner(**system_arguments)
          raise ArgumentError, "FilterableTreeView does not support select variants for sub-trees loaded asynchronously. Please make the whole component load asynchronously."
        end

        def with_loading_skeleton(**system_arguments)
          raise ArgumentError, "FilterableTreeView does not support select variants for sub-trees loaded asynchronously. Please make the whole component load asynchronously."
        end
      end
    end
  end
end
