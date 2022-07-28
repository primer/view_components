# frozen_string_literal: true

module Primer
  # This component is designed to be used outside the context of a form object.
  # It can be rendered just like any other View Component and accepts the same
  # arguments as the form input it wraps.
  #
  # Eg:
  #
  # render(
  #   Primer::TextField.new(
  #     name: "foo",
  #     label: "Foo",
  #     caption: "Something about foos"
  #   )
  # )
  #
  TextField = Primer::FormComponents.from_input(Primer::Forms::Dsl::TextFieldInput)
end
