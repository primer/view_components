# frozen_string_literal: true

module Primer
  class FormTestComponent < ViewComponent::Base
    def initialize(form_class:)
      @form_class = form_class
    end
  end
end
