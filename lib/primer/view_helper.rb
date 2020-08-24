# frozen_string_literal: true

# Provides a convenient shorthand for components.
module Primer::ViewHelper
  Components = Hash.new do |hash, component|
    hash[component] = "Primer::#{component.to_s.camelize}Component".constantize
  end

  def primer(component, **kwargs, &block)
    render Components[component].new(**kwargs), &block
  end
end
