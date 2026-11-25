# frozen_string_literal: true

require "components/test_helper"

class PreviewTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def setup
    @previews = Dir.glob("previews/**/*_preview.rb").reject { |f| f.end_with?("forms_preview.rb") }
  end

  def test_previews_exist
    refute_empty(@previews)
  end

  def test_previews_have_default_preview
    missing_previews = []
    @previews.each do |preview|
      contents = File.read(preview)
      missing_previews << preview unless contents.include?("def default")
    end
    assert(missing_previews.empty?, "The following previews are missing a default preview method: \n\n - #{missing_previews.join("\n - ")}\n")
  end

  def test_previews_have_playground_preview
    missing_previews = []
    @previews.each do |preview|
      contents = File.read(preview)
      missing_previews << preview unless contents.include?("def playground")
    end
    assert(missing_previews.empty?, "The following previews are missing a playground preview method: \n\n - #{missing_previews.join("\n - ")}")
  end

  def test_preview_labels_are_sentence_case
    lowercase_labels = []
    @previews.each do |preview|
      contents = File.read(preview).split("\n")
      contents.each_with_index do |line, index|
        lowercase_labels << "#{preview}:#{index + 1}: #{line}" if /# @label [a-z]/.match?(line)
      end
    end
    assert(lowercase_labels.empty?, "Preview labels should use sentence case: \n\n - #{lowercase_labels.join("\n - ")}")
  end

  def test_checkbox_options_preview_labels_reference_their_checkbox
    preview = Lookbook.previews.find { |entry| entry.lookup_path == "primer/alpha/check_box" }
    options = preview.scenarios.find { |scenario| scenario.lookup_path == "primer/alpha/check_box/options" }

    # Render the grouped examples together so duplicate IDs affect label lookup.
    html = options.scenarios.map do |scenario|
      render_preview(scenario.name, from: preview.preview_class).to_html
    end.join
    document = Nokogiri::HTML.fragment(html)
    checkboxes = document.css("input[type='checkbox']")

    assert_equal 4, checkboxes.length
    refute_nil document.at_css("input[type='checkbox'][checked]")

    checkboxes.each do |checkbox|
      label = checkbox.parent.at_css("label")

      refute_nil label
      assert_equal "Jean-Luc Picard", label.text.strip
      assert_equal checkbox, document.at_css(%([id="#{label["for"]}"])),
                   "The #{checkbox["id"]} label must reference its own checkbox"
    end
  end
end
