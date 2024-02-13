# frozen_string_literal: true

module Primer
  module Beta
    # Use `ButtonGroup` to render a series of buttons.
    class ButtonGroup < Primer::Component
      status :beta

      # @!parse
      #   # Adds a button.
      #   #
      #   # @param icon [Symbol] If included, adds a <%= link_to_component(Primer::Beta::IconButton) %> with the given <%= link_to_octicons %>. Otherwise, a <%= link_to_component(Primer::Beta::Button) %> is added instead.
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %> or <%= link_to_component(Primer::Beta::IconButton) %>, depending on the value of the `icon:` argument.
      #   def with_button(icon: nil, **system_arguments)
      #   end

      # @!parse
      #   # Adds a button that activates a menu when clicked.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::ButtonGroup::MenuButton) %>.
      #   def with_menu_button(**system_arguments)
      #   end

      # @!parse
      #   # Adds a <%= link_to_component(Primer::Beta::ClipboardCopyButton) %>.
      #   #
      #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::ClipboardCopyButton) %>.
      #   def with_clipboard_copy_button(**system_arguments)
      #   end

      # List of buttons to be rendered. Add buttons via the `#with_button`, `#with_menu_button`, and `#with_clipboard_copy_button` methods (see below).
      renders_many :buttons, types: {
        button: {
          renders: lambda { |icon: nil, **kwargs|
            kwargs[:size] = @size
            kwargs[:scheme] = @scheme

            if icon
              Primer::Beta::IconButton.new(icon: icon, **kwargs)
            else
              Primer::Beta::Button.new(**kwargs)
            end
          },

          as: :button
        },

        menu_button: {
          renders: lambda { |**system_arguments|
            MenuButton.new(**system_arguments)
          },

          as: :menu_button
        },

        clipboard_copy_button: {
          renders: lambda { |**kwargs|
            kwargs[:size] = @size
            kwargs[:scheme] = @scheme
            Primer::Beta::ClipboardCopyButton.new(**kwargs)
          },

          as: :clipboard_copy_button
        }
      }

      # @param scheme [Symbol] DEPRECATED. <%= one_of(Primer::Beta::Button::SCHEME_OPTIONS) %>
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(scheme: Primer::Beta::Button::DEFAULT_SCHEME, size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @size = size
        @scheme = scheme
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div

        @system_arguments[:classes] = class_names(
          "ButtonGroup",
          system_arguments[:classes]
        )
      end

      def render?
        buttons.any?
      end


      class MenuButton < Primer::Component
        # @param menu_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu) %>.
        # @param button_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %> or <%= link_to_component(Primer::Beta::IconButton) %>, depending on the value of the `icon:` argument.
        def initialize(menu_arguments: {}, button_arguments: {})
          @menu = Primer::Alpha::ActionMenu.new(**menu_arguments)
          @button = @menu.with_show_button(**button_arguments) do |button|
            @button_contents
          end
        end

        def render_in(view_context, &block)
          super(view_context) do
            @button_contents = block.call(@menu, @button)
          end
        end

        def before_render
          content
        end

        def call
          render(@menu)
        end
      end
    end
  end
end
