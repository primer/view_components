# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Lookbook::IconButton::Component`.
# Please instead update this file by running `bin/tapioca dsl Lookbook::IconButton::Component`.


class Lookbook::IconButton::Component
  sig { returns(T.untyped) }
  def icons; end

  sig { returns(T::Boolean) }
  def icons?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_icon(*args, **_arg1, &block); end
end
