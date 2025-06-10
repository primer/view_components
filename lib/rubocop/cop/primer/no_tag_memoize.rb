# frozen_string_literal: true

require "rubocop"

# :nocov:
module RuboCop
  module Cop
    module Primer
      # This cop ensures that tags are not set with ||=
      #
      # bad
      # @system_arguments[:tag] ||= :h1
      #
      # good
      # @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
      #
      # good
      # @system_arguments[:tag] = :h2
      class NoTagMemoize < RuboCop::Cop::Base
        INVALID_MESSAGE = <<~STR
          Avoid `[:tag] ||=`. Instead, try one of the following:
            - Don't allow consumers to update the tag by having a fixed tag (e.g. `system_arguments[:tag] = :div`)
            - Use the `fetch_or_fallback` helper to only allow a tag from a restricted list.
        STR

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

        def on_or_asgn(node)
          add_offense(node, message: INVALID_MESSAGE) if tag_memoized?(node)
        end
      end
    end
  end
end
