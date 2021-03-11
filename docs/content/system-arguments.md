---
title: System arguments
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

All Primer ViewComponents accept a standard set of options called system arguments, mimicking the [styled-system API](https://styled-system.com/table) used by [Primer React](https://primer.style/components/system-props).

Under the hood, system arguments are [mapped](https://github.com/primer/view_components/blob/main/app/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).

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

System arguments include most HTML attributes. For example:

| Name | Type | Description |
| :- | :- | :- |
| `width` | `Integer` | Width. |
| `height` | `Integer` | Height. |
| `data` | `Hash` | Data attributes: `data: { foo: :bar }` renders `data-foo='bar'`. |
| `aria` | `Hash` | Aria attributes: `aria: { label: "foo" }` renders `aria-label='foo'`. |
| `title` | `String` | The `title` attribute. |
| `style` | `String` | Inline styles. |
| `hidden` | `Boolean` | Whether to assign the `hidden` attribute. |

## Arguments

| Name | Type | Description |
| :- | :- | :- |
| `test_selector` | `String` | Adds `data-test-selector='given value'` in non-Production environments for testing purposes. |
| `m` | `Integer` | Margin. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mt` | `Integer` | Margin top. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
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
| `display` | `Symbol` | One of `:none`, `:block`, `:flex`, `:inline`, `:inline_block`, `:table`, or `:table_cell`. |
| `v` | `Symbol` | Visibility. One of `:hidden` and `:visible`. |
| `hide` | `Symbol` | Hide the element at a specific breakpoint. One of `:sm`, `:md`, `:lg`, or `:xl`. |
| `vertical_align` | `Symbol` | One of `:baseline`, `:top`, `:middle`, `:bottom`, `:text_top`, or `:text_bottom`. |
| `float` | `Symbol` | One of `:left` and `:right`. |
| `col` | `Integer` | Number of columns. |
| `underline` | `Boolean` | Whether text should be underlined. |
| `color` | `Symbol` | Text color. <br /> One of `:icon_primary`, `:icon_secondary`, `:icon_tertiary`, `:icon_info`, `:icon_success`, `:icon_warning`, `:icon_danger`, `:text_primary`, `:text_secondary`, `:text_tertiary`, `:text_link`, `:text_success`, `:text_warning`, `:text_danger`, `:text_white`, or `:text_inverse`. <br /> Deprecated options: One of `:gray_dark`, `:gray`, `:gray_light`, `:blue`, `:green`, `:yellow`, `:red`, `:white`, `:black`, `:orange`, `:orange_light`, `:purple`, `:pink`, or `:inherit`. |
| `bg` | `String, Symbol` | Background color. Accepts either a hex value as a String or a color name as a Symbol. |
| `box_shadow` | `Boolean, Symbol` | Box shadow. One of `true`, `:medium`, `:large`, `:extra_large`, or `:none`. |
| `border` | `Symbol` | One of `:left`, `:top`, `:bottom`, `:right`, `:y`, `:x`, or `true`. |
| `border_color` | `Symbol` | One of `:primary`, `:secondary`, `:tertiary`, `:info`, `:success`, `:warning`, `:danger`, `:inverse`, or `:overlay`. <br /> Deprecated options: One of `:gray`, `:gray_light`, `:gray_dark`, `:blue`, `:green`, `:yellow`, `:red`, `:white`, `:gray_darker`, `:blue_light`, `:red_light`, `:purple`, `:black_fade`, or `:white_fade`. |
| `border_top` | `Integer` | Set to `0` to remove the top border. |
| `border_bottom` | `Integer` | Set to `0` to remove the bottom border. |
| `border_left` | `Integer` | Set to `0` to remove the left border. |
| `border_right` | `Integer` | Set to `0` to remove the right border. |
| `border_radius` | `Integer` | One of `0`, `1`, `2`, or `3`. |
| `font_size` | `String, Integer` | One of `00`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
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
| `animation` | `Symbol` | One of `:fade_in`, `:fade_out`, `:fade_up`, `:fade_down`, `:scale_in`, `:pulse`, `:grow_x`, or `:grow`. |
| `tag` | `Symbol` | HTML tag name to be passed to `tag.send`. |
| `classes` | `String` | CSS class name value to be concatenated with generated Primer CSS classes. |
