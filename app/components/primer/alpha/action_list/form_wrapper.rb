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

          # When a form is inside a menu, suppress form semantics.
          # Otherwise, NVDA will miscount menu items.
          @form_arguments[:html] ||= {}
          @form_arguments[:html][:role] = :none

          @action = action
          @http_method = extract_http_method(@form_arguments)

          name = @form_arguments.delete(:name)
          value = @form_arguments.delete(:value) || name
          inputs = @form_arguments.delete(:inputs) || []

          # For the older version of this component that only allowed you to
          # specify a single input
          if inputs.empty?
            inputs << {
              name: name,
              value: value,
              **(@form_arguments.delete(:input_arguments) || {})
            }
          end

          @inputs = inputs.map do |input_data|
            input_data = input_data.dup
            input_data[:type] ||= :hidden
            input_data[:data] ||= {}
            input_data[:data][:list_item_input] = true
            input_data
          end
        end

        def get?
          @http_method == :get
        end

        def form_required?
          @action && !get?
        end

        def render_inputs?
          @inputs.present?
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
