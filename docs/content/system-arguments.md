---
title: System Arguments
---

All Primer ViewComponents accept a standard set of options called System Arguments, mimicking the [styled-system API](https://styled-system.com/table) [used by Primer React](https://primer.style/components/system-props).

Under the hood, System Arguments are [mapped](https://github.com/primer/view_components/blob/main/lib/primer/classify.rb) to Primer CSS classes, with any remaining options passed to Rails' [`content_tag`](https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag).


## Responsive values
To use different argument values across responsive breakpoints, pass an array with the four values required for `[none, small, medium, large]`. If no value is needed for a breakpoint, pass `nil`. For example:

```erb
<%= render Primer::HeadingComponent.new(mt: [0, nil, nil, 4]) do %>
  Hello world
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- |
| `m` | `Integer` | Margin. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mt` | `Integer` | Margin left. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mr` | `Integer` | Margin right. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mb` | `Integer` | Margin bottom. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `ml` | `Integer` | Margin left. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mx` | `Integer` | Horizontal margins. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, `6`, or `:auto`. |
| `my` | `Integer` | Vertical margins. One of `-6`, `-5`, `-4`, `-3`, `-2`, `-1`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `m` | `Integer` | Padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mt` | `Integer` | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mr` | `Integer` | Padding right. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mb` | `Integer` | Padding bottom. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `ml` | `Integer` | Padding left. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `mx` | `Integer` | Horizontal padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `my` | `Integer` | Vertical padding. One of `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `position` | `Symbol` | One of `:relative`, `:absolute`, or `:fixed`. |
| `top` | `Boolean` | If `false`, sets `top: 0`. |
| `right` | `Boolean` | If `false`, sets `right: 0`. |
| `bottom` | `Boolean` | If `false`, sets `bottom: 0`. |
| `left` | `Boolean` | If `false`, sets `left: 0`. |
| `display` | `Symbol` | One of `:block`, `:none`, `:inline`, `:inline_block`, `:table`, or `:table_cell`. |
| `hide` | `Symbol` | Hide the element at a specific breakpoint. One of `:sm`, `:md`, `:lg`, or `:xl`. |
| `vertical_align` | `Symbol` | One of `:baseline`, `:top`, `:middle`, `:bottom`, `:text_top`, or `:text_bottom`. |
| `float` | `Symbol` | One of `:left` and `:right`. |
| `font_size` | `String` | One of `00`, `0`, `1`, `2`, `3`, `4`, `5`, or `6`. |
| `tag` | `Symbol` | HTML tag name to be passed to `tag.send` |
| `classes` | `String` | CSS class name value to be concatenated with generated Primer CSS classes |
