# frozen_string_literal: true

require "lib/test_helper"

class YardDocsHelperTest < Minitest::Test
  include Primer::YARD::DocsHelper

  def test_sorts_one_of
    assert_equal "One of `one` or `two`.", one_of(%w[one two])
    assert_equal "One of `1`, `2`, `nil`, or `:auto`.", one_of([1, 2, :auto, nil])
    assert_equal "One of `2`, `3`, or `1`.", one_of([2, 3, 1], sort: false)
  end

  def test_link_to_component
    assert_equal("[Button](/components/button)", link_to_component(Primer::ButtonComponent))
    assert_equal("[AutoComplete::Item](/components/beta/autocompleteitem)", link_to_component(Primer::Beta::AutoComplete::Item))
  end

  def test_pretty_value
    assert_equal("`nil`", pretty_value(nil))
    assert_equal("`:foo`", pretty_value(:foo))
    assert_equal("`bar`", pretty_value("bar"))
  end

  # We're not sure these tests are ideal. Feel free to refactor!
  def test_link_to_system_arguments_docs
    assert_equal("[System arguments](/system-arguments)", link_to_system_arguments_docs)
  end

  def test_link_to_typography_docs
    assert_equal("[Typography](/system-arguments#typography)", link_to_typography_docs)
  end

  def test_link_to_octicons
    assert_equal("[Octicon](https://primer.style/octicons/)", link_to_octicons)
  end

  def test_link_to_heading_practices
    assert_equal("[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)", link_to_heading_practices)
  end
end
