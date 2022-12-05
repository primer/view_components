# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::BaseComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class Foo < Primer::Forms::BaseComponent
    def initialize(render: true)
      @render = render
    end

    def render?
      @render
    end

    private

    # Method is overridden so we don't have to define a template file
    # for this component. Don't try this at home, kids.
    def compile_and_render_template
      "<p>foo</p>".html_safe
    end
  end

  def test_renders
    render_inline(Foo.new)
    assert_selector "p", text: "foo"
  end

  def test_does_not_render
    render_inline(Foo.new(render: false))
    refute_selector "p"
  end
end
