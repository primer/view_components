# frozen_string_literal: true

require "lib/erblint_test_case"

class BaseLinterTest < ErblintTestCase
  def linter_class
    ERBLint::Linters::BaseLinter
  end

  def build_tag_tree
    @linter.send(:build_tag_tree, processed_source)
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

    (tags, tree) = build_tag_tree

    assert_equal [tags.first], tree.keys
    assert_equal tags.last, tree[tags.first][:closing]
    assert_equal tree[tags.first][:children].size, 1
  end

  def test_tree_with_children
    @file = <<~HTML
      <div>
        <div>text</div>
        other text
      </div>
    HTML

    (tags, tree) = build_tag_tree

    assert_equal [tags.first, tags.second], tree.keys
    assert_equal tags.last, tree[tags.first][:closing]
    assert_equal tags.third, tree[tags.second][:closing]
    assert_equal [tree[tags.second]], tag_children(tree[tags.first])
  end

  def test_tree_with_children_between_text
    @file = <<~HTML
      <div>
        some <strong>bold</strong> text
      </div>
    HTML

    (tags, tree) = build_tag_tree

    assert_equal [tags.first, tags.second], tree.keys
    assert_equal tags.last, tree[tags.first][:closing]
    assert_equal tags.third, tree[tags.second][:closing]
    assert_equal [tree[tags.second]], tag_children(tree[tags.first])
  end

  def test_tree_with_multiple_children
    @file = <<~HTML
      <div>
        <div>text</div>
        <div>text</div>
        <div>text</div>
      </div>
    HTML

    (tags, tree) = build_tag_tree

    assert_equal 3, tag_children(tree[tags.first]).size
  end
end
