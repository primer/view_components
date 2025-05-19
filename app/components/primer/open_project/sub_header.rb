# frozen_string_literal: true

module Primer
  module OpenProject
    # The SubHeader contains specific actions to modify the page content below, e.g a filter button or a create button
    # It should not be used stand alone, but in combination with a PageHeader, either as a direct sibling or as part of a tab content
    class SubHeader < Primer::Component
      status :open_project

      HIDDEN_FILTER_TARGET_SELECTOR = "sub-header.hiddenItemsOnExpandedFilter"
      SHOWN_FILTER_TARGET_SELECTOR = "sub-header.shownItemsOnExpandedFilter"

      MOBILE_ACTIONS_DISPLAY = [:flex, :none].freeze
      DESKTOP_ACTIONS_DISPLAY = [:none, :flex].freeze

      # A button or custom content that will render on the right-hand side of the component.
      #
      # To render a button, call the `with_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      #
      # To render custom content, call the `with_button_component` method and pass a block that returns HTML.
      renders_many :actions, types: {
        button: {
          renders: lambda { |icon_only: false, leading_icon:, label:, **kwargs, &block|
            if label.nil? || label.empty?
              raise ArgumentError, "You need to provide a valid label."
            end

            kwargs[:icon] = leading_icon

            kwargs[:aria] ||= merge_aria(
              kwargs,
              { aria: { label: label } }
            )

            icon_args = kwargs.deep_dup

            if icon_only
              Primer::Beta::IconButton.new(**icon_args)
            else
              @mobile_actions ||= []
              mobile_component =  Primer::Beta::IconButton.new(display: MOBILE_ACTIONS_DISPLAY,
                                                               **icon_args)
              @mobile_actions.push({ component: mobile_component, block: block})

              Primer::OpenProject::SubHeader::Button.new(display: DESKTOP_ACTIONS_DISPLAY, **kwargs)
            end
          },
        },
        button_group: {
          renders: lambda { |**kwargs|
            Primer::OpenProject::SubHeader::ButtonGroup.new(**kwargs)
          },
        },
        menu: {
          renders: lambda { |icon_only: false, leading_icon:, label:, button_arguments: {}, **kwargs, &block|
            if label.nil? || label.empty?
              raise ArgumentError, "You need to provide a valid label."
            end

            kwargs[:leading_icon] = leading_icon
            kwargs[:label] = label
            kwargs[:button_arguments] = button_arguments

            @mobile_actions ||= []
            mobile_component =  Primer::OpenProject::SubHeader::Menu.new(icon_only: true,
                                                                         display: MOBILE_ACTIONS_DISPLAY,
                                                                         **kwargs)
            @mobile_actions.push({ component: mobile_component, block: block})

            Primer::OpenProject::SubHeader::Menu.new(icon_only: icon_only,display: DESKTOP_ACTIONS_DISPLAY, **kwargs)
          },
        }
      }

      renders_one :filter_input, lambda { |name:, label:, **system_arguments|
        if label.nil? || label.empty?
          raise ArgumentError, "You need to provide a valid label."
        end

        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "SubHeader-filterInput",
          "SubHeader-filterInput_hiddenClearButton"
        )
        system_arguments[:placeholder] ||= I18n.t("button_filter")
        system_arguments[:leading_visual] ||= { icon: :search }
        system_arguments[:visually_hide_label] ||= true
        system_arguments[:input_width] ||= :medium

        system_arguments[:data] ||= {}
        system_arguments[:data] = merge_data(
         system_arguments,
           { data: { target: "sub-header.filterInput" } }
         )

        system_arguments[:show_clear_button] = true if system_arguments[:show_clear_button].nil?

        if system_arguments[:show_clear_button]
          system_arguments[:data][:action] ||= ""
          system_arguments[:data][:action] += " input:sub-header#toggleFilterInputClearButton focus:sub-header#toggleFilterInputClearButton"
        end

        @mobile_filter_trigger = Primer::Beta::IconButton.new(icon: system_arguments[:leading_visual][:icon],
                                                              display: [:inline_flex, :none],
                                                              aria: { label: label },
                                                              mr: 2,
                                                              "data-action": "click:sub-header#expandFilterInput",
                                                              "data-targets": HIDDEN_FILTER_TARGET_SELECTOR)

        @mobile_filter_cancel = Primer::Beta::Button.new(scheme: :invisible,
                                                         display: :none,
                                                         data: {
                                                           targets: SHOWN_FILTER_TARGET_SELECTOR,
                                                           action: "click:sub-header#collapseFilterInput"})


        Primer::Alpha::TextField.new(name: name, label: label, **system_arguments)
      }


      # A button or custom content that will render on the left-hand side of the component, next to the filter input.
      #
      # To render a button, call the `with_filter_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Button) %>.
      #
      # To render custom content, call the `with_filter_component` method and pass a block that returns HTML.
      renders_one :filter_button, types: {
        button: {
          renders: lambda { |icon_only: false, leading_icon: :filter, mobile_label: I18n.t("button_filter"), **kwargs|
            kwargs[:mr] ||= 2
            kwargs[:icon] = leading_icon

            kwargs[:aria] ||= merge_aria(
              kwargs,
              { aria: { label: mobile_label } }
            )

            icon_args = kwargs.deep_dup
            icon_args = set_as_hidden_filter_target(icon_args)

            if icon_only
              Primer::Beta::IconButton.new(**icon_args)
            else
              @mobile_filter_button =  Primer::Beta::IconButton.new(display: MOBILE_ACTIONS_DISPLAY,
                                                                    **icon_args)

              Primer::OpenProject::SubHeader::Button.new(display: DESKTOP_ACTIONS_DISPLAY, **kwargs)
            end
          },

          as: :filter_button
        },
        component: {
          # A generic slot to render a custom filter component
          renders: lambda { |**kwargs|
            deny_tag_argument(**kwargs)
            kwargs[:tag] = :div
            kwargs[:mr] ||= 2
            kwargs = set_as_hidden_filter_target(kwargs)

            Primer::BaseComponent.new(**kwargs)
          },

          as: :filter_component
        }
      }

      renders_one :segmented_control, lambda { |**system_arguments, &block|
          deny_tag_argument(**system_arguments)
          system_arguments[:mr] ||= 2
          system_arguments = set_as_hidden_filter_target(system_arguments)

          @segmented_control_block = block
          @mobile_segmented_control = Primer::OpenProject::SubHeader::SegmentedControl.new(
            hide_labels: true,
            display: MOBILE_ACTIONS_DISPLAY,
            **system_arguments
          )

          Primer::OpenProject::SubHeader::SegmentedControl.new(display: DESKTOP_ACTIONS_DISPLAY, **system_arguments)
      }

      renders_one :text, lambda { |**system_arguments|
        system_arguments[:font_weight] ||= :bold

        Primer::Beta::Text.new(**system_arguments)
      }

      # A slot for a generic component which will be shown in a second row below the rest, spanning the whole width
      renders_one :bottom_pane_component, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:mt] ||= 3

        Primer::BaseComponent.new(**system_arguments)
      }


      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"sub-header"

        @filter_container = Primer::BaseComponent.new(tag: :div,
                                                      classes: "SubHeader-filterContainer",
                                                      display: DESKTOP_ACTIONS_DISPLAY,

                                                      mr: 2,
                                                      data: { targets: SHOWN_FILTER_TARGET_SELECTOR })

        @system_arguments[:classes] = class_names(
          "SubHeader",
          system_arguments[:classes]
        )
      end

      def before_render
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "SubHeader--emptyLeftPane" => !segmented_control? && !filter_button && !filter_input
        )
      end

      def set_as_hidden_filter_target(system_arguments)
        system_arguments[:data] ||= {}
        system_arguments[:data] = merge_data(
            system_arguments, {
            data: {
              targets: HIDDEN_FILTER_TARGET_SELECTOR,
            }
          }
        )
        system_arguments
      end
    end
  end
end
