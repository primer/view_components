# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::Overlay::Header`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::Overlay::Header`.


class Primer::Alpha::Overlay::Header
  sig do
    params(
      overlay_id: String,
      subtitle: String,
      size: Symbol,
      divider: T::Boolean,
      visually_hide_title: T::Boolean,
      system_arguments: T::Hash
    ).void
  end
  def initialize(overlay_id:, subtitle:, size:, divider:, visually_hide_title:, **system_arguments); end

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
