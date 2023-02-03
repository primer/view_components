# frozen_string_literal: true

# :nocov:
module Primer
  module Yard
    # :nodoc:
    class ComponentRef
      ATTR_DEFAULTS = {
        js: false,
        examples: true,
        published: true,
        form_component: false
      }.freeze

      attr_reader :klass, :attrs

      def initialize(klass, attrs)
        @klass = klass
        @attrs = attrs
      end

      def requires_js?
        @attrs.fetch(:js, ATTR_DEFAULTS[:js])
      end

      def should_have_examples?
        @attrs.fetch(:examples, ATTR_DEFAULTS[:examples])
      end

      def published?
        @attrs.fetch(:published, ATTR_DEFAULTS[:published])
      end

      def form_component?
        @attrs.fetch(:form_component, ATTR_DEFAULTS[:form_component])
      end
    end
  end
end
# :nocov:
