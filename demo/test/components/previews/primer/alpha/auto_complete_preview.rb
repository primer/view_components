module Primer
  module Alpha
    class AutoCompletePreview < ViewComponent::Preview
      def default
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha"))
      end

      def with_non_visible_label
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha", is_label_visible: false))
      end

      def with_icon
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha", with_icon: true))
      end

      def with_clear_button
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha", is_clearable: true))
      end
    end
  end
end
