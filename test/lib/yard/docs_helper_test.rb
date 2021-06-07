# frozen_string_literal: true

require "test_helper"
require "yard/docs_helper"

class YardDocsHelperTest < Minitest::Test
  include YARD::DocsHelper

  def test_sorts_one_of
    assert_equal "One of `one` and `two`.", one_of(%w[one two])
    assert_equal "One of `1`, `2`, `nil`, or `:auto`.", one_of([1, 2, :auto, nil])
    assert_equal "One of `2`, `3`, or `1`.", one_of([2, 3, 1], sort: false)
  end
end
