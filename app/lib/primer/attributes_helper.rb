# frozen_string_literal: true

module Primer
  # :nodoc:
  module AttributesHelper
    PLURAL_ARIA_ATTRIBUTES = %i[describedby labelledby].freeze
    PLURAL_DATA_ATTRIBUTES = %i[target targets].freeze

    def aria(val, system_arguments)
      system_arguments[:"aria-#{val}"] || system_arguments.dig(:aria, val.to_sym)
    end

    def data(val, system_arguments)
      system_arguments[:"data-#{val}"] || system_arguments.dig(:data, val.to_sym)
    end

    # Merges hashes that contain "aria-*" keys and nested aria: hashes. Removes keys from
    # each hash and returns them in the new hash.
    #
    # Eg. merge_aria({ "aria-disabled": "true" }, { aria: { invalid: "true" } })
    #     => { disabled: "true", invalid: "true" }
    #
    # Certain aria attributes can contain multiple values separated by spaces. merge_aria
    # will combine these plural attributes into a composite string.
    #
    # Eg. merge_aria({ "aria-labelledby": "foo" }, { aria: { labelledby: "bar" } })
    #     => { labelledby: "foo bar" }
    #
    # It's designed to be used to normalize and merge aria information from system_arguments
    # hashes. Consider using this pattern in component initializers:
    #
    # @system_arguments[:aria] = merge_aria(
    #   @system_arguments,
    #   { aria: { labelled_by: id } }
    # )
    def merge_aria(*hashes)
      merge_prefixed_attribute_hashes(
        *hashes, prefix: :aria, plural_keys: PLURAL_ARIA_ATTRIBUTES
      )
    end

    # Merges hashes that contain "data-*" keys and nested data: hashes. Removes keys from
    # each hash and returns them in the new hash.
    #
    # Eg. merge_data({ "data-foo": "true" }, { data: { bar: "true" } })
    #     => { foo: "true", bar: "true" }
    #
    # Certain data attributes can contain multiple values separated by spaces. merge_data
    # will combine these plural attributes into a composite string.
    #
    # Eg. merge_data({ "data-target": "foo" }, { data: { target: "bar" } })
    #     => { target: "foo bar" }
    #
    # It's designed to be used to normalize and merge data information from system_arguments
    # hashes. Consider using this pattern in component initializers:
    #
    # @system_arguments[:data] = merge_aria(
    #   @system_arguments,
    #   { data: { foo: "bar" } }
    # )
    def merge_data(*hashes)
      merge_prefixed_attribute_hashes(
        *hashes, prefix: :data, plural_keys: PLURAL_DATA_ATTRIBUTES
      )
    end

    def merge_prefixed_attribute_hashes(*hashes, prefix:, plural_keys:)
      {}.tap do |result|
        hashes.each do |hash|
          next unless hash

          prefix_hash = hash.delete(prefix) || {}

          prefix_hash.each_pair do |key, val|
            result[key] =
              if plural_keys.include?(key)
                [*(result[key] || "").split, val].join(" ").strip
              else
                val
              end
          end

          hash.delete_if do |key, val|
            key_s = key.to_s

            if key.start_with?("#{prefix}-")
              bare_key = key_s.sub("#{prefix}-", "").to_sym

              result[bare_key] =
                if plural_keys.include?(bare_key)
                  [*(result[bare_key] || "").split, val].join(" ").strip
                else
                  val
                end

              true
            else
              false
            end
          end
        end
      end
    end
  end
end
