---
title: Subhead
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/subhead_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-subhead-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use the Subhead component for page headings.

## Examples

### Default

<Example src="<div class='Subhead hx_Subhead--responsive '>  <div class='Subhead-heading '>    My Heading</div>    <div class='Subhead-description '>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
<% end %>
```

### Without border

<Example src="<div class='Subhead hx_Subhead--responsive border-bottom-0 mb-0'>  <div class='Subhead-heading '>    My Heading</div>    <div class='Subhead-description '>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
  <% component.heading do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
<% end %>
```

### With actions

<Example src="<div class='Subhead hx_Subhead--responsive '>  <div class='Subhead-heading '>    My Heading</div>  <div class='Subhead-actions '>    <a href='http://www.google.com' role='button' class='btn btn-danger '>Action</a></div>  <div class='Subhead-description '>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
  <% component.actions do %>
    <%= render(
      Primer::ButtonComponent.new(
        tag: :a, href: "http://www.google.com", button_type: :danger
      )
    ) { "Action" } %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `spacious` | `Boolean` | `false` | Whether to add spacing to the Subhead. |
| `hide_border` | `Boolean` | `false` | Whether to hide the border under the heading. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Heading`

The heading

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `danger` | `Boolean` | N/A | Whether to style the heading as dangerous. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Actions

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Description`

The description

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
