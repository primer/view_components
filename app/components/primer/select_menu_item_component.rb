# frozen_string_literal: true

module Primer
  class SelectMenuItemComponent < Primer::Component
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] ||= :button
      @kwargs[:role] ||= "menuitem"
      @kwargs[:classes] = class_names(
        "SelectMenu-item",
        kwargs[:classes],
      )
    end

    def component
      case @kwargs[:tag]
      when :button
        Primer::ButtonComponent.new(**@kwargs)
      when :a
        Primer::LinkComponent.new(**@kwargs)
      else
        Primer::BaseComponent.new(**@kwargs)
      end
    end
  end
end
