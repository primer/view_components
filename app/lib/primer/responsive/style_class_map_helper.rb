# frozen_string_literal: true

module Primer
  module Responsive
    # style map helper to generate responsive variants of class map and to handle creation of classes based on responsive values
    module StyleClassMapHelper
      RESPONSIVE_VARIANTS_MAP = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS_MAP
      RESPONSIVE_VARIANTS = Primer::Responsive::ResponsiveConfig::RESPONSIVE_VARIANTS

      private_constant :RESPONSIVE_VARIANTS_MAP, :RESPONSIVE_VARIANTS

      # Adds responsive variants to the base map modifying the base classes to the respective variant name
      #
      # @param map [Hash] a hash composed of argument names mapping each possible value to a css class (string)
      # @param remove_initial [boolean] flag to remove the initial class map structure once the variants are added
      def add_responsive_variants!(map, remove_initial: false)
        RESPONSIVE_VARIANTS_MAP.each do |responsive_variant, config|
          add_responsive_variant!(map, responsive_variant, config[:style_class_modifier], RESPONSIVE_VARIANTS)
        end

        if remove_initial
          keys_to_be_removed = []
          map.each_key do |argument_name|
            next if RESPONSIVE_VARIANTS_MAP.key? argument_name

            keys_to_be_removed.push(argument_name)
          end
          map.except!(*keys_to_be_removed)
        end
        map
      end

      # Derive an applied map from the current arguments values.
      # NOTE: This method doesn't take into consideration any argument definition, so to get the default classes,
      #       make sure to fill the values with defaults before calling this method.
      #
      # @param map [Hash] a style class map with classes value-dependent
      # @param argument_values [Hash] a hash with the current argument values of the component
      def apply_values_to_style_map(map, argument_values)
        applied_map = {}
        argument_values.each do |argument_name, value|
          next if RESPONSIVE_VARIANTS_MAP.key? argument_name
          next unless map.key? argument_name

          applied_map[argument_name] = get_style_from_value(map[argument_name], value)
        end

        if responsive_variants?(map)
          applied_responsive_map = apply_responsive_map(map, argument_values)
          applied_map.merge! applied_responsive_map
        end

        applied_map
      end

      # ==== [ the following functions should be treated as private to this module ] ====
      def add_responsive_variant!(map, responsive_variant, modifier, arguments_to_ignore = [])
        map[responsive_variant] = {} unless map.key?(responsive_variant)

        map_variant = map[responsive_variant]
        map.each do |argument_name, value|
          next if arguments_to_ignore.include?(argument_name)
          next if argument_name == responsive_variant

          responsive_argument_map = value.is_a?(Hash) ? build_responsive_variant(value, modifier) : derive_class_variant(value, modifier)
          map_variant[argument_name] = responsive_argument_map
        end
      end

      def build_responsive_variant(map, modifier)
        responsive_map = {}
        map.each do |key, value|
          responsive_map[key] = value.is_a?(Hash) ? build_responsive_variant(value, modifier) : derive_class_variant(value, modifier)
        end
        responsive_map
      end

      def derive_class_variant(class_name, modifier)
        "#{class_name}-#{modifier}"
      end

      def apply_responsive_map(map, argument_values)
        applied_map = {}

        RESPONSIVE_VARIANTS_MAP.each do |responsive_variant, variant_config|
          next unless map.key? responsive_variant

          responsive_map = map[responsive_variant]
          responsive_map.each do |argument_name, argument_map|
            if argument_values.key?(responsive_variant) && argument_values[responsive_variant].key?(argument_name)
              value = argument_values[responsive_variant][argument_name]
            elsif argument_values.key? argument_name
              next if variant_config[:optional]

              value = argument_values[argument_name]
            else
              next
            end

            applied_style = get_style_from_value(argument_map, value)

            applied_map[argument_name] = if applied_map.key? argument_name
                                           merge_class_styles(applied_map[argument_name], applied_style)
                                         else
                                           applied_map[argument_name] = applied_style
                                         end
          end
        end

        applied_map
      end

      def merge_class_styles(base_applied_styles, new_applied_styles)
        return "#{base_applied_styles} #{new_applied_styles}" if base_applied_styles.is_a?(String) && new_applied_styles.is_a?(String)

        return new_applied_styles unless base_applied_styles.is_a?(Hash) && new_applied_styles.is_a?(Hash)

        base_applied_styles.merge(new_applied_styles) do |_, base_value, new_value|
          merge_class_styles(base_value, new_value)
        end
      end

      # Matches the style map with the given value and returns the mapped class
      #
      # @param map [Hash] a map of the possible values of a argument and its respective css class
      # @param value [Object] the value of the argument. If it's a hash, the style is going to try to create a recursive applied map
      def get_style_from_value(map, value)
        style_class = nil

        case value
        when Symbol, String, Numeric
          style_class = map[value] if map.key? value
        when true
          style_class = map if map.is_a? String
        when Hash
          style_class = {}
          value.each do |argument_name, inner_value|
            next unless map.key?(argument_name)

            style_class[argument_name] = get_style_from_value(map[argument_name], inner_value)
          end
        end

        style_class
      end

      # Checks if a hash has any responsive variants
      def responsive_variants?(hash)
        is_responsive = false
        RESPONSIVE_VARIANTS.each do |variant|
          next unless hash.key? variant

          is_responsive = true
          break
        end

        is_responsive
      end
    end
  end
end
