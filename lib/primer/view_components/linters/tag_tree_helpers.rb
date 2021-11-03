# frozen_string_literal: true

module ERBLint
  module Linters
    # Helpers used by linters to organize HTML tags into abstract syntax trees.
    module TagTreeHelpers
      # from https://github.com/Shopify/erb-lint/blob/6179ee2d9d681a6ec4dd02351a1e30eefa748d3d/lib/erb_lint/linters/self_closing_tag.rb
      SELF_CLOSING_TAGS = %w[
        area base br col command embed hr input keygen
        link menuitem meta param source track wbr img
      ].freeze

      # This assumes that the AST provided represents valid HTML, where each tag has a corresponding closing tag.
      # From the tags, we build a structured tree which represents the tag hierarchy.
      # With this, we are able to know where the tags start and end.
      def build_tag_tree(processed_source)
        nodes = processed_source.ast.children
        tag_tree = {}
        tags = []
        current_opened_tag = nil

        nodes.each do |node|
          if node.type == :tag
            # get the tag from previously calculated list so the references are the same
            tag = BetterHtml::Tree::Tag.from_node(node)
            tags << tag

            if tag.closing?
              if current_opened_tag && tag.name == current_opened_tag.name
                tag_tree[current_opened_tag][:closing] = tag
                current_opened_tag = tag_tree[current_opened_tag][:parent]
              end

              next
            end

            self_closing = self_closing?(tag)

            tag_tree[tag] = {
              tag: tag,
              closing: self_closing ? tag : nil,
              parent: current_opened_tag,
              children: []
            }

            tag_tree[current_opened_tag][:children] << tag_tree[tag] if current_opened_tag
            current_opened_tag = tag unless self_closing
          elsif current_opened_tag
            tag_tree[current_opened_tag][:children] << node
          end
        end

        [tags, tag_tree]
      end

      def self_closing?(tag)
        tag.self_closing? || SELF_CLOSING_TAGS.include?(tag.name)
      end
    end
  end
end
