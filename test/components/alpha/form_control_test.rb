# frozen_string_literal: true

require "components/test_helper"

module Primer
  module Alpha
    class FormControlTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_basic_structure
        render_preview(:playground)

        assert_selector(".FormControl-label", text: "Best character")
        assert_selector("segmented-control")
        assert_selector(".FormControl-inlineValidation", text: "Something went wrong") do
          assert_selector(".octicon-alert-fill")
        end
        assert_selector(".FormControl-caption", text: "May the force be with you")
      end

      def test_described_by_ids
        render_preview(:playground)

        caption_id = page.find_css(".FormControl-caption")[0].attributes["id"].value
        validation_id = page.find_css(".FormControl-inlineValidation")[0].attributes["id"].value
        described_by_ids = page.find_css("segmented-control ul")[0].attributes["aria-describedby"].value.split

        assert_includes(described_by_ids, caption_id)
        assert_includes(described_by_ids, validation_id)
      end

      def test_required
        render_preview(:required)

        assert_selector(".FormControl-label", text: "Best character") do
          assert_selector("[aria-hidden=true]", text: "*")
        end
      end

      def test_visually_hidden_label
        render_preview(:with_visually_hidden_label)

        assert_selector(".FormControl-label.sr-only", text: "Best character")
      end
    end
  end
end
