# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::Navigation::Tab`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::Navigation::Tab`.


class Primer::Alpha::Navigation::Tab
  sig do
    params(
      list: T::Boolean,
      selected: T::Boolean,
      with_panel: T::Boolean,
      panel_id: String,
      icon_classes: T::Boolean,
      wrapper_arguments: T::Hash,
      system_arguments: T::Hash
    ).void
  end
  def initialize(list:, selected:, with_panel:, panel_id:, icon_classes:, wrapper_arguments:, **system_arguments); end

  sig { returns(T.untyped) }
  def counter; end

  sig { returns(T::Boolean) }
  def counter?; end

  sig { returns(T.untyped) }
  def icon; end

  sig { returns(T::Boolean) }
  def icon?; end

  sig { returns(T.untyped) }
  def panel; end

  sig { returns(T::Boolean) }
  def panel?; end

  sig { returns(T.untyped) }
  def text; end

  sig { returns(T::Boolean) }
  def text?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_counter(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_icon(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_panel(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_text(*args, **_arg1, &block); end
end
