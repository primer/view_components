# frozen_string_literal: true

module Primer
  module OpenProject
    # A Helper class to create a Button with required icon inside the SubHeader action slot
    # Do not use standalone
    class SubHeader::Button < Primer::Component
      status :open_project

      renders_one :leading_visual_icon, lambda { |**system_arguments|
        # Do nothing as this slot is reserved for the enforced leading icon
      }

      # @param icon [Symbol] The name of an <%= link_to_octicons %> icon to use as leading visual
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon:, **system_arguments)
        @icon = icon
        @button = Primer::Beta::Button.new(**system_arguments)
      end

      delegate :trailing_visual_icon?, :trailing_visual_icon, :with_trailing_visual_icon, :with_trailing_visual_content_icon,
               :trailing_visual_counter?, :trailing_visual_counter, :with_trailing_visual_counter, :with_trailing_visual_content_counter,
               :trailing_visual_label?, :trailing_visual_label, :with_trailing_visual_label, :with_trailing_visual_content_label,
               :trailing_action?, :trailing_action, :with_trailing_action, :with_trailing_action_content,
               :tooltip?, :tooltip, :with_tooltip, :with_tooltip,
               to: :@button

      def before_render
        if leading_visual_icon.present?
          raise ArgumentError,
                "Do not use the leading_visual_icon slot within the SubHeader, as it is reserved. Instead provide a leading_icon within the subHeader button slot"
        end
      end

      def call
        render(@button) do |button|
          button.with_leading_visual_icon(icon: @icon)
          content
        end
      end
    end
  end
end
