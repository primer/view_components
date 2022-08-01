# frozen_string_literal: true

require "ripper"

module Primer
  module Forms
    # :nodoc:
    class BufferRewriter < Ripper
      class << self
        def rewrite(code)
          parser = new(code, "(code)", 0)
          parser.parse

          line_offsets = calc_line_offsets(code)

          code.dup.tap do |result|
            parser.var_refs.reverse_each do |lineno, stop|
              line_offset = line_offsets[lineno]
              start = (stop - "@output_buffer".length) + line_offset
              stop += line_offset
              result[start...stop] = "output_buffer"
            end
          end
        end

        private

        def calc_line_offsets(code)
          idx = -1

          [0].tap do |offsets|
            while (idx = code.index(/\r?\n/, idx + 1))
              offsets << Regexp.last_match.end(0)
            end
          end
        end
      end

      def on_var_ref(var)
        return unless var == "@output_buffer"

        var_refs << [lineno, column - 1]
      end

      def var_refs
        @var_refs ||= []
      end
    end
  end
end
