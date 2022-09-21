# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class CheckBoxInput < Input
        DEFAULT_SCHEME = :boolean
        SCHEMES = [DEFAULT_SCHEME, :array].freeze

        attr_reader :name, :label, :value, :scheme

        def initialize(name:, label:, value: nil, scheme: DEFAULT_SCHEME, **system_arguments)
          raise ArgumentError, "Check box scheme must be one of #{SCHEMES.join(', ')}" unless SCHEMES.include?(scheme)

          raise ArgumentError, "Check box needs an explicit value if scheme is array" if scheme == :array && value.nil?

          @name = name
          @label = label
          @value = value
          @scheme = scheme

          super(**system_arguments)
        end

        def to_component
          CheckBox.new(input: self)
        end

        def type
          :check_box
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
