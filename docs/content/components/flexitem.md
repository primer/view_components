---
title: FlexItem
componentId: flex_item
status: Deprecated
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_item_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-flex-item-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `FlexItem` to specify the ability of a flex item to alter its
dimensions to fill available space.

## Deprecation

Use [Box](/components/box) instead.

**Before**:

```erb
<%= render Primer::FlexItemComponent.new(flex_auto: :auto) %>
```

**After**:

```erb
<%= render Primer::BoxComponent.new(flex: :auto) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `flex_auto` | `Boolean` | `false` | Fills available space and auto-sizes based on the content. Defaults to false |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='d-flex'>  <div data-view-component='true'>    Item 1</div>  <div data-view-component='true' class='flex-auto'>    Item 2</div></div>" />

```erb
<%= render(Primer::FlexComponent.new) do %>
  <%= render(Primer::FlexItemComponent.new) do %>
    Item 1
  <% end %>

  <%= render(Primer::FlexItemComponent.new(flex_auto: true)) do %>
    Item 2
  <% end %>
<% end %>
```
