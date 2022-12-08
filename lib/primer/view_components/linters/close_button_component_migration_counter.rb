# frozen_string_literal: true

require_relative "base_linter"
require_relative "autocorrectable"
require_relative "argument_mappers/close_button"
require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Counts the number of times a HTML clipboard-copy is used instead of the component.
    class CloseButtonComponentMigrationCounter < BaseLinter
      include Autocorrectable
      include Helpers::RubocopHelpers

      TAGS = %w[button].freeze
      CLASSES = %w[close-button].freeze
      MESSAGE = "We are migrating close-button to use [Primer::Beta::CloseButton](https://primer.style/view-components/components/beta/closebutton), please try to use that instead of raw HTML."
      ARGUMENT_MAPPER = ArgumentMappers::CloseButton
      COMPONENT = "Primer::Beta::CloseButton"

      ALLOWED_OCTICON_ARGS = %w[icon aria-label aria].freeze

      private

      def map_arguments(tag, tag_tree)
        # We can only autocorrect cases where the tag only has an octicon as content.
        return if tag_tree[:children].size != 1

        nodes = tag_tree[:children].first.children
        erb_nodes = nodes.select { |node| node.try(:type) == :erb }

        # Don't correct if there are multiple ERB nodes.
        return if erb_nodes.size != 1

        _, _, code_node = *erb_nodes.first
        code = code_node.children.first.strip
        ast = erb_ast(code)

        # We'll only autocorrect cases where the only content is an octicon.
        if ast.method_name == :primer_octicon || ast.method_name == :octicon
          octicon_kwargs = ast.arguments[1]
          icon = icon(ast.arguments)
        elsif ast.method_name == :render && code.include?("Primer::Beta::Octicon")
          octicon_kwargs = ast.arguments.first.arguments.last
          icon = icon(ast.arguments.first.arguments)
        else
          return
        end

        # Don't autocorrect if using a custom icon
        return unless icon == :x
        # Don't autocorrect if the octicon has custom arguments
        return if custom_attributes?(octicon_kwargs)

        octicon_aria_label = aria_label_from_octicon(octicon_kwargs)
        tag_aria_label = tag.attributes.each.find { |a| a.name == "aria-label" }

        # Can't autocorrect if there is no aria-label.
        return if octicon_aria_label.blank? && tag_aria_label.blank?

        args = ARGUMENT_MAPPER.new(tag).to_s

        # Argument mapper will add the `aria-label` if the tag has it.
        return args if tag_aria_label.present?

        aria_label_arg = "\"aria-label\": #{octicon_aria_label}"

        return aria_label_arg if args.blank?

        "#{args}, #{aria_label_arg}"
      rescue ArgumentMappers::ConversionError
        nil
      end

      # Overriding the basic correction since this component does not uses content blocks.
      def correction(args)
        return if args.nil?

        correction = "<%= render #{self.class::COMPONENT}.new"
        correction += "(#{args})" if args.present?
        "#{correction} %>"
      end

      # Overriding the basic correction since this component will rewrite the whole tag block.
      def add_correction(tag, tag_tree)
        offense_loc = tag.loc.with(end_pos: tag_tree[:closing].loc.to_range.last)
        add_offense(offense_loc, tag_tree[:message], tag_tree[:correction])
      end

      # Extracts the aria-label value from the octicon kwargs.
      # It can either be in `"aria-label": "value"`` or `aria: { label: "value" } }`.
      def aria_label_from_octicon(kwargs)
        return if kwargs.blank? || kwargs.type != :hash || kwargs.pairs.blank?

        aria_label = kwargs.pairs.find { |x| x.key.value == :"aria-label" }

        return aria_label.value.source if aria_label

        aria_hash = kwargs.pairs.find { |x| x.key.value == :aria }

        return if aria_hash.blank?

        aria_label = aria_hash.value.pairs.find { |x| x.key.value == :label }

        aria_label&.value&.source
      end

      def custom_attributes?(kwargs)
        return false if kwargs.blank? || kwargs.type != :hash || kwargs.pairs.blank?

        (kwargs.keys.map { |key| key.value.to_s } - ALLOWED_OCTICON_ARGS).present?
      end

      def icon(args)
        return args.first.value.to_sym if args.first.type == :sym || args.first.type == :str

        args.last.pairs.find { |x| x.key.value == :icon }.value.value.to_sym
      end
    end
  end
end
