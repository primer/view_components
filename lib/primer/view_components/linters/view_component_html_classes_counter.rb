# frozen_string_literal: true

require_relative "base_linter"

# Load all the other linters so we can filter out their restricted
# CLASSES—they will be responsible for complaining about the use of
# those HTML classes.
Dir[File.join(__dir__, "*.rb")].sort.each do |file|
  require file unless file == __FILE__
end

module ERBLint
  module Linters
    # Counts the number of times a class reserved for ViewComponents is used
    class ViewComponentHtmlClassesCounter < BaseLinter
      CLASSES = (
        JSON.parse(
          File.read(
            File.join(__dir__, "..", "..", "..", "..", "static", "classes.json")
          )
        ) - BaseLinter.subclasses.reduce([]) do |html_classes, klass|
          html_classes.concat(klass.const_get(:CLASSES))
        end
      ).freeze

      TAGS = nil
      MESSAGE = "Primer ViewComponents defines some HTML classes with associated styles that should not be used outside those components. (These classes might have their styles changed or even disappear in the future.) Instead of using this class directly, please use its component if appropriate or define the styles you need some other way."
    end
  end
end
