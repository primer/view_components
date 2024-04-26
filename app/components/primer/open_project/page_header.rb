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
      MOBILE_ACTIONS_DISPLAY = [:flex, :none].freeze

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
        icon_button: lambda { |icon:, mobile_icon:, label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments, &block|
          deny_tag_argument(**system_arguments)

          system_arguments[:icon] = icon
          system_arguments[:"aria-label"] ||= label
          system_arguments = set_action_arguments(system_arguments, scheme: scheme)

          component = Primer::Beta::IconButton
          create_mobile_alternatives(component, mobile_icon, label, scheme, **system_arguments, &block)

          component.new(**system_arguments)
        },
        button: lambda { |mobile_icon:, mobile_label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments, &block|
          deny_tag_argument(**system_arguments)

          system_arguments = set_action_arguments(system_arguments, scheme: scheme)

          component = Primer::Beta::Button
          create_mobile_alternatives(component, mobile_icon, mobile_label, scheme, **system_arguments, &block)

          component.new(**system_arguments)
        },
        zen_mode_button: lambda { |mobile_icon: Primer::OpenProject::ZenModeButton::ZEN_MODE_BUTTON_ICON, mobile_label: Primer::OpenProject::ZenModeButton::ZEN_MODE_BUTTON_LABEL, **system_arguments, &block|
          deny_tag_argument(**system_arguments)

          system_arguments = set_action_arguments(system_arguments, scheme: DEFAULT_ACTION_SCHEME)

          component = Primer::OpenProject::ZenModeButton
          create_mobile_alternatives(component, mobile_icon, mobile_label, DEFAULT_ACTION_SCHEME, **system_arguments, &block)

          component.new(**system_arguments)
        },

        link: lambda { |mobile_icon:, mobile_label:, scheme: DEFAULT_ACTION_SCHEME, **system_arguments|
          deny_tag_argument(**system_arguments)

          system_arguments[:target] ||= "_top"
          system_arguments = set_action_arguments(system_arguments, scheme: scheme)

          add_option_to_mobile_menu(system_arguments, mobile_icon, mobile_label, scheme)

          Primer::Beta::Link.new(**system_arguments)
        },
        # Should only be used rarely on a per-need basis
        text: lambda { |**system_arguments|
          system_arguments = set_action_arguments(system_arguments)
          system_arguments[:color] ||= :muted
          # Enforce that texts are hidden on mobile
          system_arguments[:display] = [:none, :flex]

          Primer::Beta::Text.new(**system_arguments)
        },
        menu: {
          renders: lambda { |**system_arguments, &block|
            deny_tag_argument(**system_arguments)

            system_arguments[:button_arguments] ||= {}
            system_arguments[:button_arguments] = set_action_arguments(system_arguments[:button_arguments])

            # Add the options individually to the mobile menu in the template
            @desktop_menu_block = block

            component = Primer::OpenProject::PageHeader::Menu
            create_mobile_single_action(component, **system_arguments, &block)

            component.new(**system_arguments)
          },
        },
        dialog: {
          renders: lambda { |mobile_icon:, mobile_label:, **system_arguments, &block|
            deny_tag_argument(**system_arguments)

            # The id will be automatically calculated for the trigger button, so we have to behave the same, for the mobile click to work
            system_arguments[:button_arguments] ||= {}
            system_arguments[:button_arguments][:id] = "dialog-show-#{system_arguments[:dialog_arguments][:id]}"
            system_arguments[:button_arguments] = set_action_arguments(system_arguments[:button_arguments])

            component = Primer::OpenProject::PageHeader::Dialog
            create_mobile_alternatives(component, mobile_icon, mobile_label, :default, **system_arguments, &block)

            component.new(**system_arguments)
          },
        },
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

      # Optional breadcrumbs above the title row
      # By default shown on wider screens. Can be overridden with system_argument: display
      #
      # @param items [Array<String, Hash>] Items is an array of strings, hash {href, text} or an anchor tag string
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :breadcrumbs, lambda { |items, selected_item_font_weight: :bold, **system_arguments|
        system_arguments[:classes] = class_names(system_arguments[:classes], "PageHeader-breadcrumbs")
        system_arguments[:display] ||= DEFAULT_BREADCRUMBS_DISPLAY

        # show parent link if there is a parent for current page
        if items.length > 1
          link_arguments = {}
          parent_item = items[items.length - 2]
          parsed_parent_item = anchor_tag_string?(parent_item) ? anchor_string_to_object(parent_item) : parent_item

          link_arguments[:icon] = fetch_or_fallback(BACK_BUTTON_ICON_OPTIONS, DEFAULT_BACK_BUTTON_ICON)
          link_arguments[:href] = parsed_parent_item[:href]
          link_arguments[:target] = "_top"

          link_arguments[:classes] = class_names(link_arguments[:classes], "PageHeader-parentLink")
          link_arguments[:display] ||= DEFAULT_PARENT_LINK_DISPLAY

          @parent_link = render(Primer::Beta::Link.new(scheme: :primary, muted: true, **link_arguments)) do
            render(Primer::Beta::Octicon.new(icon: "arrow-left",
                                             "aria-label": I18n.t("button_back"),
                                             mr: 2)
            ) + content_tag(:span, parsed_parent_item[:text])
          end
        end

        render(Primer::Beta::Breadcrumbs.new(**system_arguments)) do |breadcrumbs|
          items.each do |item|
            item = anchor_string_to_object(item) if anchor_tag_string?(item)

            if item.is_a?(String)
              breadcrumbs.with_item(href: "#", font_weight: selected_item_font_weight) { item }
            else
              breadcrumbs.with_item(href: item[:href], target: "_top") { item[:text] }
            end
          end
        end
      }

      # @param mobile_menu_label [String] The tooltip label of the mobile menu
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(mobile_menu_label: I18n.t("label_more"), **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @mobile_menu_label = mobile_menu_label

        @system_arguments[:tag] = :"page-header"
        @system_arguments[:classes] =
          class_names(
            @system_arguments[:classes],
            "PageHeader"
          )

        @mobile_action_menu = Primer::Alpha::ActionMenu.new(
          display: MOBILE_ACTIONS_DISPLAY,
          anchor_align: :end
        )
      end

      def render?
        raise ArgumentError, "PageHeader needs a title and a breadcrumb. Please use the `with_title` and `with_breadcrumbs` slot" unless breadcrumbs? || Rails.env.production?
        raise ArgumentError, "PageHeader allows only a maximum of 5 actions" if actions.count > 5

        title? && breadcrumbs?
      end

      def render_mobile_menu?
        actions.count > 1
      end

      private

      def set_action_arguments(system_arguments, scheme: nil, button_action: false)
        system_arguments[:ml] ||= 2
        system_arguments[:display] = [:none, :flex]
        system_arguments[:size] = :medium
        system_arguments[:scheme] = scheme unless scheme.nil?
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "PageHeader-action",
        )

        system_arguments[:id] ||= self.class.generate_id
        system_arguments
      end

      def create_mobile_alternatives(component, mobile_icon, mobile_label, scheme, **system_arguments, &block)
        # All actions should collapse into a single actionMenu on mobile
        add_option_to_mobile_menu(system_arguments, mobile_icon, mobile_label, scheme)

        # Except for single actions, which remain as they are, just smaller.
        create_mobile_single_action(component, **system_arguments, &block)
      end

      def add_option_to_mobile_menu(system_arguments, mobile_icon, mobile_label, scheme)
        unless mobile_icon.nil? || mobile_label.nil?
          # In action menus, only :default and :danger are allowed
          scheme = DEFAULT_ACTION_SCHEME unless scheme == :danger

          id = system_arguments[:button_arguments].present? ? system_arguments[:button_arguments][:id] : system_arguments[:id]
          with_menu_item(id: id, label: mobile_label, scheme: scheme) do |c|
            c.with_leading_visual_icon(icon: mobile_icon)
          end
        end
      end

      def with_menu_item(id:, **system_arguments, &block)
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

      def create_mobile_single_action(component, **system_arguments, &block)
        # Single actions shall not collapse into an action menu on mobile, but keep their state.
        # However the position and size will change
        unless render_mobile_menu?
          mobile_options = system_arguments[:button_arguments].present? ?
                             { button_arguments: { display: MOBILE_ACTIONS_DISPLAY, size: :small } } :
                             { display: MOBILE_ACTIONS_DISPLAY, size: :small }

          @mobile_action = component.new(**system_arguments.deep_merge(mobile_options))
          @mobile_action_block = block
        end
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
