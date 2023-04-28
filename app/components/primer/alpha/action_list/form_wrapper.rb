# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Utility component for wrapping ActionLists or individual ActionList::Items in forms.
      class FormWrapper < Primer::Component
        DEFAULT_HTTP_METHOD = :get
        HTTP_METHOD_OPTIONS = [
          DEFAULT_HTTP_METHOD,
          :post,
          :patch,
          :put,
          :delete,
          :head
        ].freeze

        def initialize(list:, action: nil, **form_arguments)
          @list = list
          @form_arguments = form_arguments

          @action = action
          @http_method = extract_http_method(@form_arguments)

          name = @form_arguments.delete(:name)
          value = @form_arguments.delete(:value) || name

          @input_arguments = {
            type: :hidden,
            name: name,
            value: value,
            data: { list_item_input: true },
            **(@form_arguments.delete(:input_arguments) || {})
          }
        end

        def get?
          @http_method == :get
        end

        def form_required?
          @action && !get?
        end

        def render_input?
          @input_arguments[:name].present?
        end

        private

        def extract_http_method(args)
          if (http_method = args.delete(:method))
            HTTP_METHOD_OPTIONS.include?(http_method) ? http_method : DEFAULT_HTTP_METHOD
          else
            DEFAULT_HTTP_METHOD
          end
        end
      end
    end
  end
end
