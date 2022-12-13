# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class Input
        SPACE_DELIMITED_ARIA_ATTRIBUTES = %i[describedby].freeze
        DEFAULT_SIZE = :medium
        SIZE_MAPPINGS = {
          :small => "FormControl-small",
          DEFAULT_SIZE => "FormControl-medium",
          :large => "FormControl-large"
        }.freeze
        SIZE_OPTIONS = SIZE_MAPPINGS.keys

        include Primer::ClassNameHelper

        attr_reader :builder, :form, :input_arguments, :label_arguments, :caption, :validation_message, :ids, :form_control

        alias form_control? form_control

        def initialize(builder:, form:, **system_arguments)
          @builder = builder
          @form = form

          @input_arguments = system_arguments
          @label_arguments = @input_arguments.delete(:label_arguments) || {}

          @label_arguments[:class] = class_names(
            @label_arguments[:class],
            @input_arguments.fetch(:visually_hide_label, false) ? "sr-only" : nil
          )

          @input_arguments.delete(:visually_hide_label)

          @input_arguments.delete(:class) if @input_arguments[:class].blank?
          @label_arguments.delete(:class) if @label_arguments[:class].blank?

          @caption = @input_arguments.delete(:caption)
          @validation_message = @input_arguments.delete(:validation_message)
          @invalid = @input_arguments.delete(:invalid)
          @full_width = @input_arguments.delete(:full_width)
          @size = @input_arguments.delete(:size)

          # If scope_name_to_model is false, the name of the input for eg. `my_field`
          # will be `my_field` instead of the Rails default of `model[my_field]`.
          #
          # We achieve this by passing the `name` option to Rails form builder
          # methods. These methods will use the passed name if provided instead
          # of generating a scoped one.
          if !@input_arguments.delete(:scope_name_to_model)
            @input_arguments[:name] = name
          end

          # Whether or not to wrap the component in a FormControl, which renders a
          # label above and validation message beneath the input.
          @form_control = @input_arguments.delete(:form_control) { true }

          @input_arguments[:invalid] = "true" if invalid?

          base_id = SecureRandom.hex[0..5]

          @ids = {}.tap do |id_map|
            id_map[:validation] = "validation-#{base_id}" if invalid?
            id_map[:caption] = "caption-#{base_id}" if caption? || caption_template?
          end

          add_input_aria(:required, true) if required?
          add_input_aria(:describedby, ids.values) if ids.any?

          # avoid browser-native validation, which doesn't match Primer's style
          input_arguments.delete(:required)
        end

        def add_input_classes(*class_names)
          input_arguments[:class] = class_names(
            input_arguments[:class], *class_names
          )
        end

        def add_label_classes(*class_names)
          label_arguments[:class] = class_names(
            label_arguments[:class], *class_names
          )
        end

        def add_input_aria(key, value)
          @input_arguments[:aria] ||= {}

          @input_arguments[:aria][key] = if space_delimited_aria_attribute?(key)
                                           aria_join(@input_arguments[:aria][key], *Array(value))
                                         else
                                           value
                                         end
        end

        def add_input_data(key, value)
          input_data[key] = value
        end

        def remove_input_data(key)
          input_data.delete(key)
        end

        def merge_input_arguments!(arguments)
          arguments.each do |k, v|
            case k
            when :class, :classes, "class", "classes"
              add_input_classes(v)
            when :aria, "aria"
              v.each do |aria_k, aria_v|
                add_input_aria(aria_k, aria_v)
              end
            when :data, "data"
              v.each do |data_k, data_v|
                add_input_data(data_k, data_v)
              end
            else
              @input_arguments[k] = v
            end
          end
        end

        def validation_id
          ids[:validation]
        end

        def caption_id
          ids[:caption]
        end

        def caption?
          caption.present?
        end

        def caption_template?
          return false unless form

          form.caption_template?(caption_template_name)
        end

        def render_caption_template
          form.render_caption_template(caption_template_name)
        end

        def valid?
          validation_messages.empty? && !@invalid
        end

        def invalid?
          !valid?
        end

        def hidden?
          !!input_arguments[:hidden]
        end

        def required?
          input_arguments[:required] ||
            input_arguments[:aria_required] ||
            input_arguments[:"aria-required"] ||
            input_arguments.dig(:aria, :required)
        end

        def disabled?
          input_arguments.include?(:disabled)
        end

        def full_width?
          @full_width
        end

        def size
          @size ||= SIZE_MAPPINGS.include?(@size) ? @size : DEFAULT_SIZE
        end

        def validation_messages
          @validation_messages ||=
            if validation_message
              [validation_message]
            elsif builder.object.respond_to?(:errors)
              name ? builder.object.errors.full_messages_for(name) : []
            else
              []
            end
        end

        def autofocus!
          input_arguments[:autofocus] = true
        end

        # :nocov:
        def name
          raise_for_abstract_method!(__method__)
        end

        def label
          raise_for_abstract_method!(__method__)
        end

        def type
          raise_for_abstract_method!(__method__)
        end

        def to_component
          raise_for_abstract_method!(__method__)
        end
        # :nocov:

        def focusable?
          false
        end

        def input?
          true
        end

        def need_validation_element?
          invalid?
        end

        def validation_arguments
          {
            class: "FormControl-inlineValidation",
            id: validation_id,
            hidden: valid?
          }
        end

        def validation_message_arguments
          {}
        end

        private

        def input_data
          @input_arguments[:data] ||= {}
        end

        def caption_template_name
          return nil unless name

          @caption_template_name ||= if respond_to?(:value)
                                       :"#{name}_#{value}"
                                     else
                                       name.to_sym
                                     end
        end

        def space_delimited_aria_attribute?(attrib)
          SPACE_DELIMITED_ARIA_ATTRIBUTES.include?(attrib)
        end

        def aria_join(*values)
          values = values.flat_map { |v| v.to_s.split }
          values.reject!(&:empty?)
          values.join(" ")
        end

        # :nocov:
        def raise_for_abstract_method!(method_name)
          raise NotImplementedError, "subclasses must implement ##{method_name}."
        end
        # :nocov:
      end
    end
  end
end
