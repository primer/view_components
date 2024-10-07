# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::SegmentedControl`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::SegmentedControl`.


class Primer::Alpha::SegmentedControl
  sig { params(hide_labels: T::Boolean, full_width: T::Boolean, size: Symbol, system_arguments: T::Hash).void }
  def initialize(hide_labels:, full_width:, size:, **system_arguments); end

  sig { returns(T.untyped) }
  def items; end

  sig { returns(T::Boolean) }
  def items?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_item(*args, **_arg1, &block); end
end
