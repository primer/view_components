# frozen_string_literal: true

require "components/test_helper"

class PrimerDropdownMenuComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_dropdown_component_renders_dark_scheme
    render_inline(Primer::DropdownMenuComponent.new(scheme: :dark)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-dark")
  end

  def test_dropdown_direction_renders
    render_inline(Primer::DropdownMenuComponent.new(direction: :w)) { "Body" }

    assert_selector("details-menu.dropdown-menu.dropdown-menu-w")
  end

  def test_falls_back_to_defaults_when_invalid_options_are_passed
    without_fetch_or_fallback_raises do
      render_inline(Primer::DropdownMenuComponent.new(direction: :circle, scheme: :orange)) { "Body" }
    end

    assert_selector("details-menu.dropdown-menu")
  end

  def test_dropdown_header_renders
    render_inline(Primer::DropdownMenuComponent.new(header: "Header")) { "Body" }

    assert_selector(".dropdown-header")
  end

  def test_status
    assert_component_state(Primer::DropdownMenuComponent, :deprecated)
  end
end
