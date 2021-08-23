# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/close_button"

module ERBLint
  module Linters
    # Counts the number of times a HTML clipboard-copy is used instead of the component.
    class CloseButtonComponentMigrationCounter < BaseLinter
      include Autocorrectable

      TAGS = %w[button].freeze
      CLASSES = %w[close-button].freeze
      MESSAGE = "We are migrating close-button to use [Primer::CloseButton](https://primer.style/view-components/components/closebutton), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::CloseButton
      COMPONENT = "Primer::CloseButton"

      def map_arguments(tag, tag_tree)
        # We can only autocorrect cases where the tag only has an octicon as content.
        return nil if tag_tree[:children].size != 1

        nodes = tag_tree[:children].first.children
        erb_nodes = nodes.select { |node| node.try(:type) == :erb }

        # Don't correct if there are multiple ERB nodes.
        return nil if erb_nodes.size != 1

        _, _, code_node = *erb_nodes.first
        code = code_node.children.first.strip
        ast = erb_ast(code)

        return unless ast.method_name == :primer_octicon || ast.method_name == :octicon

        octicon_kwargs = ast.arguments.second
        aria_label = octicon_kwargs&.pairs&.find { |x| x.key.value == :"aria-label" }

        args = ARGUMENT_MAPPER.new(tag).to_s

        return args if aria_label.blank?

        aria_label_arg = "\"aria-label\": #{aria_label.value.source}"

        return aria_label_arg if args.blank?

        "#{args}, #{aria_label_arg}"
      rescue ArgumentMappers::ConversionError
        nil
      end

      private

      def erb_ast(code)
        RuboCop::AST::ProcessedSource.new(code, RUBY_VERSION.to_f).ast
      end
    end
  end
end
