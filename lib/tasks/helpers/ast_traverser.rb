# frozen_string_literal: true

require "primer/view_components/statuses"
require_relative "../../../app/lib/primer/view_helper"

# :nodoc:
class AstTraverser
  include RuboCop::AST::Traversal

  attr_reader :stats

  def initialize
    @stats = {}
  end

  def on_send(node)
    return super(node) unless component_node?(node)

    name = component_name(node)
    args = extract_arguments(node, name)

    @stats[name] = args unless args.empty?

    super(node) # recursively iterate over children
  end

  def view_helpers
    @view_helpers ||= ::Primer::ViewHelper::HELPERS.keys.map { |key| "primer_#{key}".to_sym }
  end

  def component_node?(node)
    view_helpers.include?(node.method_name) || (node.method_name == :new && !node.receiver.nil? && ::Primer::ViewComponents::STATUSES.key?(node.receiver.const_name))
  end

  def component_name(node)
    return node.receiver.const_name if node.method_name == :new

    helper_key = node.method_name.to_s.gsub("primer_", "").to_sym
    Primer::ViewHelper::HELPERS[helper_key]
  end

  def extract_arguments(node, name)
    args = node.arguments
    res = {}

    return res if args.empty?

    kwargs = args.last
    if kwargs.respond_to?(:pairs)
      res = kwargs.pairs.each_with_object({}) do |pair, h|
        h[pair.key.value] = pair.value.source
      end
    end

    # Octicon is the only component that accepts positional arguments.
    res[:icon] = args.first.source if name == "Primer::OcticonComponent" && args.size > 1

    res
  end
end
