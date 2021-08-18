# frozen_string_literal: true

require "linter_test_case"

class BaseLinterTest < LinterTestCase
  def linter_class
    ERBLint::Linters::BaseLinter
  end

  def tags
    @linter.send(:tags, processed_source)
  end

  def build_tag_tree(tags)
    @linter.send(:build_tag_tree, tags)
  end

  def test_text_is_not_a_tag_children
    @file = <<~HTML
      <div>
        some text
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal [processed_tags.first], tree.keys
    assert_equal processed_tags.last, tree[processed_tags.first][:closing]
    assert_empty tree[processed_tags.first][:children]
  end

  def test_tree_with_children
    @file = <<~HTML
      <div>
        <div>text</div>
        other text
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal [processed_tags.first, processed_tags.second], tree.keys
    assert_equal processed_tags.last, tree[processed_tags.first][:closing]
    assert_equal processed_tags.third, tree[processed_tags.second][:closing]
    assert_equal [tree[processed_tags.second]], tree[processed_tags.first][:children]
  end

  def test_tree_with_multiple_children
    @file = <<~HTML
      <div>
        <div>text</div>
        <div>text</div>
        <div>text</div>
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal 3, tree[processed_tags.first][:children].size
  end

  def test_tree_with_nested_children
    @file = <<~HTML
      <div>
        <div>
          <div>text</div>
          <div>text</div>
        </div>
        <div>
          <div>text</div>
          <div>text</div>
          <div>text</div>
        </div>
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal 2, tree[processed_tags.first][:children].first[:children].size
    assert_equal 3, tree[processed_tags.first][:children].last[:children].size
  end
end
