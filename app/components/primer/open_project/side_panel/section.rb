# frozen_string_literal: true

module Primer
  module OpenProject
    class SidePanel
      # SidePanel::Section is an internal component that deals with individual sections of a sidepanel.
      class Section < Primer::Component
        status :open_project

        TITLE_TAG_FALLBACK = :h4
        TITLE_TAG_OPTIONS = [:h1, :h2, :h3, TITLE_TAG_FALLBACK, :h5, :h6].freeze

        renders_one :title, lambda { |tag: TITLE_TAG_FALLBACK, **system_arguments, &block|
          system_arguments[:tag] = fetch_or_fallback(TITLE_TAG_OPTIONS, tag, TITLE_TAG_FALLBACK)
          Primer::BaseComponent.new(**system_arguments, &block)
        }

        renders_one :counter, Primer::Beta::Counter

        renders_one :action, types: {
          icon: lambda { |**system_arguments, &block|
            system_arguments[:scheme] ||= :invisible
            Primer::Beta::IconButton.new(**system_arguments, &block)
          }
        }

        renders_one :description, lambda { |**system_arguments, &block|
          system_arguments[:color] = :subtle
          Primer::Beta::Text.new(**system_arguments, &block)
        }

        renders_one :footer, types: {
          button: lambda { |**system_arguments, &block|
            defaults = {
              scheme: :link,
              color: :default,
              font_weight: :bold,
              underline: false
            }
            system_arguments.reverse_merge!(defaults)

            system_arguments[:classes] = class_names(
              "SidePanel-sectionFooter",
              system_arguments[:classes]
            )

            Primer::Beta::Button.new(**system_arguments, &block)
          }
        }

        DEFAULT_TAG = :section
        TAG_OPTIONS = [DEFAULT_TAG, :div, :span].freeze

        def initialize(tag: DEFAULT_TAG, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
        end

        def render?
          title? && content?
        end
      end
    end
  end
end
