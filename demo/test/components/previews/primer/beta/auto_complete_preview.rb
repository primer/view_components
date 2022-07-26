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

      def leading_visual
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id", src: "/auto_complete")) do |c|
          c.leading_visual_icon(icon: :search)
        end
      end

      def full_width
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", full_width: true))
      end

      def size_small
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: false, size: :small))
      end

      def monospace
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: false, monospace: true))
      end

      def inset
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: "/auto_complete", show_clear_button: false, inset: true))
      end
    end
  end
end
