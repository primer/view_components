# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class CheckBoxInput < Input
        DEFAULT_SCHEME = :boolean
        SCHEMES = [DEFAULT_SCHEME, :array].freeze

        attr_reader :name, :label, :value, :unchecked_value, :scheme, :nested_form_block, :nested_form_arguments

        def initialize(name:, label:, value: nil, unchecked_value: nil, scheme: DEFAULT_SCHEME, **system_arguments)
          raise ArgumentError, "Check box scheme must be one of #{SCHEMES.join(', ')}" unless SCHEMES.include?(scheme)

          raise ArgumentError, "Check box needs an explicit value if scheme is array" if scheme == :array && value.nil?

          @name = name
          @label = label
          @value = value
          @unchecked_value = unchecked_value
          @scheme = scheme

          super(**system_arguments)

          yield(self) if block_given?
        end

        # check boxes cannot be invalid, as both checked and unchecked are valid states
        # :nocov:
        def valid?
          true
        end
        # :nocov:

        def to_component
          CheckBox.new(input: self)
        end

        def nested_form(**system_arguments, &block)
          @nested_form_arguments = system_arguments
          @nested_form_block = block
        end

        def type
          :check_box
        end

        def supports_validation?
          false
        end

        private

        def caption_template_name
          @caption_template_name ||= if @scheme == :array
                                       :"#{name}_#{value}"
                                     else
                                       name.to_sym
                                     end
        end
      end
    end
  end
end
