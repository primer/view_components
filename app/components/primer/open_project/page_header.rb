# frozen_string_literal: true

module Primer
  module OpenProject
    # A ViewComponent PageHeader inspired by the primer react variant
    class PageHeader < Primer::Component
      HEADING_TAG_OPTIONS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze
      HEADING_TAG_FALLBACK = :h1

      DEFAULT_HEADER_VARIANT = :medium
      HEADER_VARIANT_OPTIONS = [
        DEFAULT_HEADER_VARIANT,
        :large
      ].freeze

      DEFAULT_BACK_BUTTON_ICON = "arrow-left"
      BACK_BUTTON_ICON_OPTIONS = [
        DEFAULT_BACK_BUTTON_ICON,
        "chevron-left",
        "triangle-left"
      ].freeze

      DEFAULT_ACTION_SCHEME = :default
      MORE_MENU_DISPLAY = [:flex, :none].freeze

      DEFAULT_LEADING_ACTION_DISPLAY = [:none, :flex].freeze
      DEFAULT_BREADCRUMBS_DISPLAY = [:none, :flex].freeze
      DEFAULT_PARENT_LINK_DISPLAY = [:block, :none].freeze

      status :open_project

      # The title of the page header
      #
      # @param tag [Symbol] <%= one_of(Primer::Beta::Heading::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :title, lambda { |tag: HEADING_TAG_FALLBACK, variant: DEFAULT_HEADER_VARIANT, **system_arguments|
        system_arguments[:tag] = fetch_or_fallback(HEADING_TAG_OPTIONS, tag, HEADING_TAG_FALLBACK)
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "PageHeader-title",
          "PageHeader-title--#{variant}"
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      # Optional description below the title row
      renders_one :description, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(system_arguments[:classes], "PageHeader-description")

        Primer::BaseComponent.new(**system_arguments)
      }

      # Actions
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :actions, types: {
        icon_button: lambda { | icon:, mobile_icon:, label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments|
          deny_tag_argument(**system_arguments)
          system_arguments = generic_action_settings(system_arguments, mobile_icon, label, scheme)

          Primer::Beta::IconButton.new(icon: icon, "aria-label": label, **system_arguments)
        },
        button: lambda { | mobile_icon:, mobile_label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments|
          deny_tag_argument(**system_arguments)
          system_arguments = generic_action_settings(system_arguments, mobile_icon, mobile_label, scheme)

          Primer::Beta::Button.new(**system_arguments)
        },
        link: lambda { | mobile_icon:, mobile_label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments|
          deny_tag_argument(**system_arguments)
          system_arguments = generic_action_settings(system_arguments, mobile_icon, mobile_label, scheme)

          Primer::Beta::Link.new(**system_arguments)
        },
        menu: lambda { | mobile_icon:, mobile_label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments|
        }
      }

      # Optional leading action prepend the title
      # By default shown on wider screens. Can be overridden with system_argument: display
      #
      # @param icon [Symbol] The name of an <%= link_to_octicons %> icon to use.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :leading_action, lambda { |
        icon:,
        **system_arguments
      |
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :a
        system_arguments[:scheme] = :invisible
        system_arguments[:icon] = icon
        system_arguments[:classes] = class_names(system_arguments[:classes], "PageHeader-leadingAction")
        system_arguments[:display] ||= DEFAULT_LEADING_ACTION_DISPLAY

        Primer::Beta::IconButton.new(icon: icon, **system_arguments)
      }

      # Optional parent link in the context area
      # By default shown on narrow screens. Can be overridden with system_argument: display
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :parent_link, lambda { |icon: DEFAULT_BACK_BUTTON_ICON, **system_arguments, &block|
        deny_tag_argument(**system_arguments)
        system_arguments[:icon] = fetch_or_fallback(BACK_BUTTON_ICON_OPTIONS, icon, DEFAULT_BACK_BUTTON_ICON)
        system_arguments[:classes] = class_names(system_arguments[:classes], "PageHeader-parentLink")
        system_arguments[:display] ||= DEFAULT_PARENT_LINK_DISPLAY

        render(Primer::Beta::Link.new(scheme: :primary, muted: true, **system_arguments)) do
          render(Primer::Beta::Octicon.new(icon: "arrow-left", "aria-label": "aria_label", mr: 2)) + content_tag(:span, &block)
        end
      }

      # Optional breadcrumbs above the title row
      # By default shown on wider screens. Can be overridden with system_argument: display
      #
      # @param items [Array<String, Hash>] Items is an array of strings, hash {href, text} or an anchor tag string
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :breadcrumbs, lambda { |items, **system_arguments|
        system_arguments[:classes] = class_names(system_arguments[:classes], "PageHeader-breadcrumbs")
        system_arguments[:display] ||= DEFAULT_BREADCRUMBS_DISPLAY

        render(Primer::Beta::Breadcrumbs.new(**system_arguments)) do |breadcrumbs|
          items.each do |item|
            item = anchor_string_to_object(item) if anchor_tag_string?(item)

            if item.is_a?(String)
              breadcrumbs.with_item(href: "#") { item }
            else
              breadcrumbs.with_item(href: item[:href]) { item[:text] }
            end
          end
        end
      }

      def initialize(show_mobile_menu = true, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @show_mobile_menu = show_mobile_menu

        @system_arguments[:tag] = :'page-header'
        @system_arguments[:classes] =
          class_names(
            @system_arguments[:classes],
            "PageHeader"
          )

        return unless @show_mobile_menu

        @mobile_action_menu = Primer::Alpha::ActionMenu.new(
          display: MORE_MENU_DISPLAY,
          anchor_align: :end
        )
      end

      def render?
        title?
      end

      private

      def generic_action_settings(system_arguments, mobile_icon, mobile_label, scheme)
        system_arguments[:ml] ||= 2
        system_arguments[:display] = @show_mobile_menu ? [:none, :flex] : [:flex]
        system_arguments[:scheme] = scheme

        system_arguments[:id] ||= self.class.generate_id

        unless mobile_icon.nil? || mobile_label.nil?
          with_menu_item(id: system_arguments[:id], label: mobile_label, scheme: scheme) do |c|
            c.with_leading_visual_icon(icon: mobile_icon)
          end
        end

        system_arguments
      end

      def with_menu_item(id:, **system_arguments, &block)
        return unless @show_mobile_menu

        system_arguments = {
          **system_arguments,
          "data-for": id,
          "data-action": "click:page-header#menuItemClick"
        }

        @mobile_action_menu.with_item(
          value: "",
          **system_arguments,
          &block
        )
      end

      # transform anchor tag strings to {href, text} objects
      # e.g "\u003ca href=\"/admin\"\u003eAdministration\u003c/a\u003e"
      def anchor_string_to_object(html_string)
        # Parse the HTML
        doc = Nokogiri::HTML.fragment(html_string)
        # Extract href and text
        anchor = doc.at("a")
        { href: anchor["href"], text: anchor.text }
      end

      # Check if the item is an anchor tag string e.g "\u003ca href=\"/admin\"\u003eAdministration\u003c/a\u003e"
      def anchor_tag_string?(item)
        item.is_a?(String) && item.start_with?("\u003c")
      end
    end
  end
end
