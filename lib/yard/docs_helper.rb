# frozen_string_literal: true

module YARD
  # Helper methods to use for yard documentation
  module DocsHelper
    def one_of(enumerable, lower: false, sort: true)
      # Sort the array if requested
      if sort
        compare = ->(a, b) { a.class == b.class ? a <=> b : a.class.to_s <=> b.class.to_s }
        enumerable = enumerable.sort { |a, b| compare.call(a, b) }
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

      "#{prefix} #{values.to_sentence(last_word_connector: ', or ')}."
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
      short_name = component.name.gsub(/Primer|::|Alpha|Beta|Component/, "")
      "[#{short_name}](/components/#{short_name.downcase})"
    end

    def link_to_octicons
      "[Octicon](https://primer.style/octicons/)"
    end

    def link_to_heading_practices
      "[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)"
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
