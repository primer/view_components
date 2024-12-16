# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectDangerConfirmationDialogTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::DangerConfirmationDialog.new) do |dialog|
      dialog.with_confirmation_message do |message|
        message.with_heading(tag: :h2) { "Danger" }
      end
      dialog.with_confirmation_checkbox { "I confirm this deletion" }
    end

    assert_selector("dialog.DangerConfirmationDialog") do
      assert_selector(".Overlay-body h2", text: "Danger")
      assert_selector(".octicon-alert.blankslate-icon")
      assert_selector(".FormControl-checkbox + * > .FormControl-label", text: "I confirm this deletion")
      assert_selector(".Overlay-footer .Button", count: 2)
    end
  end

  def test_does_not_render_if_no_confirmation_message_provided
    error = assert_raises(ArgumentError) do
      render_inline(Primer::OpenProject::DangerConfirmationDialog.new) do |dialog|
        dialog.with_confirmation_checkbox { "I confirm this deletion" }
      end
    end

    assert_equal "DangerConfirmationDialog requires a confirmation_message", error.message
  end

  def test_does_not_render_if_no_confirmation_checkbox_provided
    error = assert_raises(ArgumentError) do
      render_inline(Primer::OpenProject::DangerConfirmationDialog.new) do |dialog|
        dialog.with_confirmation_message do |message|
          message.with_heading(tag: :h2) { "Danger" }
        end
      end
    end

    assert_equal "DangerConfirmationDialog requires a confirmation_checkbox", error.message
  end

  def test_renders_without_form_by_default
    render_inline(Primer::OpenProject::DangerConfirmationDialog.new) do |dialog|
      dialog.with_confirmation_message do |message|
        message.with_heading(tag: :h2) { "Danger" }
      end
      dialog.with_confirmation_checkbox { "I confirm this deletion" }
    end

    assert_selector("dialog.DangerConfirmationDialog") do
      refute_selector("form")
    end
  end

  def test_renders_form_with_form_arguments
    render_inline(Primer::OpenProject::DangerConfirmationDialog.new(
      form_arguments: { action: "/my-action", method: :delete }
    )) do |dialog|
      dialog.with_confirmation_message do |message|
        message.with_heading(tag: :h2) { "Danger" }
      end
      dialog.with_confirmation_checkbox { "I confirm this deletion" }
    end

    assert_selector("dialog.DangerConfirmationDialog") do
      assert_selector("form[action='/my-action'][method='delete']")
    end
  end

  def test_renders_provided_id
    render_inline(Primer::OpenProject::DangerConfirmationDialog.new(id: "danger-dialog")) do |dialog|
      dialog.with_confirmation_message do |message|
        message.with_heading(tag: :h2) { "Danger" }
      end
      dialog.with_confirmation_checkbox { "I confirm this deletion" }
    end

    assert_selector("dialog#danger-dialog.DangerConfirmationDialog") do
      assert_selector("input#danger-dialog-checkbox")
      assert_selector("label[for='danger-dialog-checkbox']", text: "I confirm this deletion")
    end
  end

  def test_renders_additional_details
    render_inline(Primer::OpenProject::DangerConfirmationDialog.new) do |dialog|
      dialog.with_confirmation_message do |message|
        message.with_heading(tag: :h2) { "Danger" }
      end
      dialog.with_additional_details { "Additional important information." }
      dialog.with_confirmation_checkbox { "I confirm this deletion" }
    end

    assert_selector("dialog.DangerConfirmationDialog") do
      assert_selector(".DangerConfirmationDialog-additionalDetails", text: "Additional important information.")
    end
  end
end
