# frozen_string_literal: true

module Primer
  module Alpha
    # @label ButtonMarketing
    class ButtonMarketingPreview < ViewComponent::Preview
      # @label Default options
      # @param scheme [Symbol] select [default, primary, outline, transparent]
      # @param variant [Symbol] select [default, large]
      # @param tag [Symbol] select [button, a]
      # @param type [Symbol] select [button, submit]
      def default(tag: :button, type: :button, scheme: :default, variant: :default)
        render(Primer::Alpha::ButtonMarketing.new(tag: tag, type: type, scheme: scheme, variant: variant)) { "Default" }
      end
    end
  end
end
