# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class Input
        # Use this macro anywhere you want to include the various params all inputs can receive.
        #
        # @!macro [new] form_input_arguments
        #   @param name [String] Value for the HTML name attribute.
        #   @param id [String] Value for the HTML id attribute.
        #   @param class [String] CSS classes to include in the input's HTML `class` attribute. Exists for compatibility with Rails form builders.
        #   @param classes [Array] CSS classes to include in the input's HTML `class` attribute. Combined with the `:class` argument. The list may contain strings, hashes, or `nil` values, and is automatically cleaned up by Primer's [`class_name` helper](https://github.com/primer/view_components/blob/c9cb95c98fee3e2e27f4a10683f555e22285e7f1/app/lib/primer/class_name_helper.rb) (`nils`, falsy entries, and blank strings are ignored).
        #   @param caption [String] A string describing the field and what sorts of input it expects. Displayed below the input.
        #   @param label [String] Label text displayed above the input.
        #   @param visually_hide_label [Boolean] When set to `true`, hides the label. Although the label will be hidden visually, it will still be visible to screen readers.
        #   @param disabled [Boolean] When set to `true`, the input will not accept keyboard or mouse input.
        #   @param hidden [Boolean] When set to `true`, visually hides the field.
        #   @param invalid [Boolean] If set to `true`, the input will be rendered with a red border. Implied if `validation_message` is truthy. This option is set to `true` automatically if the model object associated with the form reports that the input is invalid via Rails validations. It is provided for cases where the form does not have an associated model. If the input is invalid as determined by Rails validations, setting `invalid` to `false` will have no effect.
        #   @param validation_message [String] A string displayed between the caption and the input indicating the input's contents are invalid. This option is, by default, set to the first Rails validation message for the input (assuming the form is associated with a model object). Use `validation_message` to override the default or to provide a validation message in case there is no associated model object.
        #   @param label_arguments [Hash] Attributes that will be passed to Rails' `builder.label` method. These can be HTML attributes or any of the other label options Rails supports. They will appear as HTML attributes on the `<label>` tag.
        #   @param scope_name_to_model [Boolean] Default `true`. When set to `false`, prevents the model name from prefixing the field name. For example, if the field name is `my_field`, Rails will normally emit an HTML name attribute of `model[my_field]`. Setting `scope_name_to_model` to `false` will cause Rails to emit `my_field` instead.
        #   @param scope_id_to_model [Boolean] Default `true`. When set to `false`, prevents the model name from prefixing the field ID. For example, if the field name is `my_field`, Rails will normally emit an HTML ID attribute of `model_my_field`. Setting `scope_id_to_model` to `false` will cause Rails to emit `my_field` instead.
        #   @param required [Boolean] Default `false`. When set to `true`, causes an asterisk (*) to appear next to the field's label indicating it is a required field. Note that this option explicitly does _not_ add a `required` HTML attribute. Doing so would enable native browser validations, which are inaccessible and inconsistent with the Primer design system.
        #   @param aria [Hash] Key/value pairs that represent Aria attributes and their values. Eg. `aria: { current: true }` becomes `aria-current="true"`.
        #   @param data [Hash] Key/value pairs that represent data attributes and their values. Eg. `data: { foo: "bar" }` becomes `data-foo="bar"`.
        #   @macro form_system_arguments

        # @!macro [new] form_size_arguments
        #   @param size [Symbol] The size of the field. <%= one_of(Primer::Forms::Dsl::Input::SIZE_OPTIONS) %>

        # @!macro [new] form_full_width_arguments
        #   @param full_width [Boolean] When set to `true`, the field will take up all the horizontal space allowed by its container.

        # @!macro [new] form_system_arguments
        #   @param system_arguments [Hash] A hash of attributes passed to the underlying Rails builder methods. These options may mean something special depending on the type of input, otherwise they are emitted as HTML attributes. See the [Rails documentation](https://guides.rubyonrails.org/form_helpers.html) for more information. In addition, the usual Primer utility arguments are accepted in system arguments. For example, passing `mt: 2` will add the `mt-2` class to the input. See the Primer system arguments docs for details.

        SPACE_DELIMITED_ARIA_ATTRIBUTES = %i[describedby].freeze
        DEFAULT_SIZE = :medium
        SIZE_MAPPINGS = {
          :small => "FormControl-small",
          DEFAULT_SIZE => "FormControl-medium",
          :large => "FormControl-large"
        }.freeze
        SIZE_OPTIONS = SIZE_MAPPINGS.keys

        DEFAULT_INPUT_WIDTH = :auto
        INPUT_WIDTH_MAPPINGS = {
          DEFAULT_INPUT_WIDTH => "FormControl-input-width--auto",
          :small => "FormControl-input-width--small",
          :medium => "FormControl-input-width--medium",
          :large => "FormControl-input-width--large",
          :xlarge => "FormControl-input-width--xlarge",
          :xxlarge => "FormControl-input-width--xxlarge"
        }.freeze
        INPUT_WIDTH_OPTIONS = INPUT_WIDTH_MAPPINGS.keys

        include Primer::ClassNameHelper

        attr_reader :builder, :form, :input_arguments, :label_arguments, :caption, :validation_message, :ids, :form_control, :base_id

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
          @input_width = @input_arguments.delete(:input_width)

          # If scope_name_to_model is false, the name of the input for eg. `my_field`
          # will be `my_field` instead of the Rails default of `model[my_field]`.
          #
          # We achieve this by passing the `name` option to Rails form builder
          # methods. These methods will use the passed name if provided instead
          # of generating a scoped one.
          #
          unless @input_arguments.delete(:scope_name_to_model) { true }
            @input_arguments[:name] = name
          end
          # rubocop:enable Style/IfUnlessModifier

          # If scope_id_to_model is false, the name of the input for eg. `my_field`
          # will be `my_field` instead of the Rails default of `model_my_field`.
          #
          # We achieve this by passing the `id` option to Rails form builder
          # methods. These methods will use the passed id if provided instead
          # of generating a scoped one. The id is the name of the field unless
          # explicitly provided in system_arguments.
          #
          # rubocop:disable Style/IfUnlessModifier
          unless @input_arguments.delete(:scope_id_to_model) { true }
            @input_arguments[:id] = @input_arguments.delete(:id) { name }
          end
          # rubocop:enable Style/IfUnlessModifier

          # Whether or not to wrap the component in a FormControl, which renders a
          # label above and validation message beneath the input.
          @form_control = @input_arguments.delete(:form_control) { true }

          @input_arguments[:invalid] = "true" if invalid?

          @base_id = SecureRandom.uuid

          @ids = {}.tap do |id_map|
            id_map[:validation] = "validation-#{@base_id}" if supports_validation?
            id_map[:caption] = "caption-#{@base_id}" if caption? || caption_template?
          end

          add_input_aria(:required, true) if required?
          add_input_aria(:invalid, true) if invalid?
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

        # :nocov:
        def remove_input_data(key)
          input_data.delete(key)
        end

        # :nocov:

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
          supports_validation? && validation_messages.empty? && !@invalid
        end

        def invalid?
          supports_validation? && !valid?
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
          !!input_arguments[:disabled]
        end

        def full_width?
          @full_width
        end

        def size
          @size ||= SIZE_MAPPINGS.include?(@size) ? @size : DEFAULT_SIZE
        end

        def input_width
          @input_width ||= INPUT_WIDTH_MAPPINGS.include?(@input_width) ? @input_width : DEFAULT_INPUT_WIDTH
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

        def supports_validation?
          true
        end

        def validation_arguments
          {
            class: "FormControl-inlineValidation",
            id: validation_id,
            hidden: valid? || validation_messages.empty?
          }
        end

        def validation_message_arguments
          {}
        end

        def validation_success_icon_target
          ""
        end

        def validation_error_icon_target
          ""
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
