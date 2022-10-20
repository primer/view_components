# frozen_string_literal: true

require "lib/cop_test_case"

class BaseCopTest < CopTestCase
  def cop_class
    RuboCop::Cop::Primer::BaseCop
  end

  def test_valid_node
    source = processed_source(<<-RUBY)
      Primer::BaseComponent.new()
    RUBY

    assert cop.valid_node?(source.ast)
  end

  def test_not_new_method_name_valid_node
    source = processed_source(<<-RUBY)
      Primer::BaseComponent.foo()
    RUBY

    refute cop.valid_node?(source.ast)
  end

  def test_no_method_name_valid_node
    source = processed_source(<<-RUBY)
      Primer::BaseComponent()
    RUBY

    refute cop.valid_node?(source.ast)
  end

  def test_no_receiver_valid_node
    source = processed_source(<<-RUBY)
      new(true)
    RUBY

    refute cop.valid_node?(source.ast)
  end

  def test_view_helper_valid_node
    source = processed_source(<<-RUBY)
      primer_octicon(:foo)
    RUBY

    assert cop.valid_node?(source.ast)
  end

  def test_nil_not_valid_node
    refute cop.valid_node?(nil)
  end
end
