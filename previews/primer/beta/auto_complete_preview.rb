# frozen_string_literal: true

require_relative "../url_helpers"

module Primer
  module Beta
    # @label AutoComplete
    class AutoCompletePreview < ViewComponent::Preview
      # @label Playground
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      # @param inset toggle
      # @param monospace toggle
      def playground(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id", inset: false, monospace: false)
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name, inset: inset, monospace: monospace)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @label Default
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      # @param inset toggle
      # @param monospace toggle
      def default(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id", inset: false, monospace: false)
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name, inset: inset, monospace: monospace)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @label With submit button
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def with_submit_button(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: true, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render_with_template(locals: {
                               label_text: label_text,
                               show_clear_button: show_clear_button,
                               visually_hide_label: visually_hide_label,
                               placeholder: placeholder,
                               size: size,
                               full_width: full_width,
                               width: width,
                               disabled: disabled,
                               invalid: invalid,
                               input_id: input_id,
                               list_id: list_id,
                               input_name: input_name
                             })
      end

      # @label Leading visual
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def leading_visual(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @label Trailing action
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def trailing_action(label_text: "Select a fruit", show_clear_button: true, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name))
      end

      # @label Full width
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def full_width(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: true, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @label Visually hide label
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def visually_hide_label(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: true, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @!group Sizes

      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def small(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :small, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id-1", list_id: "list-id-1", input_name: "input-id-1")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def medium(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id-2", list_id: "list-id-2", input_name: "input-id-2")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def large(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :large, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id-3", list_id: "list-id-3", input_name: "input-id-3")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path, show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @!endgroup

      # @label Leading visual in results
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def leading_visual_in_results(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path(visual: "leading"), show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name))
      end

      # @label Trailing visual in results
      # @param label_text text
      # @param show_clear_button toggle
      # @param visually_hide_label toggle
      # @param placeholder text
      # @param size select [small, medium, large]
      # @param full_width toggle
      # @param width select [auto, small, medium, large, xlarge, xxlarge]
      # @param disabled toggle
      # @param invalid toggle
      # @param input_id text
      # @param list_id text
      # @param input_name text
      def trailing_visual_in_results(label_text: "Select a fruit", show_clear_button: false, visually_hide_label: false, placeholder: "Placeholder text", size: :medium, full_width: false, width: :auto, disabled: false, invalid: false, input_id: "input-id", list_id: "list-id", input_name: "input-id")
        render(Primer::Beta::AutoComplete.new(label_text: label_text, input_id: input_id, list_id: list_id, src: UrlHelpers.autocomplete_index_path(visual: "trailing"), show_clear_button: show_clear_button, visually_hide_label: visually_hide_label, placeholder: placeholder, size: size, full_width: full_width, width: width, disabled: disabled, invalid: invalid, input_name: input_name))
      end

      # @hidden
      def with_non_visible_label
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path, visually_hide_label: true))
      end

      # @hidden
      def with_icon
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path)) do |component|
          component.with_leading_visual_icon(icon: :search)
        end
      end

      # @hidden
      def show_clear_button
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path, show_clear_button: true))
      end

      # @hidden
      def size_small
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path, show_clear_button: false, size: :small))
      end

      # @hidden
      def monospace
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path, show_clear_button: false, monospace: true))
      end

      # @hidden
      def inset
        render(Primer::Beta::AutoComplete.new(label_text: "Select a fruit", input_id: "input-id", list_id: "test-id", src: UrlHelpers.autocomplete_index_path, show_clear_button: false, inset: true))
      end
    end
  end
end
