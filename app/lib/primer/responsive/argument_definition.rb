# frozen_string_literal: true

module Primer
  module Responsive
    RESPONSIVE_VARIANTS_MAP = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS_MAP
    RESPONSIVE_VARIANTS = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS
    REQUIRED_RESPONSIVE_VARIANTS = Primer::Responsive::ResponsiveConfig::REQUIRED_RESPONSIVE_VARIANTS

    # Argument Definition helps defining, validating, and deprecating an argument of responsive components
    class ArgumentDefinition
      ALLOWED_PARAMS = [
        :name,
        :variant_name,
        :allowed_values,
        :type,
        :default,
        :deprecation,
        :responsive
      ].concat(RESPONSIVE_VARIANTS).freeze
      RESPONSIVE_OPTIONS = [:no, :transitional, :yes].freeze

      attr_accessor :name
      attr_reader(
        :allowed_values,
        :type,
        :default,
        :deprecation,
        :responsive,
        :responsive_variants
      )

      def initialize(params = {})
        @params = params
        validate_params_structure unless ArgumentsDefinitionHelper.production_env?

        @name = params[:name]
        @allowed_values = params[:allowed_values]
        @type = params[:type]
        @default = params[:default]
        @deprecation = create_deprecation(params)
        @responsive = params.fetch(:responsive, :no)

        @are_variants_required = false
        @responsive_variants = nil
        unless @responsive == :no
          @responsive_variants = {}
          RESPONSIVE_VARIANTS.each do |variant|
            next unless params.key? variant

            @responsive_variants[variant] = ResponsiveVariantArgumentDefinition.new(
              name: @name,
              variant_name: variant,
              **params[variant]
            )
            @are_variants_required ||= @responsive_variants[variant].required?
          end
        end

        @has_defined_default = params.key?(:default)

        validate_definition unless ArgumentsDefinitionHelper.production_env?
      end

      # Checks if the argument is required by checking if it or its reponsive variants have defaults.
      def required?
        !@has_defined_default && (responsive?(:no) || @are_variants_required)
      end

      # checks responsive type of responsiveness in general.
      #
      # @param responsive_type [Symbol](:no, :transitional, :yes) the responsive type to check, or nil to ask if the argument
      #                        has responsive support (if:transitional or :yes).
      def responsive?(responsive_type = nil)
        return @responsive == responsive_type unless responsive_type.nil?

        @responsive != :no
      end

      # Check if the argument definition has an explicit default value.
      #
      # @param variant [Symbol](:v_narrow, :v_regular, :v_wide) if a variant is used, this method will answer if that specific variant
      #                has a default value, if not, thie method answers if the main argument has a default value.
      def defined_default?(variant = nil)
        return @has_defined_default if variant.nil? || !responsive?
        return @responsive_variants[variant].defined_default? if @responsive_variants.key?(variant)

        false
      end

      # Retrieves the default value for this argument or for its responsive variant. If the argument has no defined default value
      # this method will return nil.
      #
      # @param variant [Symbol](:v_narrow, :v_regular, :v_wide) if passed, will retrieve the default value for the responsive variant
      #                otherwise, retrieves the default value for the argument.
      def default_value(variant = nil)
        return @default unless responsive?
        return @default if variant.nil? || !defined_default?(variant)

        defined_default?(variant) ? @responsive_variants[variant].default : @default
      end

      # Checks if a given value is valid.
      #
      # @param value [Any] given value.
      # @param variant [Symbol](:v_narrow, :v_regular, :v_wide) specific responsive variant to check against.
      def valid_value?(value, variant = nil)
        # deprecated values are considered valid, even though they're discouraged
        return true if deprecated_value?(value)

        # type can't be changed based on responsive variants
        return value.is_a?(@type) unless @type.nil?

        if @responsive == :no
          return @allowed_values.include?(value) unless @allowed_values.nil?

          # if no allowed_values and no type is specified, the value is always valid
          return true
        end

        return true if @allowed_values.include?(value)
        return false if variant.nil?

        responsive_variant = @responsive_variants[variant]

        # definition with no type and no allowed_values allows anything
        return true if @allowed_values.nil? && (responsive_variant.nil? || responsive_variant.allowed_values.nil?)

        !!responsive_variant&.allowed_values&.include?(value)
      end

      # Checks if a given value is valid and raises error if it's not.
      #
      # @param value [Any] given value.
      # @param variant [Symbol](:v_narrow, :v_regular, :v_wide) specific responsive variant to check against.
      #
      # @raise Primer::Responsive::ArgumentsDefinitionHelper::InvalidArgumentValueError if value if not valid.
      def validate_value(value, variant = nil)
        return if valid_value?(value, variant)

        base_message = invalid_value_base_message(value)

        unless @type.nil?
          raise ArgumentsDefinitionHelper::InvalidArgumentValueError, <<~MSG
            #{base_message}
            Value has to be of type #{@type.inspect}.
          MSG
        end

        allowed_values = @allowed_values || []
        responsive_variant = @responsive_variants[variant] unless @responsive_variants.nil?

        if responsive_variant
          variant_allowed_values = responsive_variant&.allowed_values || []
          all_allowed_values = allowed_values.concat(variant_allowed_values)

          raise ArgumentsDefinitionHelper::InvalidArgumentValueError, <<~MSG
            #{base_message}
            Value for responsive variant "#{variant.inspect}" has to be one of #{all_allowed_values.inspect}.
          MSG
        end

        raise ArgumentsDefinitionHelper::InvalidArgumentValueError, <<~MSG
          #{base_message}
          Value has to be one of #{allowed_values.inspect}.
        MSG
      end

      # Checks if the entire argument is deprecated.
      #
      # @return [Boolean]
      def deprecated?
        !@deprecation.nil? && @deprecation.argument_deprecated?
      end

      # Checks if a given value is deprecated.
      #
      # @pram value [Any] the value to check for deprecation.
      def deprecated_value?(value)
        return false if @deprecation.nil?

        @deprecation.deprecated_value?(value)
      end

      # Gets the deprecation message for the given value
      #
      # @return [String]
      def deprecation_warn_message(value)
        return "" if @deprecation.nil?

        @deprecation.deprecation_warn_message(value)
      end

      # Helper method to retrieve a base error message when raising errors for invalid argument values.
      # Can be used to custom validation rules
      #
      # # @return [String]
      def invalid_value_base_message(value)
        "Invalid value for \"#{@name.inspect}\": provided \"#{value.inspect}\"(#{value.class.inspect})."
      end

      private

      def error_base_message
        "Invalid argument definition for \"#{@name.inspect}\"."
      end

      def validate_params_structure(params = nil)
        params = @params if params.nil?

        params.each_key do |key|
          next if ALLOWED_PARAMS.include? key

          raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
            Invalid argument definition param:
            Param `#{key.inspect}` is not a valid definition parameters.
            Allowed parameters: `#{ALLOWED_PARAMS.inspect}`
          MSG
        end
      end

      # Validates the argument definition when developing a responsive component.
      # Triggers automatically on instantiation when not in production
      def validate_definition
        if !@allowed_values.nil? && !@type.nil?
          raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
            #{error_base_message}
            Definition cannot contain both :type and :allowed_values.
          MSG
        end

        unless valid_responsive_option?
          raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
            #{error_base_message}
            Invalid :responsive value: #{responsive.inspect}. Allowed values for :responsive are: #{RESPONSIVE_OPTIONS.inspect}.
          MSG
        end

        if responsive? :no
          RESPONSIVE_VARIANTS.each do |variant|
            next unless @params.key? variant

            raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
              #{error_base_message}
              Arguments not responsive can't have responsive variants definition, but #{variant.inspect} found.
              To fix this, change :responsive to :transitional or :yes
            MSG
          end
        else
          if @type.nil?
            # responsive definition cannot contain :allowed_values already part or the main definition of @allowed_values
            @responsive_variants.each do |variant_name, responsive_variant|
              next if responsive_variant.allowed_values.nil?

              repeated_values = @allowed_values & responsive_variant.allowed_values
              next if repeated_values.empty?

              raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
                #{error_base_message}
                Responsive variant can't have @allowed_values existent in @allowed_values of the argument definition.
                To fix, remove #{repeated_values.inspect} from #{variant_name.inspect} responsive variant.
              MSG
            end
          elsif @responsive_variants.values.any? { |rv| !rv.allowed_values.nil? }
            # responsive definition cannot contain :allowed_values if the main definition is @type
            raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
              #{error_base_message}
              Responsive variant can't use @allowed_values when main definition is @type based.
            MSG
          end

          responsive_variants_with_default = []
          @responsive_variants.each_value do |responsive_variant|
            responsive_variant.validate_definition
            next unless responsive_variant.defined_default?

            responsive_variants_with_default << responsive_variant.variant_name
            if responsive?(:yes) && defined_default?
              raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
                #{error_base_message}
                A responsive-only type (responsive: :yes) cannot contain a variant :default at the same
                time it defines an overall :default. Remove the base :default, or remove all variants :default
              MSG
            end

            if @type.nil?
              validate_default_value_by_allowed_values(
                (@allowed_values || []) + (responsive_variant.allowed_values || []),
                responsive_variant.default
              )
            else
              validate_default_value_by_type(responsive_variant.default)
            end
          end

          unless responsive_variants_with_default.empty?
            RESPONSIVE_VARIANTS_MAP.each do |key, config|
              next if config[:optional]
              next if responsive_variants_with_default.include? key

              raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
                #{error_base_message}
                If a responsive argument defines a default in at least one responsive variant,
                all required responsive variants have to also define a default value.
                Variant with default: #{responsive_variants_with_default.inspect}
                Variant missing default: #{REQUIRED_RESPONSIVE_VARIANTS - responsive_variants_with_default}
              MSG
            end
          end
        end

        unless @deprecation.nil?
          if !@deprecation.type.nil? && @deprecation.type == @type
            raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
              #{error_base_message}
              Deprecated type can't be the same as argument type
            MSG
          end

          unless @deprecation.deprecated_values.nil?
            current_allowed_values = (@allowed_values || []) + (@responsive_variants&.values&.map(&:allowed_values)&.flatten || [])
            repeated_attrs = current_allowed_values & @deprecation.deprecated_values
            unless repeated_attrs.empty?
              raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
                #{error_base_message}
                Deprecated values #{@deprecation.deprecated_values.inspect} can't be part of the allowed_values of the argument: #{repeated_attrs.inspect}
              MSG
            end
          end
        end

        return unless defined_default?

        if @type.nil?
          validate_default_value_by_allowed_values(@allowed_values, @default)
        else
          validate_default_value_by_type(@default)
        end
      end

      def validate_default_value_by_allowed_values(allowed_values, value)
        return if allowed_values.nil? || allowed_values.any?(value)

        raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
          #{error_base_message}
          Default value #{value.inspect}(#{value.class.inspect}) has to be one of #{allowed_values.inspect}.
        MSG
      end

      def validate_default_value_by_type(value)
        return if value.is_a? @type

        raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
          #{error_base_message}
          Default value #{value.inspect}(#{value.class.inspect}) has to be of type #{@type.inspect}.
        MSG
      end

      def valid_responsive_option?
        RESPONSIVE_OPTIONS.include? @responsive
      end

      def create_deprecation(params)
        return nil unless params.key? :deprecation

        deprecation_params = {
          argument_definition: self,
          **params[:deprecation]
        }
        ArgumentDeprecation.new(**deprecation_params)
      end
    end

    # Internal class only to be used as part of a responsive argument definition
    class ResponsiveVariantArgumentDefinition < ArgumentDefinition
      DENY_RESPONSIVE_VARIANT_ATTRIBUTES = [:type, :responsive, :deprecation].freeze

      attr_reader :variant_name

      def initialize(params = {})
        params[:allowed_values] = params[:additional_allowed_values]
        params.delete(:additional_allowed_values)

        @variant_name = params[:variant_name]
        super(params)
      end

      def validate_definition
        invalid_attrs = [*RESPONSIVE_VARIANTS, *DENY_RESPONSIVE_VARIANT_ATTRIBUTES] & @params.keys
        return if invalid_attrs.empty?

        raise ArgumentsDefinitionHelper::InvalidArgumentDefinitionError, <<~MSG
          #{error_base_message}
          Responsive variants cannot have the following attributes as part of their definitions: #{DENY_RESPONSIVE_VARIANT_ATTRIBUTES.inspect}
          Invalid attributes found for #{@variant_name.inspect}: #{invalid_attrs.inspect}
        MSG
      end
    end

    # Handles deprecation of arguments or values as part of the responsive argument definition
    class ArgumentDeprecation
      # @argument: deprecates the whole argument. Defaults to true if @deprecated_values and @type are not set
      # @deprecated_values: array of deprecated values that cannot be used moving forward
      # @type: if a type was changed into another and the old type is still supported. This should be the old supported type
      # @warn_message: explanations for the deprecation on top of what is presented by default
      attr_reader :deprecated_values, :type, :warn_message

      def initialize(argument_definition: nil, argument: false, deprecated_values: nil, type: nil, warn_message: "")
        @argument_definition = argument_definition
        @deprecated_values = deprecated_values
        @type = type

        @argument = deprecated_values.nil? && type.nil? ? true : argument

        @warn_message = warn_message
      end

      def deprecation_warn(value_given = nil)
        return unless ArgumentsDefinitionHelper.production_env? || silent_deprecation?

        deprecation_message = deprecation_warn_message(value_given)
        ActiveSupport::Deprecation.warn(deprecation_message)
      end

      def deprecation_warn_message(value_given = nil)
        return "" unless deprecated_value? value_given

        argument_name = @argument_definition.name.inspect
        msg = if @argument
                "Argument #{argument_name} is deprecated."
              elsif !@type.nil?
                "Type #{@type.inspect} is deprecated for argument #{argument_name}. Use type #{@argument_definition.type.inspect} instead. Value provided: #{value_given.inspect}(#{value_given.class.inspect})"
              else
                "#{@deprecated_values.inspect} #{@deprecated_values.length > 1 ? 'are' : 'is'} deprecated for argument #{argument_name}. Value provided: #{value_given.inspect}"
              end
        msg = "DEPRECATION: #{msg}"
        msg += "\n             #{@warn_message}" unless @warn_message.empty?

        msg
      end

      def argument_deprecated?
        @argument
      end

      def deprecated_value?(value)
        # argument deprecation means that all values are deprecated
        return true if @argument

        @type.nil? ? @deprecated_values.any?(value) : value.is_a?(@type)
      end

      def silent_deprecation?
        Rails.application.config.primer_view_components.silence_deprecations
      end
    end
  end
end
