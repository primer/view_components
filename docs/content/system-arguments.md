---
title: System arguments
---

All Primer ViewComponents accept a standard set of options called system arguments, mimicking the [styled-system API](https://styled-system.com/table) used by [Primer React](https://primer.style/components/system-props).

Under the hood, system arguments are [mapped](https://github.com/primer/view_components/blob/main/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).

## Responsive values

To apply different values across responsive breakpoints, pass an array with up to five values in the order `[default, small, medium, large, xlarge]`. To skip a breakpoint, pass `nil`.

For example:

```erb
<%= render Primer::HeadingComponent.new(mt: [0, nil, nil, 4, 2]) do %>
  Hello world
<% end %>
```

Renders:

```html
<h1 class="mt-0 mt-lg-4 mt-xl-2">Hello world</h1>
```

## HTML attributes

System arguments sinclude most HTML attributes. For example:

| Name | Type | Description |
| :- | :- | :- |
| `width` | `Integer` | Width. |
| `height` | `Integer` | Height. |
| `data` | `Hash` | Data attributes. For example: `data: { foo: :bar }` will render `data-foo='bar'`. |
| `title` | `String` | The `title` attribute. |
| `hidden` | `Boolean` | Whether to assign the `hidden` attribute. |

## Arguments

| Name | Type | Description |
| :- | :- | :- |
| `test_selector` | `String` | Adds `data-test-selector='given value'` in non-Production environments for testing purposes. |
| `m` | `Integer` | Margin. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mt` | `Integer` | Margin left. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mr` | `Integer` | Margin right. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mb` | `Integer` | Margin bottom. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `ml` | `Integer` | Margin left. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mx` | `Integer` | Horizontal margins. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, or `:auto`. |
| `my` | `Integer` | Vertical margins. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `p` | `Integer` | Padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `pt` | `Integer` | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `pr` | `Integer` | Padding right. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `pb` | `Integer` | Padding bottom. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `pl` | `Integer` | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `px` | `Integer` | Horizontal padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `py` | `Integer` | Vertical padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `position` | `Symbol` | One of `:relative`, `:absolute`, or `:fixed`. |
| `top` | `Boolean` | If `false`, sets `top: 0`. |
| `right` | `Boolean` | If `false`, sets `right: 0`. |
| `bottom` | `Boolean` | If `false`, sets `bottom: 0`. |
| `left` | `Boolean` | If `false`, sets `left: 0`. |
| `display` | `Symbol` | One of `:block`, `:none`, `:inline`, `:inline_block`, `:table`, or `:table_cell`. |
| `v` | `Symbol` | Visibility. One of `:hidden` and `:visible`. |
| `hide` | `Symbol` | Hide the element at a specific breakpoint. One of `:sm`, `:md`, `:lg`, or `:xl`. |
| `vertical_align` | `Symbol` | One of `:baseline`, `:top`, `:middle`, `:bottom`, `:text_top`, or `:text_bottom`. |
| `float` | `Symbol` | One of `:left` and `:right`. |
| `col` | `Integer` | Number of columns. |
| `underline` | `Boolean` | Whether text should be underlined. |
| `color` | `Symbol` | Text color. One of `:blue`, `:red`, `:gray_light`, `:gray`, `:gray_dark`, `:green`, `:orange`, `:orange_light`, `:purple`, `:pink`, `:white`, or `:inherit`. Note: this API is subject to change as we move to functional colors. |
| `bg` | `String, Symbol` | Background color. Accepts either a hex value as a String or a color name as a Symbol. |
| `box_shadow` | `Boolean, Symbol` | Box shadow. <%= one_of([true, :medium, :large, :extra_large, :none]) |
| `border` | `Symbol` | One of `:left`, `:top`, `:bottom`, `:right`, `:y`, or `:x`. |
| `border_color` | `Symbol` | One of `:blue`, `:blue_light`, `:gray`, `:gray_dark`, `:green`, `:purple`, `:red`, `:red_light`, `:white`, `:yellow`, or `:black_fade`. Note: this API is subject to change as we move to functional colors. |
| `border_top` | `Integer` | Set to `0` to remove the top border. |
| `border_bottom` | `Integer` | Set to `0` to remove the bottom border. |
| `border_left` | `Integer` | Set to `0` to remove the left border. |
| `border_right` | `Integer` | Set to `0` to remove the right border. |
| `font_size` | `String` | One of `00`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `text_align` | `Symbol` | Text alignment. One of `:left`, `:right`, or `:center`. |
| `font_weight` | `Symbol` | Font weight. One of `:light`, `:normal`, or `:bold`. |
| `flex` | `Integer, Symbol` | One of `1` and `:auto`. |
| `flex_grow` | `Integer` | To enable, set to `0`. |
| `flex_shrink` | `Integer` | To enable, set to `0`. |
| `align_self` | `Symbol` | One of `:auto`, `:start`, `:end`, `:center`, `:baseline`, or `:stretch`. |
| `justify_content` | `Symbol` | One of `:flex_start`, `:flex_end`, `:center`, `:space_between`, or `:space_around`. |
| `align_items` | `Symbol` | One of `:flex_start`, `:flex_end`, `:center`, `:baseline`, or `:stretch`. |
| `width` | `Symbol` | One of `:fit` and `:fill`. |
| `height` | `Symbol` | One of `:fit` and `:fill`. |
| `word_break` | `Symbol` | Whether to break words on line breaks. Can only be `:break_all`. |
| `tag` | `Symbol` | HTML tag name to be passed to `tag.send`. |
| `classes` | `String` | CSS class name value to be concatenated with generated Primer CSS classes. |
