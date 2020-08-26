# frozen_string_literal: true

module Primer
  MissingComponentError = Class.new(NameError)

  # Provides a convenient shorthand for rendering Primer components.
  module ViewHelper
    # Writing to the Components hash in an initializer is supported for class names
    # that can't be inferred by camelizing, e.g.
    #
    #   Primer::ViewHelper::Components[:special] = Primer::VerySpecialComponent
    #
    # or to prevent stale classes when reloading in development:
    #
    #   Rails.configuration.to_prepare do
    #     Primer::ViewHelper::Components.clear if Rails.env.development?
    #   end
    Components = Hash.new do |hash, component|
      hash[component] = primer_component_class_for(component)
    end

    # Renders a Primer view component, inferring the component's class name
    # from the first argument, so that
    #
    #   <%= primer :avatar, size: 50 do %>
    #      ...
    #   <% end %>
    #
    # is equivalent to
    #
    #   <%= render Primer::AvatarComponent.new(size: 50) do
    #      ...
    #   <% end %>
    def primer(component, **kwargs, &block)
      render Components[component].new(**kwargs), &block
    end

    def self.primer_component_class_for(component) # :nodoc:
      case component
      when String, Symbol
        "Primer::#{component.to_s.camelize}Component".constantize
      when Class
        component
      else
        raise ArgumentError, "component must be a String, Symbol, or Class"
      end
    rescue NameError => error
      raise MissingComponentError.new(error.message, error.name)
    end
  end
end
