# frozen_string_literal: true

module Primer
  # All Primer ViewComponents accept a standard set of options called system arguments, mimicking the [styled-system API](https://styled-system.com/table) used by [Primer React](https://primer.style/components/system-props).
  #
  # Under the hood, system arguments are [mapped](https://github.com/primer/view_components/blob/main/app/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).
  #
  # ## Responsive values
  #
  # To apply different values across responsive breakpoints, pass an array with up to five values in the order `[default, small, medium, large, xlarge]`. To skip a breakpoint, pass `nil`.
  #
  # For example:
  #
  # ```erb
  # <%= render Primer::HeadingComponent.new(mt: [0, nil, nil, 4, 2]) do %>
  #   Hello world
  # <% end %>
  # ```
  #
  # Renders:
  #
  # ```html
  # <h1 class="mt-0 mt-lg-4 mt-xl-2">Hello world</h1>
  # ```
  #
  # ## HTML attributes
  #
  # System arguments include most HTML attributes. For example:
  #
  # | Name | Type | Description |
  # | :- | :- | :- |
  # | `width` | `Integer` | Width. |
  # | `height` | `Integer` | Height. |
  # | `data` | `Hash` | Data attributes: `data: { foo: :bar }` renders `data-foo='bar'`. |
  # | `aria` | `Hash` | Aria attributes: `aria: { label: "foo" }` renders `aria-label='foo'`. |
  # | `title` | `String` | The `title` attribute. |
  # | `style` | `String` | Inline styles. |
  # | `hidden` | `Boolean` | Whether to assign the `hidden` attribute. |
  class BaseComponent < Primer::Component
    status :beta

    include TestSelectorHelper

    # @param test_selector [String] Adds `data-test-selector='given value'` in non-Production environments for testing purposes.
    #
    # @param m [Integer] Margin. <%= one_of((-6..6).to_a) %>
    # @param mt [Integer] Margin top. <%= one_of((-6..6).to_a) %>
    # @param mr [Integer] Margin right. <%= one_of((-6..6).to_a) %>
    # @param mb [Integer] Margin bottom. <%= one_of((-6..6).to_a) %>
    # @param ml [Integer] Margin left. <%= one_of((-6..6).to_a) %>
    # @param mx [Integer] Horizontal margins. <%= one_of((-6..6).to_a + [:auto]) %>
    # @param my [Integer] Vertical margins. <%= one_of((-6..6).to_a) %>
    # @param p [Integer] Padding. <%= one_of((0..6).to_a) %>
    # @param pt [Integer] Padding left. <%= one_of((0..6).to_a) %>
    # @param pr [Integer] Padding right. <%= one_of((0..6).to_a) %>
    # @param pb [Integer] Padding bottom. <%= one_of((0..6).to_a) %>
    # @param pl [Integer] Padding left. <%= one_of((0..6).to_a) %>
    # @param px [Integer] Horizontal padding. <%= one_of((0..6).to_a) %>
    # @param py [Integer] Vertical padding. <%= one_of((0..6).to_a) %>
    #
    # @param position [Symbol] <%= one_of([:relative, :absolute, :fixed]) %>
    #
    # @param top [Boolean] If `false`, sets `top: 0`.
    # @param right [Boolean] If `false`, sets `right: 0`.
    # @param bottom [Boolean] If `false`, sets `bottom: 0`.
    # @param left [Boolean] If `false`, sets `left: 0`.
    #
    # @param display [Symbol] <%= one_of([:none, :block, :flex, :inline, :inline_block, :table, :table_cell]) %>
    #
    # @param v [Symbol] Visibility. <%= one_of([:hidden, :visible]) %>
    #
    # @param hide [Symbol] Hide the element at a specific breakpoint. <%= one_of([:sm, :md, :lg, :xl]) %>
    #
    # @param vertical_align [Symbol] <%= one_of([:baseline, :top, :middle, :bottom, :text_top, :text_bottom]) %>
    #
    # @param float [Symbol] <%= one_of([:left, :right]) %>
    #
    # @param col [Integer] Number of columns.
    #
    # @param underline [Boolean] Whether text should be underlined.
    #
    # @param color [Symbol] Text color. <br /> <%= one_of(Primer::Classify::FunctionalColors::TEXT_OPTIONS) %> <br /> Deprecated options: <%= one_of(Primer::Classify::FunctionalColors::DEPRECATED_TEXT_OPTIONS) %>
    # @param bg [String, Symbol] Background color. Accepts either a hex value as a String or a color name as a Symbol.
    #
    # @param box_shadow [Boolean, Symbol] Box shadow. <%= one_of([true, :medium, :large, :extra_large, :none]) %>
    # @param border [Symbol] <%= one_of([:left, :top, :bottom, :right, :y, :x, true]) %>
    # @param border_color [Symbol] <%= one_of(Primer::Classify::FunctionalColors::BORDER_OPTIONS) %> <br /> Deprecated options: <%= one_of(Primer::Classify::FunctionalColors::DEPRECATED_BORDER_OPTIONS) %>
    # @param border_top [Integer] Set to `0` to remove the top border.
    # @param border_bottom [Integer] Set to `0` to remove the bottom border.
    # @param border_left [Integer] Set to `0` to remove the left border.
    # @param border_right [Integer] Set to `0` to remove the right border.
    # @param border_radius [Integer] <%= one_of([0, 1, 2, 3]) %>
    #
    # @param font_size [String, Integer] <%= one_of(["00", 0, 1, 2, 3, 4, 5, 6]) %>
    # @param text_align [Symbol] Text alignment. <%= one_of([:left, :right, :center]) %>
    # @param font_weight [Symbol] Font weight. <%= one_of([:light, :normal, :bold]) %>
    #
    # @param flex [Integer, Symbol] <%= one_of([1, :auto]) %>
    # @param flex_grow [Integer] To enable, set to `0`.
    # @param flex_shrink [Integer] To enable, set to `0`.
    # @param align_self [Symbol] <%= one_of([:auto, :start, :end, :center, :baseline, :stretch]) %>
    # @param justify_content [Symbol] <%= one_of([:flex_start, :flex_end, :center, :space_between, :space_around]) %>
    # @param align_items [Symbol] <%= one_of([:flex_start, :flex_end, :center, :baseline, :stretch]) %>
    # @param width [Symbol] <%= one_of([:fit, :fill]) %>
    # @param height [Symbol] <%= one_of([:fit, :fill]) %>
    #
    # @param word_break [Symbol] Whether to break words on line breaks. Can only be `:break_all`.
    #
    # @param animation [Symbol] <%= one_of([:fade_in, :fade_out, :fade_up, :fade_down, :scale_in, :pulse, :grow_x, :grow]) %>
    #
    # @param tag [Symbol] HTML tag name to be passed to `tag.send`.
    # @param classes [String] CSS class name value to be concatenated with generated Primer CSS classes.
    def initialize(tag:, classes: nil, **system_arguments)
      @tag = tag
      @result = Primer::Classify.call(**system_arguments.merge(classes: classes))

      # Filter out Primer keys so they don't get assigned as HTML attributes
      @content_tag_args = add_test_selector(system_arguments).except(*Primer::Classify::VALID_KEYS)
    end

    def call
      content_tag(@tag, content, @content_tag_args.merge(@result))
    end
  end
end
