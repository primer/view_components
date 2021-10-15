# frozen_string_literal: true

module Primer
  module Alpha
    # Use `MarkdownToolbar` to add a Markdown-formatting toolbar to a textarea.
    # You can use the prepend_buttons and append_buttons slots for adding additional elements to the defaults if needed.
    # Use md_*_arguments to customize each of the default buttons (md_header, md_bold, md_italic, etc.), such as ga_events, etc.
    # ------
    # @accessibility
    # Add any accessibility considerations
    class MarkdownToolbar < Primer::Component
      attr_reader :textarea_id

      renders_one :prepend_buttons
      renders_one :append_buttons

      LABEL_AND_HOTKEY_MAP = {
        header: { label: "Add header text", hotkey: "" },
        bold: { label: "Add bold text", hotkey: "b" },
        italic: { label: "Add italic text", hotkey: "i" },
        quote: { label: "Insert a quote", hotkey: "Shift+."},
        link: { label: "Add a link", hotkey: "k" },
        code: { label: "Insert code", hotkey: "e" },
        unordered_list: { label: "Add a bulleted list", hotkey: "Shift+8"},
        ordered_list: { label: "Add a numbered list", hotkey: "Shift+7" },
        task_list: { label: "Add a task list", hotkey: "Shift+l"}
      }.freeze
  
      def initialize(
        textarea_id:,
        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"markdown-toolbar"
        @system_arguments[:role] = "toolbar"
        @system_arguments[:"aria-label"] = "Composition"
        @system_arguments[:for] = textarea_id
  
        @system_arguments[:display] = :flex
        @system_arguments[:px] = 2
        @system_arguments[:pt] = [2, nil, nil, 0, nil]
        @system_arguments[:align_items] = :flex_start
        @system_arguments[:flex_wrap] = :wrap
  
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "js-details-container Details toolbar-commenting no-wrap",
          "border-md-top border-lg-top-0"
        )

        @textarea_id = textarea_id
      end

      def label(key)
        label = LABEL_AND_HOTKEY_MAP.dig(key, :label)
        hotkey = LABEL_AND_HOTKEY_MAP.dig(key, :hotkey)

        label += " <ctrl+#{hotkey}>".downcase unless hotkey.blank?
        label
      end

      def hotkey(key)
        hotkey = LABEL_AND_HOTKEY_MAP.dig(key, :hotkey)
        unless hotkey.blank?
          request&.user_agent&.match?(/Macintosh/) ? "Meta+#{hotkey}" : "Control+#{hotkey}"
        end
      end

    end
  end
end
