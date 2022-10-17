# frozen_string_literal: true

require_relative "helpers/rubocop_helpers"

module ERBLint
  module Linters
    # Migrates deprecated arguments in Primer::Beta::Flash components to their equivalents.
    class MigrateDeprecatedFlashArguments < Linter
      # Taken from https://github.com/rails/rails/blob/main/actionview/lib/action_view/template/handlers/erb/erubi.rb#L45
      BLOCK_EXPR = /\s*((\s+|\))do|\{)(\s*\|[^|]*\|)?\s*\Z/.freeze

      include ERBLint::LinterRegistry
      include Helpers::RubocopHelpers

      def run(processed_source)
        processed_source.ast.descendants(:erb).each do |erb_node|
          indicator_node, _, code_node = *erb_node
          code = code_node.children.first
          ast = erb_ast(maybe_close_block(code))
          next unless ast

          constructor_arg_hashes = find_new_flash_instances(ast)
          next if constructor_arg_hashes.empty?

          indicator, = *indicator_node
          indicator ||= ""

          # +2 to account for the leading "<%" characters
          code_start_pos = erb_node.location.begin_pos + indicator.size + 2

          constructor_arg_hashes.each do |constructor_arg_hash|
            spacious_arg = constructor_arg_hash.include?(:spacious)
            next unless spacious_arg

            orig_loc = code_node.location
            key_node, value_node = constructor_arg_hash[:spacious]

            new_loc = orig_loc.with(
              begin_pos: key_node.location.expression.begin_pos + code_start_pos,
              end_pos: value_node.location.expression.end_pos + code_start_pos
            )

            if value_node.source == "true"
              add_offense(
                new_loc,
                "The :spacious argument is deprecated. Use `mb: 4` instead.",
                "mb: 4"
              )
            else
              new_loc = adjust_to_preceding_comma(new_loc)

              add_offense(
                new_loc,
                "The :spacious argument is deprecated; `spacious: false` can be removed.",
                ""
              )
            end
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

      def adjust_to_preceding_comma(loc)
        comma_pos = loc.source_buffer.source.rindex(/\s*,/, loc.begin_pos)
        return loc unless comma_pos

        loc.with(begin_pos: comma_pos)
      end

      def find_new_flash_instances(ast)
        if (instance = find_new_flash_instance(ast))
          return [instance]
        end

        ast.each_child_node.flat_map do |child_ast|
          find_new_flash_instances(child_ast)
        end
      end

      def find_new_flash_instance(ast)
        render_body = unwrap_render(ast)
        return nil unless render_body

        constructor_args = unwrap_constructor(render_body)
        return nil unless constructor_args

        arg1, = *render_body
        return nil unless arg1.type == :const
        return nil unless arg1.source == "Primer::Beta::Flash"

        parse_args(constructor_args)
      end

      def parse_args(arg_node)
        arg_node.children.each_with_object({}) do |child, memo|
          key_node, value_node = *child.children
          memo[key_node.source.to_sym] = [key_node, value_node]
        end
      end

      def unwrap_render(ast)
        unwrap_method_call(ast, :render)
      end

      def unwrap_constructor(ast)
        unwrap_method_call(ast, :new)
      end

      def unwrap_method_call(ast, method_name)
        return nil unless ast
        return nil unless ast.type == :send

        _, name, body = *ast
        return nil if name != method_name

        body
      end

      def maybe_close_block(code)
        match = code.match(BLOCK_EXPR)
        return code unless match

        if match.captures[0].strip == "do"
          "#{code}; end"
        else
          "#{code} }"
        end
      end
    end
  end
end
