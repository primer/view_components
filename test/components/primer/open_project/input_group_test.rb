# frozen_string_literal: true

require "components/test_helper"

class PrimerOpenProjectInputGroupTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::OpenProject::InputGroup.new) do |menu|
      menu.with_text_input(name: "a name", label: "My input group", value: "Copyable value")
      menu.with_trailing_action_clipboard_copy_button(id: "button", value: "Copyable value", aria: { label: "Copy some text" })
    end

    assert_selector(".InputGroup")
    assert_selector(".FormControl-input.rounded-right-0")
    assert_selector("clipboard-copy.rounded-left-0.border-left-0")
  end

  def test_renders_icon
    render_inline(Primer::OpenProject::InputGroup.new) do |menu|
      menu.with_text_input(name: "a name", label: "My input group", value: "Copyable value")
      menu.with_trailing_action_icon(icon: :gear, aria: { label: "Copy some text" })
    end

    assert_selector(".InputGroup")
    assert_selector(".FormControl-input.rounded-right-0")
    assert_selector(".Button--iconOnly.rounded-left-0.border-left-0")
  end

  def test_does_not_render_without_trailing_action
    render_inline(Primer::OpenProject::InputGroup.new) do |menu|
      menu.with_text_input(name: "a name", label: "My input group", value: "Copyable value")
    end

    refute_selector(".InputGroup")
  end

  def test_does_not_render_without_input
    render_inline(Primer::OpenProject::InputGroup.new) do |menu|
      menu.with_trailing_action_clipboard_copy_button(id: "button", value: "Copyable value", aria: { label: "Copy some text" })
    end

    refute_selector(".InputGroup")
  end
end
