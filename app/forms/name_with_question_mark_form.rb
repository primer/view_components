# frozen_string_literal: true

# :nodoc:
class NameWithQuestionMarkForm < ApplicationForm
  form do |name_with_question_mark_form|
    name_with_question_mark_form.check_box(
      name: :enabled?,
      label: "Enabled"
    )
  end
end
