# frozen_string_literal: true

require "lib/test_helper"

class CssCoverageTest < Minitest::Test
  def setup
    @classes_from_utilities =
      Primer::Classify::Utilities::UTILITIES
      .flat_map { |_, values| values.flat_map { |_, v| v } }
      .map { |k| ".#{k}" }
      .uniq

    @allowed_missing_classes_for_now = [
      # used to showcase custom classes in component docs
      ".custom-class",
      ".f00",
      "."
    ]

    @allowed_missing_classes_for_now += custom_added_classes

    @css_data =
      JSON.parse(
        File.read(
          File.join(
            __FILE__.split("test")[0], "/node_modules/@primer/css/dist/stats/primer.json"
          )
        )
      )["selectors"]["values"]

    # Cleanup the data to make sure it's only one selector per item
    @css_data = @css_data
                .flat_map { |c| c.gsub(/(\w)\./, '\1 .').split(/[\s:\[+>]+/) }
                .select { |c| c.starts_with?(".") }
                .uniq
  end

  def test_classify_does_not_generate_primer_css_classes_that_do_not_exist
    assert_empty(@classes_from_utilities - @css_data - @allowed_missing_classes_for_now)
  end

  # Custom added classes which are not part of PrimerCss
  def custom_added_classes
    %w[
      .d-grid .d-sm-grid .d-md-grid .d-lg-grid .d-xl-grid
      .flex-justify-self-start .flex-sm-justify-self-start .flex-md-justify-self-start .flex-lg-justify-self-start .flex-xl-justify-self-start
      .flex-justify-self-end .flex-sm-justify-self-end .flex-md-justify-self-end .flex-lg-justify-self-end .flex-xl-justify-self-end
      .flex-justify-self-center .flex-sm-justify-self-center .flex-md-justify-self-center .flex-lg-justify-self-center .flex-xl-justify-self-center
      .flex-0 .flex-sm-0 .flex-md-0 .flex-lg-0 .flex-xl-0
      .flex-grow-1 .flex-sm-grow-1 .flex-md-grow-1 .flex-lg-grow-1 .flex-xl-grow-1
      .flex-shrink-1 .flex-sm-shrink-1 .flex-md-shrink-1 .flex-lg-shrink-1 .flex-xl-shrink-1
    ]
  end
end
