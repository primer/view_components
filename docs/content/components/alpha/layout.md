---
title: Layout
componentId: layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-layout
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Layout` provides foundational patterns for responsive pages.
`Layout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.
 On smaller screens, `Layout` uses vertically stacked rows to display content.

`Layout` flows as both column, when there's enough horizontal space to render both `Main` and `Sidebar`side-by-side (on a desktop of tablet device, per instance);
or it flows as a row, when `Main` and `Sidebar` are stacked vertically (e.g. on a mobile device).
`Layout` should always work in any screen size.

## Accessibility

Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
`main` or `sidebar` comes first in code. The code order won’t affect the visual position.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `stacking_breakpoint` | `Symbol` | `:md` | When the `Layout` should change from rows into columns. One of `:lg`, `:md`, or `:sm`. |
| `first_in_source` | `Symbol` | `:sidebar` | Which element to render first in the HTML. This will change the keyboard navigation order. One of `:main` and `:sidebar`. |
| `gutter` | `Symbol` | `:default` | The amount of space between the main section and the sidebar. One of `:condensed`, `:default`, `:none`, or `:spacious`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The layout's main content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:full`, `:lg`, `:md`, or `:xl`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Sidebar`

The layout's sidebar.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `col_placement` | `Symbol` | N/A | Sidebar placement when `Layout` is in column modes. One of `:end` and `:start`. |
| `row_placement` | `Symbol` | N/A | Sidebar placement when `Layout` is in row mode. One of `:end`, `:none`, or `:start`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div>" />

```erb

<%= render(Primer::Alpha::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Main widths

When `full`, the main column will stretch to cover all the available width. Otherwise, the main column will try to be centered in the screen; it may appear aligned to the left when there isn't enough space. Use smaller maximum widths in the main column to facilitate interface scanning and reading. When flowing as a row, `Main` takes the full width.

<Example src="<div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-md'><div data-view-component='true' class='container-md'>Main</div></div></div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-lg'><div data-view-component='true' class='container-lg'>Main</div></div></div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-xl'><div data-view-component='true' class='container-xl'>Main</div></div></div></div>" />

```erb
<%= render(Primer::Alpha::Layout.new) do |c| %>
  <% c.main(width: :full, border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(width: :md, border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(width: :lg, border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(width: :xl, border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar widths

Sets the sidebar width. The width is predetermined according to the breakpoint instead of it being percentage-based. - `default`: [md: 256px, lg: 296px, xl: 320px] - `narrow`: [md: 240px, lg: 256px, xl: 296px] - `wide`: [md: 296px, lg: 320px, xl: 344px] When flowing as a row, `Sidebar` takes the full width.

<Example src="<div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--sidebar-narrow mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--sidebar-wide mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div>" />

```erb
<%= render(Primer::Alpha::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(width: :default, border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(width: :narrow, border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(width: :wide, border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar placement

Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.

<Example src="<div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-end Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div>" />

```erb
<%= render(Primer::Alpha::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(col_placement: :start, border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new( mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(col_placement: :end, border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar placement as row

When flowing as a row, whether the sidebar is rendered first or last in the layout, or, if it's entirely hidden from the user. When `hidden`, make sure the experience is not degraded on smaller screens, and the user can still access the sidebar content somehow. For instance, the user may not see a Settings navigation sidebar when drilled down on a page, but they can still navigate to the Settings landing page to interact with the local navigation.

<Example src="<div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-end mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-none mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div>" />

```erb
<%= render(Primer::Alpha::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(row_placement: :start, border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(row_placement: :end, border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(row_placement: :none, border: true) { "Sidebar" } %>
<% end %>
```

### Changing when to render `Layout` as columns

You can specify when the `Layout` should change from rows into columns. Any screen size before this breakpoint will render the `Layout` in stacked rows.

<Example src="<div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-md Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div><div data-view-component='true' class='Layout Layout--flowRow-until-lg Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5'>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>  <div data-view-component='true' class='Layout-main border'>Main</div></div>" />

```erb
<%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :sm)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :md, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :lg, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```
