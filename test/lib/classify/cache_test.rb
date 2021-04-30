# frozen_string_literal: true

require "test_helper"

class PrimerClassifyCacheTest < Minitest::Test
  def test_clear_clears_the_cache
    Primer::Classify::Cache.clear!

    assert_empty Primer::Classify::Cache::LOOKUP
  ensure
    Primer::Classify::Cache.preload!
  end

  def test_does_not_generate_primer_css_classes_that_do_not_exist
    Primer::Classify::Cache.preload!

    classes_from_classify_cache =
      Primer::Classify::Cache::LOOKUP
      .values
      .flat_map { |k| k.values }
      .flat_map { |k| k.values }
      .map { |k| ".#{k}" }
      .uniq

    css_data =
      JSON.parse(
        File.read(
          File.join(
            __FILE__.split("test")[0], "/node_modules/@primer/css/dist/stats/primer.json"
          )
        )
      )

    # TODO: remove these
    allowed_missing_classes_for_now = [
      ".m-sm-auto",
      ".p-sm-responsive",
      ".m-md-auto",
      ".p-md-responsive",
      ".m-lg-auto",
      ".p-lg-responsive",
      ".m-xl-auto",
      ".p-xl-responsive"
    ]

    assert_empty(classes_from_classify_cache - css_data["selectors"]["values"] - allowed_missing_classes_for_now)
  end
end
