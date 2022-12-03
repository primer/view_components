# frozen_string_literal: true

module Primer
  module Alpha
    # @label AutoComplete
    class AutoCompletePreview < ViewComponent::Preview
      # @label Playground
      # @param label_text text
      # @param is_label_visible toggle
      # @param is_label_inline toggle
      # @param with_icon toggle
      # @param is_clearable toggle
      def playground(label_text: "Select a fruit", is_label_visible: true, is_label_inline: false, with_icon: false, is_clearable: false)
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha", is_label_visible: is_label_visible, is_label_inline: is_label_inline, with_icon: with_icon, is_clearable: is_clearable))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @label Default Options
      # @param label_text text
      # @param is_label_visible toggle
      # @param is_label_inline toggle
      # @param with_icon toggle
      # @param is_clearable toggle
      def default(label_text: "Select a fruit", is_label_visible: true, is_label_inline: false, with_icon: false, is_clearable: false)
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: label_text, input_id: "input-id", list_id: "test-id", src: "/auto_complete?version=alpha", is_label_visible: is_label_visible, is_label_inline: is_label_inline, with_icon: with_icon, is_clearable: is_clearable))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @!group More examples

      # @label AutoComplete with non-visible label
      def with_non_visible_label
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-1", list_id: "test-id-1", src: "/auto_complete?version=alpha", is_label_visible: false))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @label AutoComplete with inline label
      def with_inline_label
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-2", list_id: "test-id-2", src: "/auto_complete?version=alpha", is_label_inline: true))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @label AutoComplete with search icon
      def with_icon
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-3", list_id: "test-id-3", src: "/auto_complete?version=alpha", with_icon: true))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @label AutoComplete with clear button
      def with_clear_button
        # rubocop:disable Primer/ComponentNameMigration
        render(Primer::Alpha::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id-4", list_id: "test-id-4", src: "/auto_complete?version=alpha", is_clearable: true))
        # rubocop:enable Primer/ComponentNameMigration
      end

      # @!endgroup
    end
  end
end
