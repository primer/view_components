module Primer
  module Beta
    class AutoCompletePreview < ViewComponent::Preview
      def default
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete"))
      end

      def with_non_visible_label
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", visually_hide_label: true))
      end

      def with_icon
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete")) do |c|
          c.leading_visual_icon(icon: :search)
        end
      end

      def show_clear_button
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: true))
      end
    end
  end
end
