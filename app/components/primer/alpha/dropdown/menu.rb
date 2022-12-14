# frozen_string_literal: true

module Primer
  module Alpha
    class Dropdown
      # This component is part of `Dropdown` and should not be
      # used as a standalone component.
      class Menu < Primer::Component
        warn_on_deprecated_slot_setter
        status :alpha

        AS_DEFAULT = :default
        AS_OPTIONS = [AS_DEFAULT, :list].freeze

        SCHEME_DEFAULT = :default
        SCHEME_MAPPINGS = {
          SCHEME_DEFAULT => "",
          :dark => "dropdown-menu-dark"
        }.freeze

        DIRECTION_DEFAULT = :se
        DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :sw, :w, :e, :ne, :s].freeze

        # @param tag [Symbol] <%= one_of(Primer::Alpha::Dropdown::Menu::Item::TAG_OPTIONS) %>.
        # @param divider [Boolean] Whether the item is a divider without any function.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        renders_many :items, lambda { |divider: false, **system_arguments|
          Primer::Alpha::Dropdown::Menu::Item.new(as: @as, divider: divider, **system_arguments)
        }

        # @param as [Symbol] When `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item.
        # @param direction [Symbol] <%= one_of(Primer::Alpha::Dropdown::Menu::DIRECTION_OPTIONS) %>.
        # @param header [String] Header to be displayed above the menu.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(as: AS_DEFAULT, direction: DIRECTION_DEFAULT, scheme: SCHEME_DEFAULT, header: nil, **system_arguments)
          @header = header
          @direction = direction
          @as = fetch_or_fallback(AS_OPTIONS, as, AS_DEFAULT)

          @system_arguments = deny_tag_argument(**system_arguments)
          @system_arguments[:tag] = "details-menu"
          @system_arguments[:role] = "menu"

          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "dropdown-menu",
            "dropdown-menu-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}",
            SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, SCHEME_DEFAULT)]
          )
        end

        private

        def list?
          @as == :list
        end

        # Items to be rendered in the `Dropdown` menu.
        class Item < Primer::Component
          status :alpha

          TAG_DEFAULT = :a
          BUTTON_TAGS = [:button, :summary].freeze
          TAG_OPTIONS = [TAG_DEFAULT, *BUTTON_TAGS].freeze

          def initialize(as:, tag: TAG_DEFAULT, divider: false, **system_arguments)
            @divider = divider
            @as = as

            @system_arguments = system_arguments
            @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
            @system_arguments[:tag] = :li if list? && divider?
            @system_arguments[:role] ||= :menuitem
            @system_arguments[:role] = :separator if divider
            @system_arguments[:classes] = class_names(
              @system_arguments[:classes],
              "dropdown-item" => !divider,
              "dropdown-divider" => divider
            )
          end

          def call
            component = if BUTTON_TAGS.include?(@system_arguments[:tag])
                          # rubocop:disable Primer/ComponentNameMigration
                          Primer::ButtonComponent.new(scheme: :link, **@system_arguments)
                          # rubocop:enable Primer/ComponentNameMigration
                        else
                          Primer::BaseComponent.new(**@system_arguments)
                        end

            # divider has no content
            render(component) if divider?

            render(component) { content }
          end

          def divider?
            @divider
          end

          def list?
            @as == :list
          end
        end
      end
    end
  end
end
