---
title: Style arguments
---

Primer ViewComponents should be styled using the built-in arguments when possible. Most Primer utility classes for spacing, alignment, display, and colors have equivalent component arguments.

Example label built with Primer CSS:

```html
<span title="Label: Suggested" class="Label Label--outline Label--outline-green ml-2 v-align-middle">Suggested</span>
```

The same label using `Primer::LabelComponent`:

```erb
<%= render Primer::LabelComponent.new(ml: 2, vertical_align: :middle, scheme: :green, title: "Label: Suggested") do %>
  Suggested
<% end %>
```

Some components have their own specific arguments, but they can all be styled with the following arguments.

| Component argument | Primer class    | Example |
| --------------- | --------------- | -------- |
| `m`            | `m-<value>`     | `m: 4` → `.m-4` |
| `my`            | `my-<value>`   | `my: 4` → `.my-4` |
| `mx`            | `my-<value>`   | `mx: 4` → `.mx-4` |
| `mt`            | `mt-<value>`   | `mt: 4` → `.mt-4` |
| `mb`            | `mb-<value>`   | `mb: 4` → `.mb-4` |
| `ml`            | `ml-<value>`   | `ml: 4` → `.ml-4` |
| `mr`            | `mr-<value>`   | `mr: 4` → `.mr-4` |
| `p`             | `p-<value>`    | `p: 4` → `.p-4` |
| `py`            | `py-<value>`   | `py: 4` → `.py-4` |
| `px`            | `py-<value>`   | `px: 4` → `.px-4` |
| `pt`            | `pt-<value>`   | `pt: 4` → `.pt-4` |
| `pb`            | `pb-<value>`   | `pb: 4` → `.pb-4` |
| `pl`            | `pl-<value>`   | `pl: 4` → `.pl-4` |
| `pr`            | `pr-<value>`   | `pr: 4` → `.pr-4` |
| `pr`            | `pr-<value>`   | `pr: 4` → `.pr-4` |
| `f`            | `f-<value>`   | `f: 4` → `.f-4` |
| `color`            | `color-<value>`   | `color: :red_500` → `.color-red-500` |
| `text`         | `text-<value>`   | `text: :green` → `.text-green` |
| `bg`         | `bg-<value>`   | `bg: :blue_light` → `.bg-blue-light` |
| `display`     | `d-<value>` | `display: :none` → `.d-none` |
| `float`         | `float-<value>`   | `float: :right` → `.float-right` |
| `vertical_align`         | `v-align-<value>`   | `vertical_align: :baseline` → `.v-align-baseline` |
| `text_align`     | `text-<value>` | `text_align: :right` → `.text-right` |
| `font_size`     | `f<value>` | `font_size: 4` → `.f4` |
| `font_weight`     | `text-<value>` | `font_weight: :bold` → `.text-bold` |
| `border`     | `border-<value>` | `border: :bottom` → `.border-bottom` |
| `border_color`     | `border-<value>` | `border: :green` → `.border-green` |
| `border_top`     | `border-top-<value>` | `border_top: 0` → `.border-top-0` |
| `border_bottom`     | `border-bottom-<value>` | `border_bottom: 0` → `.border-bottom-0` |
| `border_left`     | `border-left-<value>` | `border_left: 0` → `.border-left-0` |
| `border_right`     | `border-right-<value>` | `border_right: 0` → `.border-right-0` |
| `word_break`     | `wb-<value>` | `word_break: :break_all` → `.wb-break-all` |
| `direction`     | `flex-<value>` | `direction: :row` → `.flex-row` |
| `justify_content`    | `flex-justify-<value>` | `justify_content: :center` → `.flex-justify-center` |
| `align_items`   | `flex-items-<value>` | `align_items: :baseline` → `.flex-items-baseline` |
| `box_shadow` | `box-shadow-<value>` | `box_shadow: :medium` → `.box-shadow-medium` |

## Boolean arguments

| Component arguments | True    | False |
| -------------- | ------- | ------ |
| `underline`   | `underline: true` → `.text-underline`  | `underline: false` → `.no-underline` |
| `top`    | n/a | `top: false` → `.top-0`  |
| `bottom` | n/a | `bottom: false` → `.bottom-0`  |
| `left`   | n/a | `left: false` → `.left-0`  |
| `right`  | n/a | `right: false` → `.right-0`  |

## Responsive arguments

Different classes can be used for different breakpoints just like in Primer CSS. Simply use an array with the four values required for `[none, small, medium, large]`. If no breakpoint is needed for a breakpoint, pass `nil`.

Example heading built with Primer CSS:

```html
<h1 class="mt-0 mt-lg-4">Hello world</h1>
```

The same label using `Primer::HeadingComponent`:

```erb
<%= render Primer::HeadingComponent.new(mt: [0, nil, nil, 4]) do %>
  Hello world
<% end %>
```
