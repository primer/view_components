# frozen_string_literal: true

module Primer
  module Alpha
    # Tooltip contains text that labels or describes the element it is applied to, and will appear only on mouse hover or
    # keyboard focus on the element.
    # Tooltips are not visible by default, and can easily be ignored by the user. Additionally, it can cause a myriad of
    # accessibility issues when used incorrectly so use sparingly and follow the provided guidelines.
    #
    # - Tooltips should contain only **non-essential text**. Tooltips are not accessible on mobile devices so if access to
    # the tooltip content is critical for a user to correctly operate the UI, don't use tooltips.
    # - Tooltip text should be brief and to the point. This component only allows string content and no HTML elements.
    #
    # @accessibility
    #   - When `type: :label` is set, an `aria-labelledby` relationship is created between the tooltip and the tooltip trigger element.
    #     When `type: :description` is set, an `aria-describedby` relationship is created instead.
    #   - Only apply tooltips on **interactive elements** such as a link or a button. When tooltips are applied on static elements,
    #     screen reader users won't be able to access it reliably.
    #   - Tooltip should be placed adjacent after the element it is applied to in the DOM. This allows screen reader users
    #     to navigate to and copy the tooltip content versus if the tooltip element is placed at the end of the DOM.
    class Tooltip < Primer::Component
        DIRECTION_DEFAULT = :s
        DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :n, :e, :w, :ne, :nw, :se, :sw].freeze
  
        TYPE_FALLBACK = :description
        TYPE_OPTIONS = [:label, :description].freeze
  
        # @example As a description
        #   <%= render(Primer::IconButton.new(id: "bold-button", icon: :bold, "aria-label": "Bold")) %>
        #   <%= render(Primer::Alpha::Tooltip.new(for_id: "bold-button", type: :description, text: "Add bold text", direction: :ne)) %>
        #
        # @example As a label
        #   <%= render(Primer::ButtonComponent.new(id: "like-button")) { "👍" } %>
        #   <%= render(Primer::Alpha::Tooltip.new(for_id: "like-button", type: :label, text: "Like", direction: :n)) %>
        #
        # @param for_id [String] The ID of the element that the tooltip should be attached to.
        # @param type [Symbol] <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>.
        # @param direction [Symbol] <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
        # @param text [String] The text content of the tooltip. This should be brief and no longer than a sentence.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(type:, for_id:, text:, direction: DIRECTION_DEFAULT, **system_arguments)
          raise TypeError, "tooltip text must be a string" unless text.is_a?(String)
  
          @text = text
          @system_arguments = system_arguments
          @system_arguments[:hidden] = true
          @system_arguments[:tag] = :"primer-tooltip"
          @system_arguments[:for] = for_id
          @system_arguments[:"data-direction"] = fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT).to_s
          @system_arguments[:"data-type"] = fetch_or_fallback(TYPE_OPTIONS, type, TYPE_FALLBACK).to_s
        end
  
        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { @text }
        end
      end
    end
  end
  