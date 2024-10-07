# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Beta::AutoComplete`.
# Please instead update this file by running `bin/tapioca dsl Primer::Beta::AutoComplete`.


class Primer::Beta::AutoComplete
  sig do
    params(
      input_name: String,
      placeholder: String,
      show_clear_button: T::Boolean,
      visually_hide_label: T::Boolean,
      size: T::Hash,
      full_width: T::Boolean,
      width: String,
      disabled: T::Boolean,
      invalid: T::Boolean,
      inset: T::Boolean,
      monospace: T::Boolean,
      system_arguments: T::Hash
    ).void
  end
  def initialize(input_name:, placeholder:, show_clear_button:, visually_hide_label:, size:, full_width:, width:, disabled:, invalid:, inset:, monospace:, **system_arguments); end

  sig { returns(T.untyped) }
  def input; end

  sig { returns(T::Boolean) }
  def input?; end

  sig { returns(T.untyped) }
  def leading_visual; end

  sig { returns(T::Boolean) }
  def leading_visual?; end

  sig { returns(T.untyped) }
  def results; end

  sig { returns(T::Boolean) }
  def results?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_input(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_leading_visual(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_results(*args, **_arg1, &block); end
end
