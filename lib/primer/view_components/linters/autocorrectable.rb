# frozen_string_literal: true

require_relative "argument_mappers/conversion_error"

module ERBLint
  module Linters
    # Provides the autocorrection functionality for the linter. Once included, you should define the following constants:
    # * `ARGUMENT_MAPPER` - required - The class responsible for transforming classes and attributes into arguments for the component.
    # * `COMPONENT` - required - The component name for the linter. It will be used to generate the correction.
    module Autocorrectable
      def map_arguments(tag, _tag_tree)
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

        "#{self.class::MESSAGE}\nTry using:\n\n#{correction(args)}\n\nYou can also run erb_lint in autocorrect mode:\n\nbundle exec erb_lint -a #{processed_source.filename}\n"
      end
    end
  end
end
