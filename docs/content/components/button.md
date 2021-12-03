---
title: Button
componentId: button
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Button` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:danger`, `:default`, `:invisible`, `:link`, `:outline`, or `:primary`. |
| `variant` | `Symbol` | `:medium` | One of `:medium` and `:small`. |
| `tag` | `Symbol` | `:button` | One of `:a`, `:button`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
| `block` | `Boolean` | `false` | Whether button is full-width with `display: block`. |
| `dropdown` | `Boolean` | `false` | Whether or not to render a dropdown caret. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Leading_visual`

Leading visuals appear to the left of the button text.

Use:

- `leading_visual_icon` for a [Octicon](/components/octicon).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | Same arguments as [Octicon](/components/octicon). |

### `Trailing_visual`

Trailing visuals appear to the right of the button text.

Use:

- `trailing_visual_counter` for a [Counter](/components/counter).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | Same arguments as [Counter](/components/counter). |

## Examples

### Schemes

<Example src="<button type='button' data-view-component='true' class='btn'>  Default</button><button type='button' data-view-component='true' class='btn-primary btn'>  Primary</button><button type='button' data-view-component='true' class='btn-danger btn'>  Danger</button><button type='button' data-view-component='true' class='btn-outline btn'>  Outline</button><button type='button' data-view-component='true' class='btn-invisible btn'>  Invisible</button><button type='button' data-view-component='true' class='btn-link'>  Link</button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(scheme: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(scheme: :outline)) { "Outline" } %>
<%= render(Primer::ButtonComponent.new(scheme: :invisible)) { "Invisible" } %>
<%= render(Primer::ButtonComponent.new(scheme: :link)) { "Link" } %>
```

### Variants

<Example src="<button type='button' data-view-component='true' class='btn-sm btn'>  Small</button><button type='button' data-view-component='true' class='btn'>  Medium</button>" />

```erb
<%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
<%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
```

### Block

<Example src="<button type='button' data-view-component='true' class='btn btn-block'>  Block</button><button type='button' data-view-component='true' class='btn-primary btn btn-block'>  Primary block</button>" />

```erb
<%= render(Primer::ButtonComponent.new(block: :true)) { "Block" } %>
<%= render(Primer::ButtonComponent.new(block: :true, scheme: :primary)) { "Primary block" } %>
```

### With leading visual

<Example src="<button type='button' data-view-component='true' class='btn'>  <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-star mr-2'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>Button</button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.leading_visual_icon(icon: :star) %>
  Button
<% end %>
```

### With trailing visual

<Example src="<button type='button' data-view-component='true' class='btn'>  Button<span title='15' data-view-component='true' class='Counter ml-2'>15</span></button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.trailing_visual_counter(count: 15) %>
  Button
<% end %>
```

### With leading and trailing visuals

<Example src="<button type='button' data-view-component='true' class='btn'>  <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-star mr-2'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>Button<span title='15' data-view-component='true' class='Counter ml-2'>15</span></button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.leading_visual_icon(icon: :star) %>
  <% c.trailing_visual_counter(count: 15) %>
  Button
<% end %>
```

### With dropdown caret

<Example src="<button type='button' data-view-component='true' class='btn'>  Button<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-triangle-down mr-n1'>    <path d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z'></path></svg></button>" />

```erb
<%= render(Primer::ButtonComponent.new(dropdown: true)) do %>
  Button
<% end %>
```
