# frozen_string_literal: true

# :nocov:

module Primer
  module YARD
    # Helper methods to use for yard documentation
    module DocsHelper
      def one_of(enumerable, lower: false, sort: true)
        # Sort the array if requested
        if sort
          enumerable = enumerable.sort do |a, b|
            a.instance_of?(b.class) ? a <=> b : a.class.to_s <=> b.class.to_s
          end
        end

        values =
          case enumerable
          when Hash
            enumerable.map do |key, value|
              "#{pretty_value(key)} (#{pretty_value(value)})"
            end
          else
            enumerable.map do |key|
              pretty_value(key)
            end
          end

        prefix = "One of"
        prefix = prefix.downcase if lower

        "#{prefix} #{values.to_sentence(two_words_connector: ' or ', last_word_connector: ', or ')}."
      end

      def link_to_accessibility
        "[Accessibility](#accessibility)"
      end

      def link_to_system_arguments_docs
        "[System arguments](/system-arguments)"
      end

      def link_to_typography_docs
        "[Typography](/system-arguments#typography)"
      end

      def link_to_component(component)
        status_module, short_name, class_name = status_module_and_short_name(component)
        status_path = status_module.nil? ? "" : "#{status_module}/"

        "[#{class_name}](/components/#{status_path}#{short_name.downcase})"
      end

      def link_to_octicons
        "[Octicon](https://primer.style/octicons/)"
      end

      def link_to_heading_practices
        "[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)"
      end

      def status_module_and_short_name(component)
        name_with_status = component.name.gsub(/Primer::|Component/, "")

        m = name_with_status.match(/(?<status>Beta|Alpha|Deprecated)?(?<_colons>::)?(?<name>.*)/)
        [m[:status]&.downcase, m[:name].gsub("::", ""), m[:name]]
      end

      def pretty_value(val)
        case val
        when nil
          "`nil`"
        when Symbol
          "`:#{val}`"
        else
          "`#{val}`"
        end
      end
    end
  end
end
