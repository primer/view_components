# frozen_string_literal: true

module Beta
  # @label FlashComponent
  class FlashComponentPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param full toggle
    # @param spacious toggle
    # @param dismissible toggle
    # @param icon [Symbol] select [alert, check, info, people]
    # @param scheme [Symbol] select [default, warning, danger, success]
    # @param content text
    def playground(full: false, spacious: false, dismissible: false, icon: :people, scheme: Primer::FlashComponent::DEFAULT_SCHEME, content: "This is a flash message!")
      render(Primer::FlashComponent.new(full: full, spacious: spacious, dismissible: dismissible, icon: icon, scheme: scheme)) { content }
    end
  end
end
