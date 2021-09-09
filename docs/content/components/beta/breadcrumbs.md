---
title: Breadcrumbs
componentId: breadcrumbs
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/breadcrumbs.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-breadcrumbs
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Breadcrumbs` to display page hierarchy.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | The URL to link to. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Basic

<Example src="<nav aria-label='Breadcrumb' data-view-component='true'>  <ol>      <li data-view-component='true' class='breadcrumb-item'><a href='/' data-view-component='true'>Home</a></li>      <li data-view-component='true' class='breadcrumb-item'><a href='/about' data-view-component='true'>About</a></li>      <li data-view-component='true' class='breadcrumb-item  breadcrumb-item-selected'><a aria-current='page' href='/about/team' data-view-component='true' class='breadcrumb-item-selected'>Team</a></li>  </ol></nav>" />

```erb
<%= render(Primer::Beta::Breadcrumbs.new) do |component| %>
  <% component.item(href: "/") do %>Home<% end %>
  <% component.item(href: "/about") do %>About<% end %>
  <% component.item(href: "/about/team") do %>Team<% end %>
<% end %>
```
