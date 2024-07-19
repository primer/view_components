# frozen_string_literal: true

module Primer
  module OpenProject
    class PageHeader
      # A Helper class to create a Title inside the PageHeader title slot
      # It should not be used standalone
      class Title < Primer::Component
        status :open_project

        HEADING_TAG_OPTIONS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze
        HEADING_TAG_FALLBACK = :h1

        renders_one :editable_form, lambda { |model: nil, update_path:, cancel_path:, input_name: :title, method: :put, label: I18n.t(:label_title), placeholder: I18n.t(:label_title), **system_arguments|
          primer_form_with(
            model: model,
            method: method,
            url: update_path,
            **system_arguments
          ) do |f|
            render(::PageHeader::EditableTitleForm.new(
              f,
              cancel_url: cancel_path,
              input_name: input_name,
              label: label,
              placeholder: placeholder
            ))
          end
        }

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: HEADING_TAG_FALLBACK, state: Primer::OpenProject::PageHeader::STATE_DEFAULT, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(HEADING_TAG_OPTIONS, tag, HEADING_TAG_FALLBACK)

          @state = state
        end

        def render?
          raise ArgumentError, "Please define form paramaters for the editable title" if !show_state? && !editable_form?

          content? && (show_state? || editable_form?)
        end

        private

        def show_state?
          @state == Primer::OpenProject::PageHeader::STATE_DEFAULT
        end
      end
    end
  end
end
