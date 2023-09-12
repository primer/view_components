# frozen_string_literal: true

module Primer
  # :nodoc:
  module Forms
    def self.inline_form(builder, base = nil, &block)
      base ||= defined?(ApplicationForm) ? ApplicationForm : Primer::Forms::Base

      klass = Class.new(base) do
        form(&block)
      end

      klass.new(builder)
    end
  end
end
