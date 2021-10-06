# frozen_string_literal: true

require_relative "ast_traverser"

# :nodoc:
class AstProcessor
  class << self
    def increment(stats, component, arg_name, value)
      stats[component][arg_name][value] = 0 unless stats[component][arg_name][value]
      stats[component][arg_name][value] += 1
    end

    def process_ast(ast, stats)
      traverser = AstTraverser.new
      traverser.walk(ast)

      return if traverser.stats.empty?

      traverser.stats.each do |component, component_args|
        stats[component] ||= {}

        component_args.each do |arg, value|
          arg_name = arg.to_s
          stats[component][arg_name] ||= {}

          # we want to count each class separately
          if arg_name == "classes"
            value.split.each do |val|
              increment(stats, component, arg_name, val)
            end
          else
            increment(stats, component, arg_name, value)
          end
        end
      end
    end
  end
end
