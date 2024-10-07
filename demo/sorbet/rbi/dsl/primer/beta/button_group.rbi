# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Beta::ButtonGroup`.
# Please instead update this file by running `bin/tapioca dsl Primer::Beta::ButtonGroup`.


class Primer::Beta::ButtonGroup
  sig { params(scheme: Symbol, size: Symbol, system_arguments: T::Hash).void }
  def initialize(scheme:, size:, **system_arguments); end

  sig { returns(T.untyped) }
  def buttons; end

  sig { returns(T::Boolean) }
  def buttons?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_button(*args, **_arg1, &block); end
end
