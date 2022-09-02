# frozen_string_literal: true

require "test_helper"

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
end
