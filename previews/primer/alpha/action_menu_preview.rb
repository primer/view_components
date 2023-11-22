# frozen_string_literal: true

module Primer
  module Alpha
    # @label ActionMenu
    class ActionMenuPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param select_variant [Symbol] select [single, multiple, none]
      # @param anchor_align [Symbol] select [start, center, end]
      # @param anchor_side [Symbol] select [outside_bottom, outside_top, outside_left, outside_right]
      # @param size [Symbol] select [auto, small, medium, large, xlarge]
      def playground(
        select_variant: Primer::Alpha::ActionMenu::DEFAULT_SELECT_VARIANT, anchor_align: Primer::Alpha::Overlay::DEFAULT_ANCHOR_ALIGN, anchor_side: Primer::Alpha::Overlay::DEFAULT_ANCHOR_SIDE,
        size: Primer::Alpha::Overlay::DEFAULT_SIZE
      )
        render(Primer::Alpha::ActionMenu.new(select_variant: select_variant, anchor_align: anchor_align, anchor_side: anchor_side, size: size)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link")
          menu.with_item(label: "Quote reply")
          menu.with_item(label: "Reference in new issue")
          menu.with_divider
          menu.with_item(label: "Edit")
          menu.with_item(label: "Delete", scheme: :danger)
        end
      end

      # @label Content labels
      #
      def content_labels; end

      # @label Default
      #
      # @snapshot interactive
      def default
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end

          menu.with_item(label: "Copy link")
          menu.with_item(label: "Quote reply")
          menu.with_item(label: "Reference in new issue")
          menu.with_divider
          menu.with_item(label: "Edit") do |item|
            item.with_description.with_content("Change settings")
          end
          menu.with_item(label: "Delete", scheme: :danger) do |item|
            item.with_description.with_content("Sayonara")
          end
        end
      end

      # @label With groups
      #
      # @snapshot interactive
      def with_groups
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Favorite character"
          end

          menu.with_group do |group|
            group.with_heading(title: "Battlestar Galactica")
            group.with_item(label: "William Adama")
            group.with_item(label: 'Kara "Starbuck" Thrace')
            group.with_item(label: 'Sharon "Boomer" Valerii')
            group.with_item(label: "Gaius Baltar")
          end

          menu.with_group do |group|
            group.with_heading(title: "Star Trek")
            group.with_item(label: "Capt. Jean-luc Picard")
            group.with_item(label: "Capt. Kathryn M. Janeway")
            group.with_item(label: "Capt. Benjamin L. Sisko")
            group.with_item(label: "Capt. James T. Kirk")
          end

          menu.with_group do |group|
            group.with_heading(title: "Star Wars")
            group.with_item(label: "Leia Organa")
            group.with_item(label: "Luke Skywalker")
            group.with_item(label: "Han Solo")
            group.with_item(label: "Chewbacca")
          end
        end
      end

      # @label With items and groups
      #
      # @snapshot interactive
      def with_items_and_groups
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Meal preference"
          end

          menu.with_item(label: "Meat option")
          menu.with_divider

          menu.with_group do |group|
            group.with_heading(title: "Vegetarian options")
            group.with_item(label: "Grilled portbello mushroom")
            group.with_item(label: "Polenta")
            group.with_item(label: "Seitan")
          end

          menu.with_divider
          menu.with_item(label: "Fish option")
        end
      end

      # @label Wide
      #
      # @snapshot interactive
      def wide
        render(Primer::Alpha::ActionMenu.new(select_variant: :single, size: :medium)) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "A wider menu"
          end

          menu.with_item(label: "Default", active: true, value: "default") do |item|
            item.with_trailing_visual_label(scheme: :accent, inline: true).with_content("Recommended")
            item.with_description { "This is an example for wide ActionMenus" }
          end

          menu.with_item(label: "Extended", active: false, value: "extended") do |item|
            item.with_description { "It allows for extended descriptions with extra afforance for additional visuals" }
          end
        end
      end

      # @label With icon button
      #
      def with_icon_button
        render(Primer::Alpha::ActionMenu.new) do |menu|
          menu.with_show_button(icon: :star, "aria-label": "Menu")
          menu.with_item(label: "Does something")
        end
      end

      # @label Single select
      #
      def single_select
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Fast forward")
          menu.with_item(label: "Recursive")
          menu.with_item(label: "Ours")
          menu.with_item(label: "Resolve")
        end
      end

      # @label Multiple select
      #
      def multiple_select
        render(Primer::Alpha::ActionMenu.new(select_variant: :multiple)) do |menu|
          menu.with_show_button { "Menu" }

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/18661030?v=4",
            username: "langermank",
            full_name: "Katie Langerman",
            full_name_scheme: :inline,
            avatar_arguments: { shape: :square }
          )

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/54012?s=96&v=4",
            username: "jonrohan",
            full_name: "Jon Rohan",
            full_name_scheme: :inline,
            avatar_arguments: { shape: :square }
          )

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/1446503?v=4",
            username: "broccolinisoup",
            full_name: "Armağan Ersöz",
            full_name_scheme: :inline,
            avatar_arguments: { shape: :square }
          )
        end
      end

      # @label Links
      #
      def links
        render(Primer::Alpha::ActionMenu.new) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Settings", href: "/")
          menu.with_item(label: "Your repositories", href: "/")
          menu.with_item(label: "Disabled", href: "/", disabled: true)
        end
      end

      # @label Single item selected
      #
      # @snapshot interactive
      def single_selected_item
        render(Primer::Alpha::ActionMenu.new(select_variant: :single)) do |menu|
          menu.with_show_button { "Menu" }
          menu.with_item(label: "Copy link")
          menu.with_item(label: "Quote reply", active: true)
          menu.with_item(label: "Reference in new issue")
        end
      end

      # @label Single Select with Internal Label
      #
      # @snapshot interactive
      def single_select_with_internal_label
        render(Primer::Alpha::ActionMenu.new(select_variant: :single, dynamic_label: true, dynamic_label_prefix: "Menu")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end
          menu.with_item(label: "Copy link") do |item|
            item.with_trailing_visual_label(scheme: :accent, inline: true).with_content("Recommended")
          end
          menu.with_item(label: "Quote reply", active: true)
          menu.with_item(label: "Reference in new issue")
        end
      end

      # @label Multiple items selected
      #
      # @snapshot interactive
      def multiple_selected_items
        render(Primer::Alpha::ActionMenu.new(select_variant: :multiple)) do |menu|
          menu.with_show_button { "Menu" }

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/18661030?v=4",
            username: "langermank",
            full_name: "Katie Langerman",
            full_name_scheme: :inline,
            active: true
          )

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/54012?s=96&v=4",
            username: "jonrohan",
            full_name: "Jon Rohan",
            full_name_scheme: :inline
          )

          menu.with_avatar_item(
            src: "https://avatars.githubusercontent.com/u/1446503?v=4",
            username: "broccolinisoup",
            full_name: "Armağan Ersöz",
            full_name_scheme: :inline,
            active: true
          )
        end
      end

      # @label With deferred content
      #
      def with_deferred_content
        render(Primer::Alpha::ActionMenu.new(menu_id: "deferred", src: UrlHelpers.action_menu_deferred_path)) do |menu|
          menu.with_show_button { "Menu with deferred content" }
        end
      end

      # @label With deferred preloaded content
      #
      def with_deferred_preloaded_content
        render(Primer::Alpha::ActionMenu.new(menu_id: "deferred-preload", preload: true, src: UrlHelpers.action_menu_deferred_preload_path)) do |menu|
          menu.with_show_button { "Menu with deferred and preloaded content" }
        end
      end

      # @label With actions
      #
      # @param disable_items toggle
      def with_actions(disable_items: false, route_format: :html)
        render_with_template(locals: { disable_items: disable_items, route_format: route_format })
      end

      # @label Single select form
      #
      def single_select_form(route_format: :html)
        render_with_template(locals: { route_format: route_format })
      end

      # @label Single select form items
      #
      def single_select_form_items(route_format: :html)
        render_with_template(locals: { route_format: route_format })
      end

      # @label Multiple select form
      #
      def multiple_select_form(route_format: :html)
        render_with_template(locals: { route_format: route_format })
      end

      # @label With disabled items
      #
      def with_disabled_items
        render(Primer::Alpha::ActionMenu.new) do |component|
          component.with_show_button { "Trigger" }
          component.with_item(label: "Does something", tag: :button, disabled: true)
          component.with_item(label: "Site", tag: :a, href: "/", disabled: true)
        end
      end

      # @label Opens a dialog
      #
      def opens_dialog(menu_id: "menu-1")
        render_with_template(locals: {
                               menu_id: menu_id
                             })
      end

      # @label Align end
      #
      def align_end(menu_id: "menu-1")
        render_with_template(locals: {
                               menu_id: menu_id
                             })
      end

      # @label [Item] Block description
      #
      def block_description
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end
          menu.with_item(label: "Item label") do |item|
            item.with_description.with_content("Block description")
          end
        end
      end

      # @label [Item] Submitting Forms
      #
      def submitting_forms
        render_with_template(locals: {})
      end

      # @label [Item] Inline description
      #
      def inline_description
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end
          menu.with_item(label: "Item label", description_scheme: :inline) do |item|
            item.with_description.with_content("Inline description")
          end
        end
      end

      # @label [Item] Leading visual
      #
      def leading_visual
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1")) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end
          menu.with_item(label: "Item label", description_scheme: :inline) do |item|
            item.with_leading_visual_icon(icon: :gear)
            item.with_description.with_content("Inline description")
          end
        end
      end

      # @label [Item] Leading visual single select
      #
      def leading_visual_single_select
        render(Primer::Alpha::ActionMenu.new(menu_id: "menu-1", select_variant: :single)) do |menu|
          menu.with_show_button do |button|
            button.with_trailing_action_icon(icon: :"triangle-down")
            "Menu"
          end
          menu.with_item(label: "Item label", description_scheme: :inline) do |item|
            item.with_leading_visual_icon(icon: :gear)
            item.with_description.with_content("Inline description")
          end
        end
      end

      # @label Two menus
      #
      def two_menus; end
    end
  end
end
