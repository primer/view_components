---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-layout-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Examples

### Default

<Example src="  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
```

### With divider

<Example src="  <div data-view-component='true' class='Layout Layout--divided'>    <div data-view-component='true' class='Layout-main'>Main</div>    <div class='Layout-divider'></div>    <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(divider: true)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
```

### Sidebar widths

<Example src="  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebar-narrow'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebar-wide'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(sidebar_width: :default)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_width: :narrow)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_width: :wide)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
```

### Gutters

<Example src="  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--gutter-none'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--gutter-condensed'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--gutter-spacious'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(gutter: :default)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :none)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :condensed)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :spacious)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
```

### Using containers

<Example src="  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div><div data-view-component='true' class='container-xl'>  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div></div><div data-view-component='true' class='container-lg'>  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div></div><div data-view-component='true' class='container-md'>  <div data-view-component='true' class='Layout'>    <div data-view-component='true' class='Layout-main'>Main</div>        <div data-view-component='true' class='Layout-sidebar'>Sidebar</div></div></div>" />

```erb

<%= render(Primer::Layout.new(container: :full)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :xl)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :lg)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :md)) do |c| %>
  <% c.main { "Main" } %>
  <% c.sidebar { "Sidebar" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `container` | `Symbol` | `:full` | Container to wrap the layout in. One of `:full`, `:xl`, `:lg`, or `:md`. |
| `sidebar_width` | `Symbol` | `:default` | One of `:default`, `:narrow`, or `:wide`. |
| `gutter` | `Symbol` | `:default` | Space between `main` and `sidebar`. One of `:default`, `:none`, `:condensed`, or `:spacious`. |
| `divider` | `Boolean` | `false` | Wether or not to add a divider between `main` and `sidebar`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The layout's main content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Sidebar`

The layout's sidebar.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
