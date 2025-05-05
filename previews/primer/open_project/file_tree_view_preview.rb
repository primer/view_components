# frozen_string_literal: true

module Primer
  module OpenProject
    # @label FileTreeView
    class FileTreeViewPreview < ViewComponent::Preview
      # @label Default
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, none]
      def default(expanded: false, select_variant: :none)
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          select_variant: select_variant.to_sym
        })
      end

      # @label Playground
      #
      # @param expanded [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, none]
      def playground(expanded: false, select_variant: :none)
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          select_variant: select_variant.to_sym,
          populate: -> (*args) { populate(*args) }
        })
      end

      private

      def coerce_bool(value)
        case value
        when true, false
          value
        when "true"
          true
        when "false"
          false
        else
          false
        end
      end

      def populate(node, data, node_arguments)
        return unless data

        entries = (
          data.fetch("children", {}).keys.map { |label, idx| [label, :directory] } +
          data.fetch("files", []).map { |label| [label, :file] }
        )

        entries.sort_by!(&:first)

        entries.each do |label, kind, idx|
          case kind
          when :directory
            node.with_directory(label: label, **node_arguments) do |sub_tree|
              populate(sub_tree, data["children"][label], node_arguments)
            end
          when :file
            node.with_file(label: label, **node_arguments)
          end
        end
      end
    end
  end
end
