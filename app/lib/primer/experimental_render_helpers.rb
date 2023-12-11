# frozen_string_literal: true

module Primer
  # :nodoc:
  module ExperimentalRenderHelpers
    def self.included(base)
      base.include(InstanceMethods)
    end

    # :nodoc:
    module InstanceMethods
      def evaluate_block(*args, **kwargs, &block)
        # Prevent double renders by using the capture method on the component
        # that originally received the block.
        #
        # Handle blocks that originate from C code such as `&:method` by checking
        # source_location. Such blocks don't allow access to their receiver.
        return unless block

        return yield(*args, **kwargs) if block&.source_location.nil?

        block_context = block.binding.receiver

        if block_context.class < ActionView::Base
          block_context.capture(*args, &block)
        else
          capture(*args, &block)
        end
      end
    end
  end
end
