# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectFeedbackDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Success message")) do |dialog|
      dialog.with_feedback_message do |message|
        message.with_heading(tag: :h2) { "Success" }
      end
    end

    assert_selector("dialog.FeedbackDialog") do
      assert_selector(".Overlay-body h2", text: "Success")
      assert_selector(".octicon-check-circle.blankslate-icon")
      assert_selector(".Overlay-footer .Button")
    end
  end

  def test_renders_aria_describedby
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Success message")) do |dialog|
      dialog.with_feedback_message do |message|
        message.with_heading(tag: :h2) { "Success" }
      end
    end

    dialog_labelledby_id = page.find_css("dialog").first.attributes["aria-describedby"].value
    feedback_message_id = page.find_css(".FeedbackMessage").first.attributes["id"].value
    assert_equal dialog_labelledby_id, feedback_message_id
  end

  def test_renders_additional_details
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Success message")) do |dialog|
      dialog.with_feedback_message do |message|
        message.with_heading(tag: :h2) { "Success" }
      end
      dialog.with_additional_details { "Some additional details" }
    end

    assert_selector("dialog.FeedbackDialog") do
      assert_selector(".FeedbackDialog-additionalDetails", text: "Some additional details")
    end
  end

  def test_renders_custom_footer
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Success message")) do |dialog|
      dialog.with_feedback_message do |message|
        message.with_heading(tag: :h2) { "Success" }
      end
      dialog.with_footer { "My custom footer" }
    end

    assert_selector("dialog.FeedbackDialog") do
      assert_selector(".Overlay-footer", text: "My custom footer")
    end
  end

  def test_renders_custom_icon
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Error message")) do |dialog|
      dialog.with_feedback_message(icon_arguments: { icon: :"x-circle", color: :danger }) do |message|
        message.with_heading(tag: :h2) { "Ups, something went wrong" }
        message.with_description { "Please try again or contact your administrator if the issue persists." }
      end
    end

    assert_selector("dialog.FeedbackDialog") do
      assert_selector(".Overlay-body h2", text: "Ups, something went wrong")
      assert_selector(".Overlay-body p", text: "Please try again or contact your administrator if the issue persists.")
      assert_selector(".octicon-x-circle.blankslate-icon")
    end
  end

  def test_renders_loading_spinner
    render_inline(Primer::OpenProject::FeedbackDialog.new(title: "Loading...")) do |dialog|
      dialog.with_feedback_message(loading: true) do |message|
        message.with_heading(tag: :h2) { "Ups, something went wrong" }
      end
    end

    assert_selector("dialog.FeedbackDialog") do
      assert_selector(".Overlay-body h2", text: "Ups, something went wrong")
      assert_selector("svg.blankslate-image")
    end
  end
end
