# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Primer::Alpha::SelectPanel`.
# Please instead update this file by running `bin/tapioca dsl Primer::Alpha::SelectPanel`.


class Primer::Alpha::SelectPanel
  sig do
    params(
      src: T.any(String, NilClass),
      title: String,
      id: String,
      size: Symbol,
      select_variant: Symbol,
      fetch_strategy: Symbol,
      no_results_label: String,
      preload: T::Boolean,
      dynamic_label: T::Boolean,
      dynamic_label_prefix: T.any(String, NilClass),
      dynamic_aria_label_prefix: T.any(String, NilClass),
      body_id: T.any(String, NilClass),
      list_arguments: T::Hash,
      form_arguments: T::Hash,
      show_filter: T::Boolean,
      open_on_load: T::Boolean,
      anchor_align: Symbol,
      anchor_side: Symbol,
      loading_label: String,
      loading_description: T.any(String, NilClass),
      banner_scheme: Symbol,
      system_arguments: T::Hash
    ).void
  end
  def initialize(src:, title:, id:, size:, select_variant:, fetch_strategy:, no_results_label:, preload:, dynamic_label:, dynamic_label_prefix:, dynamic_aria_label_prefix:, body_id:, list_arguments:, form_arguments:, show_filter:, open_on_load:, anchor_align:, anchor_side:, loading_label:, loading_description:, banner_scheme:, **system_arguments); end

  sig { returns(T.untyped) }
  def error_content; end

  sig { returns(T::Boolean) }
  def error_content?; end

  sig { returns(T.untyped) }
  def footer; end

  sig { returns(T::Boolean) }
  def footer?; end

  sig { returns(T.untyped) }
  def preload_error_content; end

  sig { returns(T::Boolean) }
  def preload_error_content?; end

  sig { returns(T.untyped) }
  def show_button; end

  sig { returns(T::Boolean) }
  def show_button?; end

  sig { returns(T.untyped) }
  def subtitle; end

  sig { returns(T::Boolean) }
  def subtitle?; end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_error_content(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_footer(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_preload_error_content(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_show_button(*args, **_arg1, &block); end

  sig { params(args: T.nilable(T::Array[T.untyped]), _arg1: T.untyped, block: T.untyped).returns(T.untyped) }
  def with_subtitle(*args, **_arg1, &block); end
end
