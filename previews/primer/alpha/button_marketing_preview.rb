# frozen_string_literal: true

module Primer
  module Alpha
    # @label ButtonMarketing
    class ButtonMarketingPreview < ViewComponent::Preview
      # @label Playground
      # @param scheme [Symbol] select [default, primary, outline, transparent]
      # @param variant [Symbol] select [default, large]
      # @param tag [Symbol] select [button, a]
      # @param type [Symbol] select [button, submit]
      # @param disabled [Boolean]
      def playground(tag: :button, type: :button, scheme: :default, variant: :default, disabled: false)
        render(Primer::Alpha::ButtonMarketing.new(tag: tag, type: type, scheme: scheme, variant: variant, disabled: disabled)) { "Default" }
      end

      # @label Default options
      # @param scheme [Symbol] select [default, primary, outline, transparent]
      # @param variant [Symbol] select [default, large]
      # @param tag [Symbol] select [button, a]
      # @param type [Symbol] select [button, submit]
      def default(tag: :button, type: :button, scheme: :default, variant: :default)
        render(Primer::Alpha::ButtonMarketing.new(tag: tag, type: type, scheme: scheme, variant: variant)) { "Default" }
      end

      # @!group Size Variants
      #
      # @label Default
      def sizes_default
        render(Primer::Alpha::ButtonMarketing.new) { "Default" }
      end

      # @label Large
      def sizes_large
        render(Primer::Alpha::ButtonMarketing.new(variant: :large)) { "Large" }
      end
      # @!endgroup

      # @!group Schemes
      #
      # @label Default
      def scheme_default
        render(Primer::Alpha::ButtonMarketing.new) { "Default" }
      end

      # @label Primary
      def scheme_primary
        render(Primer::Alpha::ButtonMarketing.new(scheme: :primary)) { "Primary" }
      end

      # @label Outline
      def scheme_outline
        render(Primer::Alpha::ButtonMarketing.new(scheme: :outline)) { "Outline" }
      end

      # @label Transparent
      def scheme_transparent
        render(Primer::Alpha::ButtonMarketing.new(scheme: :transparent)) { "Transparent" }
      end
      # @!endgroup
    end
  end
end
