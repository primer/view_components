# frozen_string_literal: true

require "test_helper"

class CssCoverageTest < Minitest::Test
  def setup
    Primer::Classify::Cache.preload!

    @classes_from_classify_cache =
      Primer::Classify::Cache::LOOKUP
      .values
      .flat_map(&:values)
      .flat_map(&:values)
      .map { |k| ".#{k}" }
      .uniq

    @classes_from_docs_build =
      YAML.safe_load(
        File.read(
          File.join(
            __FILE__.split("test")[0], "/static/classes.yml"
          )
        )
      )

    # TODO: remove these
    @allowed_missing_classes_for_now = [
      ".m-sm-auto",
      ".p-sm-responsive",
      ".m-md-auto",
      ".p-md-responsive",
      ".m-lg-auto",
      ".p-lg-responsive",
      ".m-xl-auto",
      ".p-xl-responsive"
    ]

    @css_data =
      JSON.parse(
        File.read(
          File.join(
            __FILE__.split("test")[0], "/node_modules/@primer/css/dist/stats/primer.json"
          )
        )
      )["selectors"]["values"].flat_map { _1.gsub(/(\w)\./, '\1 .').split(/[\s:\[\+>]+/) }.reject { !_1.starts_with?(".") }.uniq
  end

  def test_does_not_generate_primer_css_classes_that_do_not_exist
    assert_empty(@classes_from_classify_cache - @css_data - @allowed_missing_classes_for_now)
  end
end
