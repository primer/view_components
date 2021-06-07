# frozen_string_literal: true

require_relative "helpers"

module Primer
  module ViewComponents
    module Linters
      # Counts the number of times a HTML button is used instead of the component.
      class ButtonComponentMigrationCounter < ERBLint::Linter
        include Helpers

        TAGS = %w[button summary a].freeze
        CLASS = "btn"
        MESSAGE = "We are migrating buttons to use [Primer::ButtonComponent](https://primer.style/view-components/components/button), please try to use that instead of raw HTML."

        def run(processed_source)
          tags(processed_source).each do |tag|
            next if tag.closing?
            next unless self.class::TAGS&.include?(tag.name)

            classes = tag.attributes["class"]&.value&.split(" ")

            next unless !self.class::CLASS || classes&.include?(self.class::CLASS)

            args = ArgumentMapper.new(tag).to_args

            message = if args.nil?
                        self.class::MESSAGE
                      elsif args.empty?
                        self.class::MESSAGE + "\n<%= render Primer::ButtonComponent.new %>"
                      else
                        self.class::MESSAGE + "\n<%= render Primer::ButtonComponent.new(#{args}) %>"
                      end

            generate_offense(self.class, processed_source, tag, message)
          end

          counter_correct?(processed_source)
        end

        # Maps from classes to arguments.
        class ArgumentMapper
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
            @classes = tag.attributes["class"]
          end

          def to_args
            # We currently only know how to convert simple buttons.
            return nil if @tag.attributes_node.to_a > 1

            hash = @classes.each_with_object({}) do |class_name, acc|
              next if class_name == "btn"

              if SCHEME_MAPPINGS[class_name] && acc[:scheme].nil?
                acc[:scheme] = SCHEME_MAPPINGS[class_name]
              elsif VARIANT_MAPPINGS[class_name] && acc[:variant].nil?
                acc[:variant] = VARIANT_MAPPINGS[class_name]
              elsif class_name == "btn-block"
                acc[:block] = true
              else
                acc[:conversion_error] = true
                break
              end
            end

            return nil if hash[:conversion_error]

            hash.map { |k, v| "#{k}: #{v}" }.join(", ")
          end
        end
      end
    end
  end
end
