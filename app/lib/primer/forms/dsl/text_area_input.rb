# frozen_string_literal: true

module Primer
  module Forms
    module Dsl
      # :nodoc:
      class TextAreaInput < Input
        attr_reader :name, :label, :character_limit

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @character_limit = system_arguments.delete(:character_limit)

          if @character_limit.present? && @character_limit.to_i <= 0
            raise ArgumentError, "character_limit must be a positive integer, got #{@character_limit}"
          end

          super(**system_arguments)

          add_input_data(:target, "primer-text-area.inputElement")
        end

        def to_component
          TextArea.new(input: self)
        end

        def type
          :text_area
        end

        def character_limit?
          @character_limit.present?
        end

        def character_limit_sr_id
          @character_limit_sr_id ||= "#{name}-character-count-sr-#{SecureRandom.hex(4)}"
        end

        def character_limit_display_id
          @character_limit_display_id ||= "#{name}-character-limit-display-#{SecureRandom.hex(4)}"
        end

        def character_limit_validation_id
          @character_limit_validation_id ||= "#{name}-character-limit-validation-#{SecureRandom.hex(4)}"
        end

        # :nocov:
        def focusable?
          true
        end
        # :nocov:
      end
    end
  end
end
