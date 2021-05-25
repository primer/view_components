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

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### With divider

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--divided m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>    <div class='Layout-divider'></div>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(divider: true)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar placement

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-end mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(sidebar_placement: :start)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_placement: :end, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar widths

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebar-narrow mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebar-wide mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(sidebar_width: :default)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_width: :narrow, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_width: :wide, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Main widths

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-md'><div data-view-component='true' class='container-md'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-lg'><div data-view-component='true' class='container-lg'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-xl'><div data-view-component='true' class='container-xl'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(main_width: :full)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(main_width: :md, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(main_width: :lg, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(main_width: :xl, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Gutters

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--gutter-none mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--gutter-condensed mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--gutter-spacious mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(gutter: :default)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :none, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :condensed, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(gutter: :spacious, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Using containers

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div><div data-view-component='true' class='container-xl'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div></div><div data-view-component='true' class='container-lg'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div></div><div data-view-component='true' class='container-md'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div></div>" />

```erb

<%= render(Primer::Layout.new(container: :full)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :xl, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :lg, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(container: :md, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Flow row until

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--flowRow-until-md mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--flowRow-until-lg mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(flow_row_until: :sm)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(flow_row_until: :md, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(flow_row_until: :lg, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Density

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-3'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-sm-3 m-lg-4'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-sm-3 m-lg-4 m-xl-5'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new(density: :none)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(density: :compact)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(density: :normal)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(density: :relaxed)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Three column layout

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start m-0'>    <div data-view-component='true' class='Layout-main border'>      <div data-view-component='true' class='Layout Layout--sidebarPosition-end m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Metadata</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div></div>" />

```erb

<%= render(Primer::Layout.new) do |c| %>
  <% c.main(border: true) do %>
    <%= render(Primer::Layout.new(sidebar_placement: :end)) do |l| %>
      <% l.main(border: true) { "Main" } %>
      <% l.sidebar(border: true) { "Metadata" } %>
    <% end %>
  <% end %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `divider` | `Boolean` | `false` | Wether or not to add a divider between `main` and `sidebar`. |
| `density` | `Symbol` | `:none` | Margin around the `Layout`. |
| `container` | `Symbol` | `:full` | Container to wrap the `Layout` in. One of `:full`, `:xl`, `:lg`, or `:md`. |
| `gutter` | `Symbol` | `:default` | Space between `main` and `sidebar`. One of `:default`, `:none`, `:condensed`, or `:spacious`. |
| `flow_row_until` | `Symbol` | `:sm` | When the `Layout` should change from a row flow into a column flow. One of `:sm`, `:md`, or `:lg`. |
| `sidebar_width` | `Symbol` | `:default` | One of `:default`, `:narrow`, or `:wide`. |
| `sidebar_placement` | `Symbol` | `:start` | One of `:start` and `:end`. |
| `main_width` | `Symbol` | `:full` | One of `:full`, `:md`, `:lg`, or `:xl`. |
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
