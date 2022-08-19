# frozen_string_literal: true

module Primer
  module Forms
    # :nodoc:
    class Caption < BaseComponent
      def initialize(input:)
        @input = input
      end

      def caption_template?
        @input.caption_template?
      end

      def render_caption_template
        @input.render_caption_template
      end

      def before_render
        return unless @input.caption? && caption_template?

        raise <<~MESSAGE
          Please provide either a caption: argument or caption template for the
          '#{@input.name}' input; both were found.
        MESSAGE
      end
    end
  end
end
