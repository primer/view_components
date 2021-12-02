---
title: Layout
componentId: layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-layout
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Layout` provides foundational patterns for responsive pages.
`Layout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.
 On smaller screens, `Layout` uses vertically stacked rows to display content.

`Layout` flows as both column, when there's enough horizontal space to render both `Main` and `Pane`side-by-side (on a desktop of tablet device, per instance);
or it flows as a row, when `Main` and `Pane` are stacked vertically (e.g. on a mobile device).
`Layout` should always work in any screen size.

`Layout` also provides `Header` and `Footer` slots, which can be used to provide a consistent header and footer across all pages.

## Accessibility

Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
`main` or `pane` comes first in code. The code order won’t affect the visual position.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `wrapper_sizing` | `Symbol` | `:fluid` | The size of the container wrapping `Layout`. One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `outer_spacing` | `Symbol` | `:none` | Sets wrapper margins surrounding the component to distance itself from the viewport edges. One of `:condensed`, `:none`, or `:normal`. |
| `inner_spacing` | `Symbol` | `:none` | Sets padding to regions individually. One of `:condensed`, `:none`, or `:normal`. |
| `column_gap` | `Symbol` | `:none` | Sets gap between columns. One of `:condensed`, `:none`, or `:normal`. |
| `row_gap` | `Symbol` | `:none` | Sets the gap below the header and above the footer. One of `:condensed`, `:none`, or `:normal`. |
| `responsive_behavior` | `Symbol` | `:flow_vertical` | `responsive_behavior` defines how the layout component adapts to smaller viewports. `:flow_vertical` presents the content in a vertical flow, with pane and content vertically arranged. `:split_as_pages` presents pane and content as different pages on smaller viewports. One of `:flow_vertical` and `:split_as_pages`. |
| `responsive_show_pane_first` | `Boolean` | `false` | Defines if the pane should be shown first in the responsive layout. If `responsive_behavior` is set to `:flow_vertical`, pane appears above content. If set to `split_as_pages`, pane will appear as a landing page. Use only in the first page of the section. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The layout's main content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:full`, `:lg`, `:md`, or `:xl`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Pane`

The layout's sidebar.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `position` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end` and `:start`. |
| `responsive_position` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end`, `:inherit`, or `:start`. |
| `divider` | `Boolean` | N/A | Whether to show a pane line divider. |
| `sticky` | `Boolean` | N/A | Whether to make the pane sticky. Don’t use it in the presence of footer regions. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Header`

The layout's header.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `divider` | `Boolean` | N/A | Whether to show a header divider |
| `responsive_divider` | `Boolean` | N/A | Whether to show a divider below the `header` region if in responsive mode |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Footer`

The layout's footer.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `divider` | `Boolean` | N/A | Whether to show a footer divider |
| `responsive_divider` | `Boolean` | N/A | Whether to show a divider below the `footer` region if in responsive mode |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb

<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Header and footer

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--has-header LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start LayoutBeta--has-footer'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div divider='false' data-view-component='true' class='LayoutBeta-header LayoutBeta-region border'>Header</div>      <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div divider='false' data-view-component='true' class='LayoutBeta-footer LayoutBeta-region border'>Footer</div></div></div>" />

```erb

<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.header(border: true) { "Header" } %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
  <% c.footer(border: true) { "Footer" } %>
<% end %>
```

### Wrapper sizing

When `:fluid` the layout will be set to full width. When the other sizing options are used the layout will be centered with corresponding widths. - `:fluid`: full width - `:md`: max-width: 768px - `:lg`: max-width: 1012px - `:xl`: max-width: 1280px

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions container-md'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions container-lg'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions container-xl'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(wrapper_sizing: :fluid)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(wrapper_sizing: :md)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(wrapper_sizing: :lg)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(wrapper_sizing: :xl)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Outer spacing

Sets wrapper margins surrounding the component to distance itself from the viewport edges. - `:none`` sets the margin to 0. - `:condensed` keeps the margin at 16px. - `:normal`` sets the margin to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--outer-spacing-condensed LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--outer-spacing-normal LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(outer_spacing: :none)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(outer_spacing: :condensed)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(outer_spacing: :normal)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Inner spacing

Sets padding to regions individually. - `:none` sets the padding to 0. - `:condensed`` keeps the padding always at 16px. - `:normal` sets padding to 16px, with the content region getting 24px horizontal padding on lg breakpoints and above.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-condensed LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-normal LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(inner_spacing: :none)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(inner_spacing: :condensed)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(inner_spacing: :normal)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Column gap

Sets the gap between columns to distance them from each other. - `:none` sets the gap to 0. - `:condensed` keeps the gap always at 16px. - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--column-gap-condensed LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--column-gap-normal LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(column_gap: :none)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(column_gap: :condensed)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(column_gap: :normal)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Row gap

Sets the gap below the header and above the footer. - `:none` sets the gap to 0. - `:condensed` keeps the gap always at 16px. - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--row-gap-condensed LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--row-gap-normal LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(row_gap: :none)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(row_gap: :condensed)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(row_gap: :normal)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Pane widths

Sets the pane width. The width is predetermined according to the breakpoint instead of it being percentage-based. - `default`: - `narrow`: - `wide`: When flowing as a row, `Pane` takes the full width.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start LayoutBeta--pane-width-narrow mt-5'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start LayoutBeta--pane-width-wide mt-5'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :default, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :narrow, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :wide, border: true) { "Pane" } %>
<% end %>
```

### Pane position

Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-end LayoutBeta--pane-responsive-position-end mt-5'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(position: :start, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new( mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(position: :end, border: true) { "Pane" } %>
<% end %>
```

### Pane resposive position

Defines the position of the pane in the responsive layout. - `:start` puts the pane above content - `:end` puts it below content. - `:inherit` uses the same value from `pane_position`

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start mt-5'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div pane_responsive_position='inherit' data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div pane_responsive_position='start' data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start mt-5'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div pane_responsive_position='end' data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(pane_responsive_position: :inherit, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(pane_responsive_position: :start, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(pane_responsive_position: :end, border: true) { "Pane" } %>
<% end %>
```

### Header

You can add an optional header to the layout and have spacing and positioning taken care of for you. You can optionally add a divider to the header.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--has-header LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div divider='false' data-view-component='true' class='LayoutBeta-header LayoutBeta-region border'>Header</div>      <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--has-header LayoutBeta--header-divider LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div divider='true' data-view-component='true' class='LayoutBeta-header LayoutBeta-region border'>Header</div>      <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      </div></div>" />

```erb
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.header(border: true) { "Header" } %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.header(divider: true, border: true) { "Header" } %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Footer

You can add an optional footer to the layout and have spacing and positioning taken care of for you. You can optionally add a divider to the footer.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start LayoutBeta--has-footer'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div divider='false' data-view-component='true' class='LayoutBeta-footer LayoutBeta-region border'>Header</div></div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--responsive-flowVertical LayoutBeta--pane-position-start LayoutBeta--pane-responsive-position-start LayoutBeta--has-footer LayoutBeta--footer-divider'>    <div data-view-component='true' class='LayoutBeta-regions'>            <div data-view-component='true' class='LayoutBeta-content border'>Main</div>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div divider='true' data-view-component='true' class='LayoutBeta-footer LayoutBeta-region border'>Header</div></div></div>" />

```erb
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
  <% c.footer(border: true) { "Header" } %>
<% end %>
<%= render(Primer::Beta::Layout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
  <% c.footer(divider: true, border: true) { "Header" } %>
<% end %>
```
