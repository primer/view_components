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
| `aria` | `Hash` | Aria attributes: `aria: { label: "foo" }` renders `aria-label='foo'`. |
| `data` | `Hash` | Data attributes: `data: { foo: :bar }` renders `data-foo='bar'`. |
| `height` | `Integer` | Height. |
| `hidden` | `Boolean` | Whether to assign the `hidden` attribute. |
| `style` | `String` | Inline styles. |
| `title` | `String` | The `title` attribute. |
| `width` | `Integer` | Width. |

## Animation

| Name | Type | Description |
| :- | :- | :- |
| `animation` | Symbol | One of `:fade_down`, `:fade_in`, `:fade_out`, `:fade_up`, `:grow`, `:grow_x`, `:pulse`, or `:scale_in`. |

## Border

| Name | Type | Description |
| :- | :- | :- |
| `border_bottom` | Integer | Set to `0` to remove the bottom border. |
| `border_left` | Integer | Set to `0` to remove the left border. |
| `border_radius` | Integer | One of `0`, `1`, `2`, or `3`. |
| `border_right` | Integer | Set to `0` to remove the right border. |
| `border_top` | Integer | Set to `0` to remove the top border. |
| `border` | Symbol | One of `:bottom`, `:left`, `:right`, `:top`, `:x`, `:y`, or `true`. |
| `box_shadow` | Boolean, Symbol | Box shadow. One of `:extra_large`, `:large`, `:medium`, `:none`, or `true`. |

## Color

| Name | Type | Description |
| :- | :- | :- |
| `bg` | String, Symbol | Background color. Accepts either a hex value as a String or one of `:danger`, `:info`, `:inverse`, `:primary`, `:secondary`, `:success`, `:tertiary`, or `:warning`. |
| `border_color` | Symbol | Border color. One of `:danger`, `:info`, `:inverse`, `:primary`, `:secondary`, `:success`, `:tertiary`, or `:warning`. |
| `color` | Symbol | Text color. One of `:icon_danger`, `:icon_info`, `:icon_primary`, `:icon_secondary`, `:icon_success`, `:icon_tertiary`, `:icon_warning`, `:text_danger`, `:text_inverse`, `:text_link`, `:text_primary`, `:text_secondary`, `:text_success`, `:text_tertiary`, `:text_warning`, or `:text_white`. |

## Flex

| Name | Type | Description |
| :- | :- | :- |
| `align_items` | Symbol | One of `:baseline`, `:center`, `:flex_end`, `:flex_start`, or `:stretch`. |
| `align_self` | Symbol | One of `:auto`, `:baseline`, `:center`, `:end`, `:start`, or `:stretch`. |
| `direction` | Symbol | One of `:column`, `:column_reverse`, `:row`, or `:row_reverse`. |
| `flex` | Integer, Symbol | One of `1` and `:auto`. |
| `flex_grow` | Integer | To enable, set to `0`. |
| `flex_shrink` | Integer | To enable, set to `0`. |
| `flex_wrap` | Symbol | One of `:nowrap`, `:reverse`, or `:wrap`. |
| `justify_content` | Symbol | One of `:center`, `:flex_end`, `:flex_start`, `:space_around`, or `:space_between`. |
| `width` | Symbol | One of `:fit`. |

## Grid

| Name | Type | Description |
| :- | :- | :- |
| `clearfix` | Boolean | Wether to assign the `clearfix` class. |
| `col` | Integer | Number of columns. One of `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `container` | Symbol | Size of the container. One of `:lg`, `:md`, `:sm`, or `:xl`. |

## Layout

| Name | Type | Description |
| :- | :- | :- |
| `display` | Symbol | One of `:block`, `:flex`, `:inline`, `:inline_block`, `:inline_flex`, `:none`, `:table`, or `:table_cell`. |
| `height` | Symbol | One of `:fit`. |
| `hide` | Symbol | Hide the element at a specific breakpoint. One of `:lg`, `:md`, `:sm`, or `:xl`. |
| `v` | Symbol | Visibility. One of `:hidden` and `:visible`. |
| `vertical_align` | Symbol | One of `:baseline`, `:bottom`, `:middle`, `:text_bottom`, `:text_top`, or `:top`. |

## Position

| Name | Type | Description |
| :- | :- | :- |
| `bottom` | Boolean | If `false`, sets `bottom: 0`. |
| `float` | Symbol | One of `:left`, `:right`, or `:none`. |
| `left` | Boolean | If `false`, sets `left: 0`. |
| `position` | Symbol | One of `:absolute`, `:fixed`, or `:relative`. |
| `right` | Boolean | If `false`, sets `right: 0`. |
| `top` | Boolean | If `false`, sets `top: 0`. |

## Spacing

| Name | Type | Description |
| :- | :- | :- |
| `m` | Integer | Margin. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, or `:auto`. |
| `mb` | Integer | Margin bottom. One of `0`, `1`, `-1`, `2`, `-2`, `3`, `-3`, `4`, `-4`, `5`, `-5`, `6`, `-6`, `7`, `-7`, `8`, `-8`, `9`, `-9`, `10`, `-10`, `11`, `-11`, `12`, or `-12`. |
| `ml` | Integer | Margin left. One of `0`, `1`, `-1`, `2`, `-2`, `3`, `-3`, `4`, `-4`, `5`, `-5`, `6`, or `-6`. |
| `mr` | Integer | Margin right. One of `0`, `1`, `-1`, `2`, `-2`, `3`, `-3`, `4`, `-4`, `5`, `-5`, `6`, or `-6`. |
| `mt` | Integer | Margin top. One of `0`, `1`, `-1`, `2`, `-2`, `3`, `-3`, `4`, `-4`, `5`, `-5`, `6`, `-6`, `7`, `-7`, `8`, `-8`, `9`, `-9`, `10`, `-10`, `11`, `-11`, `12`, `-12`, or `:auto`. |
| `mx` | Integer | Horizontal margins. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, or `:auto`. |
| `my` | Integer | Vertical margins. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `p` | Integer | Padding. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, or `:responsive`. |
| `pb` | Integer | Padding bottom. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `pl` | Integer | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `pr` | Integer | Padding right. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `pt` | Integer | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |
| `px` | Integer | Horizontal padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `py` | Integer | Vertical padding. One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, or `12`. |

## Typography

| Name | Type | Description |
| :- | :- | :- |
| `font_family` | Symbol | Font weight. One of `:mono`. |
| `font_size` | String, Integer, Symbol | One of `0`, `1`, `2`, `3`, `4`, `5`, `6`, `00`, `:normal`, or `:small`. |
| `font_style` | Symbol | Font weight. One of `:italic`. |
| `font_weight` | Symbol | Font weight. One of `:bold`, `:emphasized`, `:light`, or `:normal`. |
| `text_align` | Symbol | Text alignment. One of `:center`, `:left`, or `:right`. |
| `text_transform` | Symbol | Text alignment. One of `:uppercase`. |
| `underline` | Boolean | Whether text should be underlined. |
| `word_break` | Symbol | Whether to break words on line breaks. Can only be `:break_all`. |

## Other

| Name | Type | Description |
| :- | :- | :- |
| classes | String | CSS class name value to be concatenated with generated Primer CSS classes. |
| test_selector | String | Adds `data-test-selector='given value'` in non-Production environments for testing purposes. |
