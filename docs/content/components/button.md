---
title: Button
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Button` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Schemes

<Example src="<button type='button' class='btn'>    Default  </button><button type='button' class='btn-primary btn'>    Primary  </button><button type='button' class='btn-danger btn'>    Danger  </button><button type='button' class='btn-outline btn'>    Outline  </button><button type='button' class='btn-invisible btn'>    Invisible  </button><button type='button' class='btn-link'>    Link  </button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(scheme: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(scheme: :outline)) { "Outline" } %>
<%= render(Primer::ButtonComponent.new(scheme: :invisible)) { "Invisible" } %>
<%= render(Primer::ButtonComponent.new(scheme: :link)) { "Link" } %>
```

### Variants

<Example src="<button type='button' class='btn-sm btn'>    Small  </button><button type='button' class='btn'>    Medium  </button><button type='button' class='btn-large btn'>    Large  </button>" />

```erb
<%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
<%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
<%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
```

### Block

<Example src="<button type='button' class='btn btn-block'>    Block  </button><button type='button' class='btn-primary btn btn-block'>    Primary block  </button>" />

```erb
<%= render(Primer::ButtonComponent.new(block: :true)) { "Block" } %>
<%= render(Primer::ButtonComponent.new(block: :true, scheme: :primary)) { "Primary block" } %>
```

### With icons

<Example src="<button type='button' class='btn'>  <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-star'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>    Button  </button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.icon(icon: :star) %>
  Button
<% end %>
```

### With counter

<Example src="<button type='button' class='btn'>      Button  <span title='15' class='Counter'>15</span></button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.counter(count: 15) %>
  Button
<% end %>
```

### With icons and counter

<Example src="<button type='button' class='btn'>  <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-star'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>    Button  <span title='15' class='Counter'>15</span></button>" />

```erb
<%= render(Primer::ButtonComponent.new) do |c| %>
  <% c.icon(icon: :star) %>
  <% c.counter(count: 15) %>
  Button
<% end %>
```

### With caret

<Example src="<button type='button' class='btn'>      Button      <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-triangle-down'>    <path d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z'></path></svg></button>" />

```erb
<%= render(Primer::ButtonComponent.new(caret: true)) do %>
  Button
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:primary`, `:danger`, `:outline`, `:invisible`, or `:link`. |
| `variant` | `Symbol` | `:medium` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | N/A | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | N/A | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
| `block` | `Boolean` | `false` | Whether button is full-width with `display: block`. |
| `caret` | `Boolean` | `false` | Whether or not to render a caret. |

## Slots

### `Icon`

Icon to be rendered in the button.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | Same arguments as [Octicon](/components/octicon). |

### `Counter`

Counter to be rendered in the button.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | Same arguments as [Counter](/components/counter). |
