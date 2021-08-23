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
    @linter.send(:build_tag_tree, processed_source, tags)
  end

  def tag_children(tree)
    tree[:children].select { |x| x.is_a?(Hash) }
  end

  def test_text_is_a_children
    @file = <<~HTML
      <div>
        some text
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal [processed_tags.first], tree.keys
    assert_equal processed_tags.last, tree[processed_tags.first][:closing]
    assert_equal tree[processed_tags.first][:children].size, 1
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
    assert_equal [tree[processed_tags.second]], tag_children(tree[processed_tags.first])
  end

  def test_tree_with_children_between_text
    @file = <<~HTML
      <div>
        some <strong>bold</strong> text
      </div>
    HTML

    processed_tags = tags
    tree = build_tag_tree(processed_tags)

    assert_equal [processed_tags.first, processed_tags.second], tree.keys
    assert_equal processed_tags.last, tree[processed_tags.first][:closing]
    assert_equal processed_tags.third, tree[processed_tags.second][:closing]
    assert_equal [tree[processed_tags.second]], tag_children(tree[processed_tags.first])
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

    assert_equal 3, tag_children(tree[processed_tags.first]).size
  end
end
