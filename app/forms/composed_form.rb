# frozen_string_literal: true

# :nodoc:
class ComposedForm < ApplicationForm
  form do |composed_form|
    composed_form.fields_for(:first_name) do |builder|
      FirstNameForm.new(builder)
    end

    composed_form.fields_for(:last_name) do |builder|
      LastNameForm.new(builder)
    end
  end
end
