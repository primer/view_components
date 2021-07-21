---
title: Truncate
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/truncate.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-truncate
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Truncate` to shorten overflowing text with an ellipsis.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

Text slot used for the truncated text.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `priority` | `Boolean` | N/A | if true, the text will be given priority |
| `expandable` | `Boolean` | N/A | if true, the text will expand on hover or focus |
| `max_width` | `Integer` | N/A | if provided, the text will be truncated at a maximum width |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<span data-view-component='true' class='Truncate'>    <span data-view-component='true' class='Truncate-text'>branch-name-that-is-really-long</span></span>" />

```erb
<%= render(Primer::Alpha::Truncate.new) { "branch-name-that-is-really-long" } %>
```

### Multiple items

<Example src="<span data-view-component='true' class='Truncate'>    <span data-view-component='true' class='Truncate-text'>really-long-repository-owner-name</span>    <span data-view-component='true' class='Truncate-text text-bold'>    <span data-view-component='true' class='text-normal'>/</span> really-long-repository-name</span></span>" />

```erb
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item do %>really-long-repository-owner-name<% end %>
  <% component.item(font_weight: :bold) do %>
    <%= render(Primer::BaseComponent.new(tag: :span, font_weight: :normal)) { "/" } %> really-long-repository-name
  <% end %>
<% end %>
```

### Advanced multiple items

<Example src="<ol data-view-component='true' class='Truncate'>    <li data-view-component='true' class='Truncate-text'>primer</li>    <li data-view-component='true' class='Truncate-text Truncate-text--primary'>/ css</li>    <li data-view-component='true' class='Truncate-text'>/ Issues</li>    <li data-view-component='true' class='Truncate-text'>/ #123 —</li>    <li data-view-component='true' class='Truncate-text Truncate-text--primary'>    Visual bug on primer.style found in lists</li></ol>" />

```erb
<%= render(Primer::Alpha::Truncate.new(tag: :ol)) do |component| %>
  <% component.item(tag: :li) do %>primer<% end %>
  <% component.item(tag: :li, priority: true) do %>/ css<% end %>
  <% component.item(tag: :li) do %>/ Issues<% end %>
  <% component.item(tag: :li) do %>/ #123 —<% end %>
  <% component.item(tag: :li, priority: true) do %>
    Visual bug on primer.style found in lists
  <% end %>
<% end %>
```

### Expand on hover or focus

<Example src="<span data-view-component='true' class='Truncate'>    <a href='#' data-view-component='true' class='Truncate-text Truncate-text--expandable'>really-long-repository-owner-name</a>    <a href='#' data-view-component='true' class='Truncate-text Truncate-text--expandable'>really-long-repository-owner-name</a>    <a href='#' data-view-component='true' class='Truncate-text Truncate-text--expandable'>really-long-repository-owner-name</a>    <a href='#' data-view-component='true' class='Truncate-text Truncate-text--expandable'>really-long-repository-owner-name</a></span>" />

```erb
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
  <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
  <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
  <% component.item(tag: :a, href: "#", expandable: true) do %>really-long-repository-owner-name<% end %>
<% end %>
```

### Max widths

<Example src="<span data-view-component='true' class='Truncate'>    <span style='max-width: 300px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span>    <span style='max-width: 200px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span>    <span style='max-width: 100px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span></span>" />

```erb
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
  <% component.item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
  <% component.item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
<% end %>
```

### Max widths on new lines

<Example src="<span data-view-component='true' class='Truncate'>    <span style='max-width: 300px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span></span><br/><span data-view-component='true' class='Truncate'>    <span style='max-width: 200px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span></span><br/><span data-view-component='true' class='Truncate'>    <span style='max-width: 100px;' data-view-component='true' class='Truncate-text Truncate-text--expandable'>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long</span></span>" />

```erb
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item(max_width: 300, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
<% end %>
<br/>
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item(max_width: 200, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
<% end %>
<br/>
<%= render(Primer::Alpha::Truncate.new) do |component| %>
  <% component.item(max_width: 100, expandable: true) do %>branch-name-that-is-really-long-branch-name-that-is-really-long-branch-name-that-is-really-long<% end %>
<% end %>
```
