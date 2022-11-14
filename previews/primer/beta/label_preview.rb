# frozen_string_literal: true

module Primer
  module Beta
    # @label Label
    class LabelPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param size [Symbol] select [medium, large]
      # @param tag [Symbol] select [span, summary, a, div]
      # @param inline [Boolean] toggle
      def playground(size: :medium, tag: :span, inline: false)
        render(Primer::Beta::Label.new(tag: tag, size: size, inline: inline)) { "Label" }
      end

      # @label Default Options
      def default
        render(Primer::Beta::Label.new) { "Label" }
      end

      # @!group Color Schemes
      #
      # @label Default
      def color_scheme_default
        render(Primer::Beta::Label.new) { "Default" }
      end

      # @label Primary
      def color_scheme_primary
        render(Primer::Beta::Label.new(scheme: :primary)) { "Primary" }
      end

      # @label Secondary
      def color_scheme_secondary
        render(Primer::Beta::Label.new(scheme: :secondary)) { "Secondary" }
      end

      # @label Accent
      def color_scheme_accent
        render(Primer::Beta::Label.new(scheme: :accent)) { "Accent" }
      end

      # @label Success
      def color_scheme_success
        render(Primer::Beta::Label.new(scheme: :success)) { "Success" }
      end

      # @label Attention
      def color_scheme_attention
        render(Primer::Beta::Label.new(scheme: :attention)) { "Attention" }
      end

      # @label Danger
      def color_scheme_danger
        render(Primer::Beta::Label.new(scheme: :danger)) { "Danger" }
      end

      # @label Severe
      def color_scheme_severe
        render(Primer::Beta::Label.new(scheme: :severe)) { "Severe" }
      end

      # @label Done
      def color_scheme_done
        render(Primer::Beta::Label.new(scheme: :done)) { "Done" }
      end

      # @label Sponsors
      def color_scheme_sponsors
        render(Primer::Beta::Label.new(scheme: :sponsors)) { "Sponsors" }
      end
      #
      # @!endgroup

      # @!group Sizes
      #
      # @label Default
      def size_default
        render(Primer::Beta::Label.new) { "Default" }
      end

      # @label Large
      def size_large
        render(Primer::Beta::Label.new(size: :large)) { "Large" }
      end
      #
      # @!endgroup

      # @!group Inline
      #
      # @label Default
      def inline_default
        render(Primer::Beta::Label.new) { "Default" }
      end

      # @label Inline
      def inline_inline
        render(Primer::Beta::Label.new(inline: true)) { "Inline" }
      end
      #
      # @!endgroup
    end
  end
end
