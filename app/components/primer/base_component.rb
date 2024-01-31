# frozen_string_literal: true

require "primer/classify"

module Primer
  # All Primer ViewComponents accept a standard set of options called system arguments, mimicking the [styled-system API](https://styled-system.com/table) used by [Primer React](https://primer.style/components/system-props).
  #
  # Under the hood, system arguments are [mapped](https://github.com/primer/view_components/blob/main/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).
  #
  # ## Responsive values
  #
  # To apply different values across responsive breakpoints, pass an array with up to five values in the order `[default, small, medium, large, xlarge]`. To skip a breakpoint, pass `nil`.
  #
  # For example:
  #
  # ```erb
  # <%= render Primer::Beta::Heading.new(mt: [0, nil, nil, 4, 2]) do %>
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

    SELF_CLOSING_TAGS = [:area, :base, :br, :col, :embed, :hr, :img, :input, :link, :meta, :param, :source, :track, :wbr].freeze
    # ## HTML attributes
    #
    # Use system arguments to add HTML attributes to elements. For the most part, system arguments map 1:1 to
    # HTML attributes. For example, `render(Component.new(title: "Foo"))` will result in eg. `<div title="foo">`.
    # However, ViewComponents applies special handling to certain system arguments. See the table below for details.
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `aria` | `Hash` | Aria attributes: `aria: { label: "foo" }` renders `aria-label='foo'`. |
    # | `data` | `Hash` | Data attributes: `data: { foo: :bar }` renders `data-foo='bar'`. |
    #
    # ## Utility classes
    #
    # ViewComponents provides a convenient way to add Primer CSS utility classes to HTML elements. Use the shorthand
    # documented in the tables below instead of adding CSS classes directly.
    #
    # ### Animation
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `animation` | Symbol | <%= one_of(Primer::Classify::Utilities.mappings(:animation)) %> |
    #
    # ### Border
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
    # ### Color
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `bg` | Symbol | Background color. <%= one_of(Primer::Classify::Utilities.mappings(:bg)) %> |
    # | `border_color` | Symbol | Border color. <%= one_of(Primer::Classify::Utilities.mappings(:border_color)) %> |
    # | `color` | Symbol | Text color. <%= one_of(Primer::Classify::Utilities.mappings(:color)) %> |
    #
    # ### Flex
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `align_items` | Symbol | <%= one_of(Primer::Classify::FLEX_ALIGN_ITEMS_VALUES) %> |
    # | `align_self` | Symbol | <%= one_of(Primer::Classify::FLEX_ALIGN_SELF_VALUES) %> |
    # | `direction` | Symbol | <%= one_of(Primer::Classify::FLEX_DIRECTION_VALUES) %> |
    # | `flex` | Integer, Symbol | <%= one_of(Primer::Classify::FLEX_VALUES) %> |
    # | `flex_grow` | Integer | To enable, set to `0`. |
    # | `flex_shrink` | Integer | To enable, set to `0`. |
    # | `flex_wrap` | Symbol | <%= one_of(Primer::Classify::FLEX_WRAP_MAPPINGS.keys) %> |
    # | `justify_content` | Symbol | <%= one_of(Primer::Classify::FLEX_JUSTIFY_CONTENT_VALUES) %> |
    #
    # ### Grid
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `clearfix` | Boolean | Whether to assign the `clearfix` class. |
    # | `col` | Integer | Number of columns. <%= one_of(Primer::Classify::Utilities.mappings(:col)) %> |
    # | `container` | Symbol | Size of the container. <%= one_of(Primer::Classify::Utilities.mappings(:container)) %> |
    #
    # ### Layout
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `display` | Symbol | <%= one_of(Primer::Classify::Utilities.mappings(:display)) %> |
    # | `w` | Symbol | Sets the element's width. <%= one_of(Primer::Classify::Utilities.mappings(:w)) %> |
    # | `h` | Symbol | Sets the element's height. One of `:fit` or `:full`. |
    # | `hide` | Symbol | Hide the element at a specific breakpoint. <%= one_of(Primer::Classify::Utilities.mappings(:hide)) %> |
    # | `visibility` | Symbol | Visibility. <%= one_of(Primer::Classify::Utilities.mappings(:visibility)) %> |
    # | `vertical_align` | Symbol | <%= one_of(Primer::Classify::Utilities.mappings(:vertical_align)) %> |
    #
    # ### Position
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `bottom` | Boolean | If `false`, sets `bottom: 0`. |
    # | `float` | Symbol | <%= one_of(Primer::Classify::Utilities.mappings(:float)) %> |
    # | `left` | Boolean | If `false`, sets `left: 0`. |
    # | `position` | Symbol | <%= one_of(Primer::Classify::Utilities.mappings(:position)) %> |
    # | `right` | Boolean | If `false`, sets `right: 0`. |
    # | `top` | Boolean | If `false`, sets `top: 0`. |
    #
    # ### Spacing
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `m` | Integer | Margin. <%= one_of(Primer::Classify::Utilities.mappings(:m)) %> |
    # | `mb` | Integer | Margin bottom. <%= one_of(Primer::Classify::Utilities.mappings(:mb)) %> |
    # | `ml` | Integer | Margin left. <%= one_of(Primer::Classify::Utilities.mappings(:ml)) %> |
    # | `mr` | Integer | Margin right. <%= one_of(Primer::Classify::Utilities.mappings(:mr)) %> |
    # | `mt` | Integer | Margin top. <%= one_of(Primer::Classify::Utilities.mappings(:mt)) %> |
    # | `mx` | Integer | Horizontal margins. <%= one_of(Primer::Classify::Utilities.mappings(:mx)) %> |
    # | `my` | Integer | Vertical margins. <%= one_of(Primer::Classify::Utilities.mappings(:my)) %> |
    # | `p` | Integer | Padding. <%= one_of(Primer::Classify::Utilities.mappings(:p)) %> |
    # | `pb` | Integer | Padding bottom. <%= one_of(Primer::Classify::Utilities.mappings(:pb)) %> |
    # | `pl` | Integer | Padding left. <%= one_of(Primer::Classify::Utilities.mappings(:pl)) %> |
    # | `pr` | Integer | Padding right. <%= one_of(Primer::Classify::Utilities.mappings(:pr)) %> |
    # | `pt` | Integer | Padding left. <%= one_of(Primer::Classify::Utilities.mappings(:pt)) %> |
    # | `px` | Integer | Horizontal padding. <%= one_of(Primer::Classify::Utilities.mappings(:px)) %> |
    # | `py` | Integer | Vertical padding. <%= one_of(Primer::Classify::Utilities.mappings(:py)) %> |
    #
    # ### Typography
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | `font_family` | Symbol | Font family. <%= one_of([:mono]) %> |
    # | `font_size` | String, Integer, Symbol | <%= one_of(["00", 0, 1, 2, 3, 4, 5, 6, :small, :normal]) %> |
    # | `font_style` | Symbol | Font style. <%= one_of([:italic]) %> |
    # | `font_weight` | Symbol | Font weight. <%= one_of([:light, :normal, :bold, :emphasized]) %> |
    # | `text_align` | Symbol | Text alignment. <%= one_of([:left, :right, :center]) %> |
    # | `text_transform` | Symbol | Text transformation. <%= one_of([:uppercase, :capitalize]) %> |
    # | `underline` | Boolean | Whether text should be underlined. |
    # | `word_break` | Symbol | Whether to break words on line breaks. <%= one_of(Primer::Classify::Utilities.mappings(:word_break)) %> |
    #
    # ### Other
    #
    # | Name | Type | Description |
    # | :- | :- | :- |
    # | classes | String | CSS class name value to be concatenated with generated Primer CSS classes. |
    # | test_selector | String | Adds `data-test-selector='given value'` in non-Production environments for testing purposes. |
    def initialize(tag:, classes: nil, **system_arguments)
      @tag = tag

      @system_arguments = validate_arguments(tag: tag, **system_arguments)

      @result = Primer::Classify.call(**@system_arguments.merge(classes: classes))

      @system_arguments[:"data-view-component"] = true
      # Filter out Primer keys so they don't get assigned as HTML attributes
      @content_tag_args = add_test_selector(@system_arguments).except(*Primer::Classify::Utilities::UTILITIES.keys)
    end

    def call
      if SELF_CLOSING_TAGS.include?(@tag)
        tag(@tag, @content_tag_args.merge(@result))
      else
        content_tag(@tag, content, @content_tag_args.merge(@result))
      end
    end
  end
end
