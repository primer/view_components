# frozen_string_literal: true

module ERBLint
  module Linters
    module Helpers
      # Helpers for writing rules
      module RuleHelpers
        def tags(processed_source)
          processed_source.parser.nodes_with_type(:tag).map { |tag_node| BetterHtml::Tree::Tag.from_node(tag_node) }
        end

        def generate_offense(klass, processed_source, tag, message = nil, replacement = nil)
          message ||= klass::MESSAGE
          klass_name = klass.name.demodulize
          offense = ["#{klass_name}:#{message}", tag.node.loc.source].join("\n")
          add_offense(processed_source.to_source_range(tag.loc), offense, replacement)
        end

        # Generate offense for ERB node tag
        def generate_node_offense(klass, processed_source, node, message = nil)
          message ||= klass::MESSAGE
          offense = ["#{klass.name}:#{message}", node.loc.source].join("\n")
          add_offense(processed_source.to_source_range(node.loc), offense)
        end

        def erb_nodes(processed_source)
          processed_source.parser.ast.descendants(:erb)
        end

        def extract_ruby_from_erb_node(erb_node)
          return unless erb_node.type == :erb

          _, _, code_node = *erb_node
          code_node.loc.source.strip
        end
      end
    end
  end
end
