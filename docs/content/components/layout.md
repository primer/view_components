---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-layout-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

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

## Examples

### Default

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

```erb

<%= render(Primer::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### With divider

If `gutter` is present, its spacing is presented before and after the divider.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--divided m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>    <div class='Layout-divider'></div>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

```erb
<%= render(Primer::Layout.new(with_divider: true)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Divider variants

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--divided m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>    <div class='Layout-divider'></div>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--divided mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>    <div class='Layout-divider Layout-divider--flowRow-hidden'></div>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--divided mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>    <div class='Layout-divider Layout-divider--flowRow-shallow'></div>    <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

```erb

<%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :visible)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :hidden, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :shallow, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar placement

Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-end Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

### Sidebar placement as row

When flowing as a row, whether the sidebar is rendered first or last in the layout, or, if it's entirely hidden from the user.

When `hidden`, make sure the experience is not degraded on smaller screens, and the user can still access the sidebar content somehow.
For instance, the user may not see a Settings navigation sidebar when drilled down on a page, but they can still navigate to the Settings
landing page to interact with the local navigation.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-end mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-none mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

```erb
<%= render(Primer::Layout.new(sidebar_flow_row_placement: :start)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_flow_row_placement: :end, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
<%= render(Primer::Layout.new(sidebar_flow_row_placement: :none, mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.sidebar(border: true) { "Sidebar" } %>
<% end %>
```

### Sidebar widths

Sets the sidebar width. The width is predetermined according to the breakpoint instead of it being percentage-based.

- `default`: [md: 256px, lg: 296px, xl: 320px]
- `narrow`: [md: 240px, lg: 256px, xl: 296px]
- `wide`: [md: 296px, lg: 320px, xl: 344px]

When flowing as a row, `Sidebar` takes the full width.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--sidebar-narrow mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--sidebar-wide mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

When `full`, the main column will stretch to cover all the available width.
Otherwise, the main column will try to be centered in the screen; it may appear aligned to the left when there isn't enough space.

Use smaller maximum widths in the main column to facilitate interface scanning and reading.

When flowing as a row, `Main` takes the full width.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-md'><div data-view-component='true' class='container-md'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-lg'><div data-view-component='true' class='container-lg'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'><div data-view-component='true' class='Layout-main-centered-xl'><div data-view-component='true' class='container-xl'>Main</div></div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

How much spacing to include between `Main` and `Sidebar` when flowing as columns.

- `default`: [md: 16px, lg: 24px]
- `none`: 0px
- `condensed` 16px
- `spacious` [md: 16px, lg: 32px, xl: 40px]

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--gutter-none mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--gutter-condensed mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--gutter-spacious mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

If `full`, the `Layout` component is applied edge-to-edge.
Otherwise, the output is wrapped on a `container-**` class that centers `Layout` on the page and limits its maximum width.
See [containers reference](https://primer.style/css/objects/grid#containers) for more details.
When flowing as a row, `Container` always takes the full width.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div><div data-view-component='true' class='container-xl'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div></div><div data-view-component='true' class='container-lg'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div></div><div data-view-component='true' class='container-md'>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div></div>" />

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

You can specify when the `Layout` should change from column into row.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--flowRow-until-md mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start Layout--flowRow-until-lg mt-5 m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

Sets the outside margin of the `Layout` component.

- `none`: 0
- `compact`: 16px
- `normal`: [sm: 16px, lg: 24px]
- `relaxed`: [sm: 16px, lg: 24px, xl: 32px]

Use a value other than `none` when `Layout` is a top-level container for the entire page, and `Main` and `Sidebar` don't have custom padding.

When flowing as a row, `margin` always uses `16px` if not set to `none`.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-3'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-sm-3 m-lg-4'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-sm-3 m-lg-4 m-xl-5'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

`Layouts` can be nested to create 3-column pages.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>      <div data-view-component='true' class='Layout Layout--sidebarPosition-end Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main</div>        <div data-view-component='true' class='Layout-sidebar border'>Metadata</div>    </div></div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar</div>    </div>" />

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

### HTML ordering

The order in which slots are called matter to define their order in the resulting HTML.
This affects keyboard navigation, since the keyboard focus follows the element order.
The resulting visual position is not affected.

<Example src="  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start m-0'>    <div data-view-component='true' class='Layout-main border'>Main first</div>        <div data-view-component='true' class='Layout-sidebar border'>Sidebar second</div>    </div>  <div data-view-component='true' class='Layout Layout--sidebarPosition-start Layout--sidebarPosition-flowRow-start mt-3 m-0'>            <div data-view-component='true' class='Layout-sidebar border'>Sidebar first</div>    <div data-view-component='true' class='Layout-main border'>Main second</div></div>" />

```erb
<%= render(Primer::Layout.new) do |c| %>
  <% c.main(border: true) { "Main first" } %>
  <% c.sidebar(border: true) { "Sidebar second" } %>
<% end %>
<%= render(Primer::Layout.new(mt: 3)) do |c| %>
  <% c.sidebar(border: true) { "Sidebar first" } %>
  <% c.main(border: true) { "Main second" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `density` | `Symbol` | `:none` | Margin around the `Layout`. |
| `container` | `Symbol` | `:full` | Container to wrap the `Layout` in. One of `:full`, `:xl`, `:lg`, or `:md`. |
| `gutter` | `Symbol` | `:default` | Space between `main` and `sidebar`. One of `:default`, `:none`, `:condensed`, or `:spacious`. |
| `flow_row_until` | `Symbol` | `:sm` | When the `Layout` should change from a row flow into a column flow. One of `:sm`, `:md`, or `:lg`. |
| `sidebar_width` | `Symbol` | `:default` | One of `:default`, `:narrow`, or `:wide`. |
| `sidebar_placement` | `Symbol` | `:start` | One of `:start` and `:end`. |
| `sidebar_flow_row_placement` | `Symbol` | `:start` | Sidebar placement when `Layout` is flowing as row. One of `:start`, `:end`, or `:none`. |
| `main_width` | `Symbol` | `:full` | One of `:full`, `:md`, `:lg`, or `:xl`. |
| `with_divider` | `Boolean` | `false` | Wether or not to add a divider between `main` and `sidebar`. |
| `divider_flow_row_variant` | `Symbol` | `:visible` | Variants for the divider when `Layout` is flowing as row. One of `:visible`, `:hidden`, or `:shallow`. |
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
