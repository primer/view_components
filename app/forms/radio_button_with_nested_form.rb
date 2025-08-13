# frozen_string_literal: true

# :nodoc:
class RadioButtonWithNestedForm < ApplicationForm
  # :nodoc:
  class FriendForm < ApplicationForm
    form do |friend_form|
      friend_form.group(layout: :horizontal) do |name_group|
        name_group.text_field(name: "first_name", label: "First Name")
        name_group.text_field(name: "last_name", label: "Last Name")
      end
    end
  end

  # :nodoc:
  class FriendTextAreaForm < ApplicationForm
    form do |friend_text_area_form|
      friend_text_area_form.text_area(
        name: "description",
        label: "Describe this wonderful person in loving detail"
      )
    end
  end

  form do |radio_form|
    radio_form.radio_button_group(name: "channel") do |radio_group|
      radio_group.radio_button(value: "online", label: "Online advertisement", caption: "Facebook maybe?")
      radio_group.radio_button(value: "radio", label: "Radio advertisement", caption: "We love us some NPR")
      radio_group.radio_button(value: "friend", label: "From a friend", caption: "Wow, what a good person") do |friend_button|
        friend_button.nested_form do |builder|
          Primer::Forms::FormList.new(
            FriendForm.new(builder),
            FriendTextAreaForm.new(builder)
          )
        end
      end
    end
  end
end
