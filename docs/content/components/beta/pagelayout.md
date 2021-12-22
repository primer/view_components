---
title: PageLayout
componentId: page_layout
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/page_layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-page-layout
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`PageLayout` provides foundational patterns for responsive pages. `PageLayout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.

 On smaller screens, `PageLayout` uses vertically stacked rows to display content. `PageLayout` is responsible for determining the arrangement of the main regions that compose a page.
This means anything after the global and local headers (i.e. repo or org headers), and anything before the global footer.

 `PageLayout` controls the page spacings, supports header and footer regions, provides different styles of panes, and handles responsive strategies.

`PageLayout` flows as both column, when there's enough horizontal space to render both `Content` and `Pane` side-by-side (on a desktop of tablet device, per instance);
or it flows as a row, when `Content` and `Pane` are stacked vertically (e.g. on a mobile device).
`PageLayout` should always work in any screen size.

## Accessibility

Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
`content_region` or `pane_region` comes first in code. This is determined by the `position` argrument to the `pane_region` slot.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `wrapper_sizing` | `Symbol` | `:fluid` | Define the maximum width of the component. `:fluid` sets it to full-width. Other values center Layout horizontally. One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `outer_spacing` | `Symbol` | `:normal` | Sets wrapper margins surrounding the component to distance itself from the viewport edges. One of `:condensed` and `:normal`. |
| `column_gap` | `Symbol` | `:normal` | Sets gap between columns. One of `:condensed` and `:normal`. |
| `row_gap` | `Symbol` | `:normal` | Sets the gap below the header and above the footer. One of `:condensed` and `:normal`. |
| `responsive_variant` | `Symbol` | `:stack_regions` | Defines how the layout component adapts to smaller viewports. `:stack_regions` presents the content in a vertical flow, with pane and content vertically arranged. `:separate_regions` presents pane and content as different pages on smaller viewports. |
| `primary_region` | `Symbol` | `:content` | When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Content_region`

The layout's content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `tag` | `Symbol` | N/A | One of `:div` and `:main`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Header_region`

The layout's header.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `divider` | `Boolean` | N/A | Whether to show a header divider |
| `divider_narrow` | `Symbol` | N/A | Whether to show a divider below the `header` region if in responsive mode. One of `:filled`, `:inherit`, `:line`, or `:none`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Footer_region`

The layout's footer.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `divider` | `Boolean` | N/A | Whether to show a footer divider |
| `divider_narrow` | `Symbol` | N/A | Whether to show a divider below the `footer` region if in responsive mode. One of `:filled`, `:inherit`, `:line`, or `:none`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Pane_region`

The layout's pane.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `position` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end` and `:start`. |
| `position_narrow` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end`, `:inherit`, or `:start`. |
| `divider` | `Boolean` | N/A | Whether to show a pane line divider. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb

<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Header and footer

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>    <div data-view-component='true' class='PageLayout-header PageLayout-region border'>Header</div>    <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    <div data-view-component='true' class='PageLayout-footer PageLayout-region border'>Footer</div></div></div>" />

```erb

<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.header_region(border: true) { "Header" } %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
  <% c.footer_region(border: true) { "Footer" } %>
<% end %>
```

### Wrapper sizing

When `:fluid` the layout will be set to full width. When the other sizing options are used the layout will be centered with corresponding widths. - `:fluid`: full width - `:md`: max-width: 768px - `:lg`: max-width: 1012px - `:xl`: max-width: 1280px

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper container-md'>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper container-lg'>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper container-xl'>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :fluid)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :md)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :lg)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :xl)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Outer spacing

Sets wrapper margins surrounding the component to distance itself from the viewport edges. - `:condensed` keeps the margin at 16px. - `:normal`` sets the margin to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-condensed PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(outer_spacing: :condensed)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(outer_spacing: :normal)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Column gap

Sets the gap between columns to distance them from each other. - `:condensed` keeps the gap always at 16px. - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-condensed PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(column_gap: :condensed)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(column_gap: :normal)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Row gap

Sets the gap below the header and above the footer. - `:condensed` keeps the gap always at 16px. - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-condensed PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(row_gap: :condensed)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(row_gap: :normal)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Pane widths

Sets the pane width. The width is predetermined according to the breakpoint instead of it being percentage-based. - `default`: - `narrow`: - `wide`: When flowing as a row, `Pane` takes the full width.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--paneWidth-narrow PageLayout--responsive-panePos-start mt-5'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--paneWidth-wide PageLayout--responsive-panePos-start mt-5'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :default, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :narrow, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :wide, border: true) { "Pane" } %>
<% end %>
```

### Pane position

Use `start` for panes that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-end PageLayout--responsive-panePos-end mt-5'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(position: :start, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new( mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(position: :end, border: true) { "Pane" } %>
<% end %>
```

### Pane resposive position

Defines the position of the pane in the responsive layout. - `:start` puts the pane above content - `:end` puts it below content. - `:inherit` uses the same value from `position`

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start mt-5'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-end mt-5'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(position_narrow: :inherit, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(position_narrow: :start, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(position_narrow: :end, border: true) { "Pane" } %>
<% end %>
```

### Header

You can add an optional header to the layout and have spacing and positioning taken care of for you. You can optionally add a divider to the header.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>    <div data-view-component='true' class='PageLayout-header PageLayout-region border'>Header</div>    <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>    <div data-view-component='true' class='PageLayout-header--hasDivider PageLayout-region--dividerNarrow-line-after PageLayout-header PageLayout-region border'>Header</div>    <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.header_region(border: true) { "Header" } %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.header_region(divider: true, border: true) { "Header" } %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Footer

You can add an optional footer to the layout and have spacing and positioning taken care of for you. You can optionally add a divider to the footer.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    <div data-view-component='true' class='PageLayout-footer PageLayout-region border'>Header</div></div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    <div data-view-component='true' class='PageLayout-footer--hasDivider PageLayout-region--dividerNarrow-line-before PageLayout-footer PageLayout-region border'>Header</div></div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
  <% c.footer_region(border: true) { "Header" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
  <% c.footer_region(divider: true, border: true) { "Header" } %>
<% end %>
```
