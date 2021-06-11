# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module Primer
      # This cop ensures that tags are not set with ||=
      #
      # bad
      # @system_arguments[:tag] ||= :h1
      #
      # good
      # @system_arguments = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      #
      # good
      # @system_arguments = :h2
      class NoTagMemoize < RuboCop::Cop::Cop
        INVALID_MESSAGE = "It looks like you're being pretty loosey goosey with tags."

        def_node_search :tag_memoized?, <<~PATTERN
          (or-asgn
            (send
              _
              _
              (sym :tag)
            )
            _
          )
        PATTERN

        def on_block(node)
          memoized_node = tag_memoized?(node)
          return if memoized_node.nil?

          add_offense(node, message: INVALID_MESSAGE)
        end

        def on_def(node)
          memoized_node = tag_memoized?(node)
          return if memoized_node.nil?

          add_offense(node, message: INVALID_MESSAGE)
        end
      end
    end
  end
end
