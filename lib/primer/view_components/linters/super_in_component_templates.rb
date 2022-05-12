# frozen_string_literal: true

require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Replaces calls to `super` with calls to `render_parent`.
    class SuperInComponentTemplates < Linter
      include ERBLint::LinterRegistry
      include Helpers::RubocopHelpers

      def run(processed_source)
        processed_source.ast.descendants(:erb).each do |erb_node|
          indicator_node, _, code_node = *erb_node
          code = code_node.children.first
          ast = erb_ast(code)
          next unless ast

          super_call_nodes = find_super_call_nodes(ast)
          next if super_call_nodes.empty?

          indicator, = *indicator_node
          indicator ||= ""

          # +2 to account for the leading "<%" characters
          code_start_pos = erb_node.location.begin_pos + indicator.size + 2

          super_call_nodes.each do |super_call_node|
            orig_loc = code_node.location
            super_call_loc = super_call_node.location.expression

            new_loc = orig_loc.with(
              begin_pos: super_call_loc.begin_pos + code_start_pos,
              end_pos: super_call_loc.end_pos + code_start_pos
            )

            add_offense(
              new_loc,
              "Avoid calling `super` in component templates. Call `render_parent` instead",
              "render_parent"
            )
          end
        end
      end

      def autocorrect(_, offense)
        return unless offense.context

        lambda do |corrector|
          corrector.replace(offense.source_range, offense.context)
        end
      end

      private

      def find_super_call_nodes(ast)
        return [ast] if ast.type == :zsuper

        ast.each_child_node.flat_map do |child_ast|
          find_super_call_nodes(child_ast)
        end
      end
    end
  end
end
