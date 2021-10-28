# frozen_string_literal: true

module Primer
  # This module implements behavior that allows a component to memoize itself
  # and its content. This is useful for components that may be rendered
  # multiple times in a request using the same arguments.
  #
  # Components that use Cacheable should not mutate their internal state after
  # the first render since as their initial return value is cached.
  #
  # For example:
  # ```ruby
  # class Current < ActiveSupport::CurrentAttributes
  #   attribute :primer_cache
  # end
  #
  # class MyComponent
  #   include Primer::Cacheable
  #
  #   def initialize(value)
  #     @value = value
  #   end
  #
  #   private
  #
  #   def cache_container
  #     Current.primer_cache ||= {}
  #     Current.primer_cache[name] ||= {}
  #   end
  # end
  #
  # render MyComponent.new(1) # Instantiates and renders a new instance
  # render MyComponent.new(1) # Re-uses the same instance and output from above
  # render MyComponent.new(2) # Instantiates and renders a new instance
  # ```
  #
  # Components utilizing this method must implement a method called
  # `cache_container` that exposes a mutable hash. For most use-cases
  # `ActiveSupport::CurrentAttributes` is sufficient and will reset the cache
  # after each render.
  #
  # Additionally, to opt-in to the caching behavior callers must utilize the
  # `.with` class method instead of calling `.new`.
  module Cacheable
    extend ActiveSupport::Concern

    module CacheCall
      def call
        @__vc_cached_call ||= super
      end
    end

    included do
      prepend CacheCall
    end

    class_methods do
      def with(*args, **kwargs, &block)
        key = [args, kwargs, block]

        cache_container[key] ||= new(*args, **kwargs, &block)
      end
    end
  end
end
