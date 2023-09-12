# frozen_string_literal: true

module Primer
  # :nodoc:
  module Forms
    def self.inline_form(builder, base = nil, &block)
      base ||= if defined?(ApplicationForm)
        ApplicationForm
      else
        Primer::Forms::Base
      end

      klass = Class.new(base) do
        form(&block)
      end

      klass.new(builder)
    end
  end
end
