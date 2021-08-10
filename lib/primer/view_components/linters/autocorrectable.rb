# frozen_string_literal: true

require_relative "argument_mappers/conversion_error"

module ERBLint
  module Linters
    # Helper methods for autocorrectable ERB linters.
    module Autocorrectable
      def map_arguments(tag)
        self.class::ARGUMENT_MAPPER.new(tag).to_s
      rescue ArgumentMappers::ConversionError
        nil
      end

      def correction(args)
        return nil if args.nil?

        correction = "<%= render #{self.class::COMPONENT}.new"
        correction += "(#{args})" if args.present?
        "#{correction} do %>"
      end

      def message(args, processed_source)
        return self.class::MESSAGE if args.nil?

        "#{self.class::MESSAGE}\nTry using:\n\n#{correction(args)}\n\nYou can also run erblint in autocorrect mode:\n\nbundle exec erblint -a #{processed_source.filename}\n"
      end
    end
  end
end
