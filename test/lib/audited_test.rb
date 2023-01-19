# frozen_string_literal: true

require "lib/test_helper"
require "primer/view_components/audited"

class Primer::ViewComponents::AuditedTest < Minitest::Test
  def test_audited_array_isnt_empty
    refute_empty Primer::ViewComponents::AUDITED.keys
  end
end
