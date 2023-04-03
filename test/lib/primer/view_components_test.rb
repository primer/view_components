# frozen_string_literal: true

require "lib/test_helper"

class Primer::ViewComponentsTest < Minitest::Test
  def test_root
    assert Primer::ViewComponents.root.join("app", "components", "primer", "base_component.rb").exist?
  end
end
