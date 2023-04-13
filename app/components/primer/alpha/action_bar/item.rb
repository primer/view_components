# frozen_string_literal: true

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class Item < Primer::Component
        DEFAULT_TAG = :div
        TAG_OPTIONS = [DEFAULT_TAG, :hr].freeze

        def initialize(**system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, system_arguments[:tag], DEFAULT_TAG)
          @system_arguments[:data] = { targets: "action-bar.items" }
          @system_arguments[:classes] = class_names(
            @system_arguments.delete(:classes),
            "ActionBar-item"
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
