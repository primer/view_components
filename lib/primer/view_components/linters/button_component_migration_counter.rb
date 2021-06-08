# frozen_string_literal: true

require_relative "helpers"

module Primer
  module ViewComponents
    module Linters
      # Counts the number of times a HTML button is used instead of the component.
      class ButtonComponentMigrationCounter < ERBLint::Linter
        include Helpers

        TAGS = %w[button summary a].freeze
        CLASSES = %w[btn btn-link].freeze
        MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."

        def run(processed_source)
          tags(processed_source).each do |tag|
            next if tag.closing?
            next unless TAGS&.include?(tag.name)

            classes = tag.attributes["class"]&.value&.split(" ")

            next if classes&.intersection(CLASSES).blank?

            args = begin
                     ArgumentMapper.new(tag).to_args
                   rescue ArgumentMapper::ConversionError
                     nil
                   end

            message = if args.nil?
                        MESSAGE
                      elsif args.empty?
                        MESSAGE + "\n<%= render Primer::ButtonComponent.new %>"
                      else
                        MESSAGE + "\n<%= render Primer::ButtonComponent.new(#{args}) %>"
                      end

            generate_offense(self.class, processed_source, tag, message)
          end

          counter_correct?(processed_source)
        end

        # Maps from classes to arguments.
        class ArgumentMapper
          class ConversionError < StandardError; end

          SCHEME_MAPPINGS = {
            "btn-primary" => ":primary",
            "btn-danger" => ":danger",
            "btn-outline" => ":outline",
            "btn-invisible" => ":invisible",
            "btn-link" => ":link"
          }.freeze

          VARIANT_MAPPINGS = {
            "btn-sm" => ":small",
            "btn-large" => ":large"
          }.freeze

          def initialize(tag)
            @tag = tag
          end

          def to_args
            args = {}

            args[:tag] = ":#{@tag.name}" unless @tag.name == "button"

            @tag.attributes.each do |attribute|
              attr_name = attribute.name

              if attr_name == "class"
                args = args.merge(classes_to_args(attribute))
              elsif attr_name == "disabled"
                args[:disabled] = true
              elsif attr_name.start_with?("aria-", "data-")
                args["\"#{attr_name}\""] = "\"#{attribute.value}\""
              else
                raise ConversionError, "Cannot convert attribute #{attr_name}"
              end
            end

            args.map { |k, v| "#{k}: #{v}" }.join(", ")
          end

          def classes_to_args(classes)
            hash = classes.value.split(" ").each_with_object({}) do |class_name, acc|
              next if class_name == "btn"

              if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
                acc[:scheme] = SCHEME_MAPPINGS[class_name]
              elsif VARIANT_MAPPINGS[class_name] && acc[:variant].nil?
                acc[:variant] = VARIANT_MAPPINGS[class_name]
              elsif class_name == "btn-block"
                acc[:block] = true
              elsif class_name == "BtnGroup-item"
                acc[:group_item] = true
              else
                raise ConversionError, "Cannot convert class #{class_name}"
              end
            end

            hash
          end
        end
      end
    end
  end
end
