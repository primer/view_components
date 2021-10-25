# frozen_string_literal: true

require "primer/classify/utilities"

Primer::Classify::Utilities.singleton_class.prepend(Module.new do
  # The original method retrieves a config option from Rails.application, which isn't
  # defined when RuboCop is running.
  def validate_class_names?
    true
  end
end)

Dir[File.join(__dir__, "primer", "*.rb")].sort.each { |file| require file }
