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
  class BaseComponent < Primer::Component
    status :beta

    # ## HTML attributes
    #
    # System arguments include most HTML attributes. For example:
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `aria` | `Hash` | Aria attributes: `aria: { label: "foo" }` renders `aria-label='foo'`. |
    # | `data` | `Hash` | Data attributes: `data: { foo: :bar }` renders `data-foo='bar'`. |
    # | `height` | `Integer` | Height. |
    # | `hidden` | `Boolean` | Whether to assign the `hidden` attribute. |
    # | `style` | `String` | Inline styles. |
    # | `title` | `String` | The `title` attribute. |
    # | `width` | `Integer` | Width. |
    #
    # ## Animation
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `animation` | Symbol | <%= one_of([:fade_in, :fade_out, :fade_up, :fade_down, :scale_in, :pulse, :grow_x, :grow]) %> |
    #
    # ## Border
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `border_bottom` | Integer | Set to `0` to remove the bottom border. |
    # | `border_left` | Integer | Set to `0` to remove the left border. |
    # | `border_radius` | Integer | <%= one_of([0, 1, 2, 3]) %> |
    # | `border_right` | Integer | Set to `0` to remove the right border. |
    # | `border_top` | Integer | Set to `0` to remove the top border. |
    # | `border` | Symbol | <%= one_of([:left, :top, :bottom, :right, :y, :x, true]) %> |
    # | `box_shadow` | Boolean, Symbol | Box shadow. <%= one_of([true, :medium, :large, :extra_large, :none]) %> |
    #
    # ## Color
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `bg` | String, Symbol | Background color. Accepts either a hex value as a String or <%= one_of(Primer::Classify::FunctionalBorderColors::OPTIONS, lower: true) %> |
    # | `border_color` | Symbol | Border color. <%= one_of(Primer::Classify::FunctionalBorderColors::OPTIONS) %> |
    # | `color` | Symbol | Text color. <%= one_of(Primer::Classify::FunctionalTextColors::OPTIONS) %> |
    #
    # ## Flex
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `align_items` | Symbol | <%= one_of([:flex_start, :flex_end, :center, :baseline, :stretch]) %> |
    # | `align_self` | Symbol | <%= one_of(Primer::Classify::Flex::ALIGN_SELF_VALUES) %> |
    # | `direction` | Symbol | <%= one_of([:column, :column_reverse, :row, :row_reverse]) %> |
    # | `flex` | Integer, Symbol | <%= one_of(Primer::Classify::Flex::FLEX_VALUES) %> |
    # | `flex_grow` | Integer | To enable, set to `0`. |
    # | `flex_shrink` | Integer | To enable, set to `0`. |
    # | `flex_wrap` | Symbol | <%= one_of(Primer::Classify::Flex::WRAP_MAPPINGS.keys) %> |
    # | `justify_content` | Symbol | <%= one_of([:flex_start, :flex_end, :center, :space_between, :space_around]) %> |
    # | `width` | Symbol | <%= one_of([:fit, :fill]) %> |
    #
    # ## Grid
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `col` | Integer | Number of columns. |
    #
    # ## Layout
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `display` | Symbol | <%= one_of([:none, :block, :flex, :inline, :inline_block, :inline_flex, :table, :table_cell]) %> |
    # | `height` | Symbol | <%= one_of([:fit, :fill]) %> |
    # | `hide` | Symbol | Hide the element at a specific breakpoint. <%= one_of([:sm, :md, :lg, :xl]) %> |
    # | `v` | Symbol | Visibility. <%= one_of([:hidden, :visible]) %> |
    # | `vertical_align` | Symbol | <%= one_of([:baseline, :top, :middle, :bottom, :text_top, :text_bottom]) %> |
    #
    # ## Position
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `bottom` | Boolean | If `false`, sets `bottom: 0`. |
    # | `float` | Symbol | <%= one_of([:left, :right]) %> |
    # | `left` | Boolean | If `false`, sets `left: 0`. |
    # | `position` | Symbol | <%= one_of([:relative, :absolute, :fixed]) %> |
    # | `right` | Boolean | If `false`, sets `right: 0`. |
    # | `top` | Boolean | If `false`, sets `top: 0`. |
    #
    # ## Spacing
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `m` | Integer | Margin. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:m]) %> |
    # | `mb` | Integer | Margin bottom. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:mb]) %> |
    # | `ml` | Integer | Margin left. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:ml]) %> |
    # | `mr` | Integer | Margin right. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:mr]) %> |
    # | `mt` | Integer | Margin top. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:mt]) %> |
    # | `mx` | Integer | Horizontal margins. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:mx]) %> |
    # | `my` | Integer | Vertical margins. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:my]) %> |
    # | `p` | Integer | Padding. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:p]) %> |
    # | `pb` | Integer | Padding bottom. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:pb]) %> |
    # | `pl` | Integer | Padding left. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:pl]) %> |
    # | `pr` | Integer | Padding right. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:pr]) %> |
    # | `pt` | Integer | Padding left. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:pt]) %> |
    # | `px` | Integer | Horizontal padding. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:px]) %> |
    # | `py` | Integer | Vertical padding. <%= one_of(Primer::Classify::Spacing::MAPPINGS[:py]) %> |
    #
    # ## Typography
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `font_size` | String, Integer | <%= one_of(["00", 0, 1, 2, 3, 4, 5, 6]) %> |
    # | `font_weight` | Symbol | Font weight. <%= one_of([:light, :normal, :bold]) %> |
    # | `text_align` | Symbol | Text alignment. <%= one_of([:left, :right, :center]) %> |
    # | `underline` | Boolean | Whether text should be underlined. |
    # | `word_break` | Symbol | Whether to break words on line breaks. Can only be `:break_all`. |
    #
    # ## Other
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | classes | String | CSS class name value to be concatenated with generated Primer CSS classes. |
    # | tag | Symbol | HTML tag name to be passed to `content_tag`. |
    # | test_selector | String | Adds `data-test-selector='given value'` in non-Production environments for testing purposes. |
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
