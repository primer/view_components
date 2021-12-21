---
title: ProgressBar
componentId: progress_bar
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/progress_bar_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-progress-bar-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `ProgressBar` to visualize task completion.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `size` | `Symbol` | `:default` | One of `:default`, `:large`, or `:small`. Increases height. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

Use the Item slot to add an item to the progress bas

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `percentage` | `Integer` | N/A | The percent complete |
| `bg` | `Symbol` | N/A | The background color |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |

## Examples

### Default

<Example src="<span data-view-component='true' class='Progress'>    <span style='width: 25%;' data-view-component='true' class='Progress-item color-bg-success-emphasis'></span></span>" />

```erb
<%= render(Primer::ProgressBarComponent.new) do |component| %>
  <% component.item(percentage: 25) %>
<% end %>
```

### Small

<Example src="<span data-view-component='true' class='Progress Progress--small'>    <span style='width: 50%;' data-view-component='true' class='Progress-item color-bg-accent-emphasis'></span></span>" />

```erb
<%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
  <% component.item(bg: :accent_emphasis, percentage: 50) %>
<% end %>
```

### Large

<Example src="<span data-view-component='true' class='Progress Progress--large'>    <span style='width: 75%;' data-view-component='true' class='Progress-item color-bg-danger-emphasis'></span></span>" />

```erb
<%= render(Primer::ProgressBarComponent.new(size: :large)) do |component| %>
  <% component.item(bg: :danger_emphasis, percentage: 75) %>
<% end %>
```

### Multiple items

<Example src="<span data-view-component='true' class='Progress'>    <span style='width: 10%;' data-view-component='true' class='Progress-item color-bg-success-emphasis'></span>    <span style='width: 20%;' data-view-component='true' class='Progress-item color-bg-accent-emphasis'></span>    <span style='width: 30%;' data-view-component='true' class='Progress-item color-bg-danger-emphasis'></span></span>" />

```erb
<%= render(Primer::ProgressBarComponent.new) do |component| %>
  <% component.item(percentage: 10) %>
  <% component.item(bg: :accent_emphasis, percentage: 20) %>
  <% component.item(bg: :danger_emphasis, percentage: 30) %>
<% end %>
```
