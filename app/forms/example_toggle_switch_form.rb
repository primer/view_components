# frozen_string_literal: true

class ExampleToggleSwitchForm < Primer::Forms::ToggleSwitchForm
  def initialize(**system_arguments)
    super(name: :example_field, label: "Example", **system_arguments)
  end
end
