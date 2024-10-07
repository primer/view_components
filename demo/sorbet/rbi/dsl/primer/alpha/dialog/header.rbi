# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::Dialog::Header`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::Dialog::Header`.


class Primer::Alpha::Dialog::Header
  sig do
    params(
      subtitle: String,
      show_divider: T::Boolean,
      visually_hide_title: T::Boolean,
      variant: Symbol,
      system_arguments: T::Hash
    ).void
  end
  def initialize(subtitle:, show_divider:, visually_hide_title:, variant:, **system_arguments); end

  sig { returns(T.untyped) }
  def filter; end

  sig { returns(T::Boolean) }
  def filter?; end

  sig { returns(T.untyped) }
  def subtitle; end

  sig { returns(T::Boolean) }
  def subtitle?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_filter(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_subtitle(*args, **_arg1, &block); end
end
