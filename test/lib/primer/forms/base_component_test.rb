# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::BaseComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders
    render_inline(Primer::Forms::TestComponents::Foo.new)
    assert_selector "p", text: "foo"
  end

  def test_does_not_render
    render_inline(Primer::Forms::TestComponents::Foo.new(render: false))
    refute_selector "p"
  end
end
