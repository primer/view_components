# frozen_string_literal: true

module Primer
  module Responsive
    # @label ArgumentDefinition
    class ResponsiveDefinitionPreview < ViewComponent::Preview
      MAIN_TEMPLATE = "primer/responsive/responsive_preview_output"
      ERROR_STYLE = "color: darkred"

      # @label Argument validation playground
      #
      # @param show_object toggle
      # @param responsive select [~, [_no, no], transitional, yes]
      # @param allowed_values text
      # @param allowed_values_type select [~, String, Integer]
      # @param type select [~, String, Integer]
      # @param default text
      # @param default_type select [~, String, Integer]
      # @param v_narrow_allowed_values text
      # @param v_narrow_allowed_values_type select [~, String, Integer]
      # @param v_narrow_default text
      # @param v_narrow_default_type select [~, String, Integer]
      # @param v_regular_allowed_values text
      # @param v_regular_allowed_values_type select [~, String, Integer]
      # @param v_regular_default text
      # @param v_regular_default_type select [~, String, Integer]
      def definition_validation_playground(
        show_object: false,
        responsive: "",
        allowed_values: "",
        allowed_values_type: "",
        default: "",
        default_type: "",
        type: "",
        v_narrow_allowed_values: "",
        v_narrow_allowed_values_type: "",
        v_narrow_default: "",
        v_narrow_default_type: "",
        v_regular_allowed_values: "",
        v_regular_allowed_values_type: "",
        v_regular_default: "",
        v_regular_default_type: ""
      )
        args = { name: :component_argument }
        responsive = :no if responsive == "false"
        args[:responsive] = responsive.to_sym unless responsive.empty?

        unless allowed_values.empty?
          args[:allowed_values] = allowed_values.split(",").map(&:strip)
          args[:allowed_values] = args[:allowed_values].map(&:to_i) if allowed_values_type == "Integer"
        end

        unless default.empty?
          default = default.to_i if default_type == "Integer"
          args[:default] = default
        end

        unless type.empty?
          args[:type] = case type
                        when "String"
                          String
                        when "Integer"
                          Integer
                        end
        end

        unless v_narrow_allowed_values.empty? && v_narrow_default.empty?
          args[:v_narrow] = {}
          v_narrow = args[:v_narrow]
          unless v_narrow_allowed_values.empty?
            v_narrow[:allowed_values] = v_narrow_allowed_values.split(",").map(&:strip)
            v_narrow[:allowed_values] = v_narrow[:allowed_values].map(&:to_i) if v_narrow_allowed_values_type == "Integer"
          end
          unless v_narrow_default.empty?
            v_narrow_default = v_narrow_default.to_i if v_narrow_default_type == "Integer"
            v_narrow[:default] = v_narrow_default
          end
        end

        unless v_regular_allowed_values.empty? && v_regular_default.empty?
          args[:v_regular] = {}
          v_regular = args[:v_regular]
          unless v_regular_allowed_values.empty?
            v_regular[:allowed_values] = v_regular_allowed_values.split(",").map(&:strip)
            v_regular[:allowed_values] = v_regular[:allowed_values].map(&:to_i) if v_regular_allowed_values_type == "Integer"
          end
          unless v_regular_default.empty?
            v_regular_default = v_regular_default.to_i if v_regular_default_type == "Integer"
            v_regular[:default] = v_regular_default
          end
        end

        begin
          argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError => e
          error_message = e.message
        end

        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "object", output: argument_definition.pretty_inspect } if show_object
        panels << { title: "ERROR", style: ERROR_STYLE, output: error_message } if error_message.present?

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Validate value
      #
      # @param value text
      # @param value_type select [String, Symbol]
      # @param responsive_variant select [~, v_narrow, v_regular, v_wide]
      def validate_value(value: "", value_type: "String", responsive_variant: "")
        args = {
          name: :test,
          allowed_values: [:a, :b, :c],
          responsive: :transitional,
          default: :a,
          v_narrow: {
            additional_allowed_values: [:d, :e],
            default: :d
          },
          v_regular: {
            default: :b
          },
          v_wide: {
            additional_allowed_values: [:xl]
          },
          deprecation: {
            deprecated_values: [:x, :g]
          }
        }

        argument_definition = Primer::Responsive::ArgumentDefinition.new(args)

        responsive_variant = responsive_variant.empty? ? nil : responsive_variant.to_sym
        case value_type
        when "Integer"
          value = value.empty? ? 0 : value.to_i
        when "Symbol"
          value = value.empty? ? nil : value.to_sym
        end

        log_message = "valid?: #{argument_definition.valid_value?(value, responsive_variant).inspect}, "
        log_message += "deprecated? #{argument_definition.deprecated_value?(value)}"

        begin
          argument_definition.validate_value(value, responsive_variant)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentValueError => e
          error_message = e.message
        end

        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "value", output: value.pretty_inspect }
        panels << { title: "log", output: log_message }

        panels << { title: "error", style: ERROR_STYLE, output: error_message } if error_message.present?

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Valid definition
      #
      # @param show_object toggle
      def stress_test(show_object: false)
        args = {
          name: :test,
          allowed_values: [:a, :b, :c],
          responsive: :transitional,
          default: :a,
          v_narrow: {
            allowed_values: [:d, :e],
            default: :d
          },
          v_regular: {
            default: :b
          },
          v_wide: {
            allowed_values: [:xl]
          },
          deprecation: {
            deprecated_values: [:x]
          }
        }

        begin
          argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError => e
          error_message = e.message
        end

        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "object", output: argument_definition.pretty_inspect } if show_object
        panels << { title: "ERROR", style: ERROR_STYLE, output: error_message } if error_message.present?

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Error: invalid default
      #
      # @param show_object toggle
      def invalid_default_type(show_object: false)
        args = {
          name: :test,
          type: Numeric,
          default: "Hello"
        }

        begin
          argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError => e
          error_message = e.message
        end

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "object", output: argument_definition.pretty_inspect } if show_object
        panels << { title: "ERROR", style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Errors: invalid responsive default
      #
      # @param show_object toggle
      def invalid_default(show_object: false)
        args = {
          name: :test,
          allowed_values: [1, 2, 3],
          responsive: :yes,
          v_narrow: {
            allowed_values: [4, 5],
            default: 6
          }
        }

        begin
          argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError => e
          error_message = e.message
        end

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "object", output: argument_definition.pretty_inspect } if show_object
        panels << { title: "ERROR", style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Errors: :type × :allowed_values
      #
      # @param show_object toggle
      def definition_error_type_values(show_object: false)
        args = {
          name: :test,
          type: String,
          responsive: :transitional,
          v_narrow: {
            allowed_values: [1, 2],
            default: 1
          }
        }

        begin
          argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        rescue Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentDefinitionError => e
          error_message = e.message
        end

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { title: "object", output: argument_definition.pretty_inspect } if show_object
        panels << { title: "ERROR", style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @!group Deprecation
      # @label Deprecation: value
      def deprecate_value
        args = {
          name: :test,
          allowed_values: [1, 2, 3, 4],
          responsive: :yes,
          deprecation: {
            deprecated_values: [5, 6],
            warn_message: "Support for these values is going to be dropped in the next release"
          }
        }
        argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        error_message = argument_definition.deprecation_warn_message(5)

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Deprecation: type
      def deprecate_type
        args = {
          name: :test,
          type: String,
          deprecation: {
            type: Integer
          }
        }
        argument_definition = Primer::Responsive::ArgumentDefinition.new(args)
        error_message = argument_definition.deprecation_warn_message(5)

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label Deprecation: argument
      def deprecate_argument
        args = {
          name: :test,
          allowed_values: [1, 2, 3],
          deprecation: {
            warn_message: "This argument is unsafe and will be sunset in version 1.8"
          }
        }
        argument_definition = Primer::Responsive::ArgumentDefinition.new(args)

        error_message = argument_definition.deprecation_warn_message(5)

        # output
        panels = []
        panels << { title: "args", output: args.pretty_inspect }
        panels << { style: ERROR_STYLE, output: error_message }

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end
      # @!endgroup
    end
  end
end
