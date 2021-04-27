# frozen_string_literal: true

module Primer
  # `BorderBox` is a Box component with a border.
  class BorderBoxComponent < Primer::Component
    status :beta

    DEFAULT_PADDING = :default
    PADDING_MAPPINGS = {
      DEFAULT_PADDING => "",
      :condensed => "Box--condensed",
      :spacious => "Box--spacious"
    }.freeze

    # Optional Header.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :header, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "Box-header",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # Optional Body.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :body, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "Box-body",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # Optional Footer.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :footer, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "Box-footer",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # Use Rows to add rows with borders and maintain the same padding.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_many :rows, lambda { |**system_arguments|
      system_arguments[:tag] = :li
      system_arguments[:classes] = class_names(
        "Box-row",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Header, body, rows, and footer
    #   <%= render(Primer::BorderBoxComponent.new) do |component| %>
    #     <% component.header do %>
    #       Header
    #     <% end %>
    #     <% component.body do %>
    #       Body
    #     <% end %>
    #     <% component.row do %>
    #       <% if true %>
    #         Row one
    #       <% end %>
    #     <% end %>
    #     <% component.row do %>
    #       Row two
    #     <% end %>
    #     <% component.footer do %>
    #       Footer
    #     <% end %>
    #   <% end %>
    #
    # @example Padding density
    #   <%= render(Primer::BorderBoxComponent.new(padding: :condensed)) do |component| %>
    #     <% component.header do %>
    #       Header
    #     <% end %>
    #     <% component.body do %>
    #       Body
    #     <% end %>
    #     <% component.row do %>
    #       Row two
    #     <% end %>
    #     <% component.footer do %>
    #       Footer
    #     <% end %>
    #   <% end %>
    #
    # @param padding [Symbol] <%= one_of(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(padding: DEFAULT_PADDING, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "Box",
        PADDING_MAPPINGS[fetch_or_fallback(PADDING_MAPPINGS.keys, padding, DEFAULT_PADDING)],
        system_arguments[:classes]
      )
    end

    def render?
      rows.any? || header.present? || body.present? || footer.present?
    end
  end
end
