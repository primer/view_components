# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::Layout`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::Layout`.


class Primer::Alpha::Layout
  sig { params(stacking_breakpoint: Symbol, first_in_source: Symbol, gutter: Symbol, system_arguments: T::Hash).void }
  def initialize(stacking_breakpoint:, first_in_source:, gutter:, **system_arguments); end

  sig { returns(T.untyped) }
  def main; end

  sig { returns(T::Boolean) }
  def main?; end

  sig { returns(T.untyped) }
  def sidebar; end

  sig { returns(T::Boolean) }
  def sidebar?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_main(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_sidebar(*args, **_arg1, &block); end
end
