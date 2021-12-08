---
title: SplitLayout
componentId: split_layout
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/split_layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-split-layout
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

In the `SplitLayout`, changes in the Pane region are reflected in the Content region. This is also known as a "List/Detail" or "Master/Detail" pattern.

On larger screens, the user sees both regions side by side, with the Pane region appearing flushed to the left.

On smaller screens, the user only sees one of pane or content regions at a time.
Pages may decide if it's more important to show the Pane region or the Content region first by the responsiveLandingRegion property.
For example, opening "Repository settings" on mobile will have the user land on the Pane region, since in that case showing the menu options first is more important.

## Accessibility

Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
`main` or `pane` comes first in code. The code order won’t affect the visual position.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inner_spacing` | `Symbol` | `:normal` | Sets padding to regions individually. One of `:condensed` and `:normal`. |
| `responsive_primary_region` | `Symbol` | `:content` | When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. One of `:content` and `:pane`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The layout's main content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `tag` | `Symbol` | N/A | One of `:div` and `:main`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Pane`

The layout's sidebar.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `tag` | `Symbol` | N/A | One of `:aside`, `:div`, `:nav`, or `:section`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-normal LayoutBeta--primary-content LayoutBeta--variant-separateRegions LayoutBeta--column-gap-none LayoutBeta--row-gap-none LayoutBeta--pane-position-start LayoutBeta--pane-divider LayoutBeta--variant-md-multiColumns LayoutBeta--pane-position-start LayoutBeta--pane-divider'>  <div data-view-component='true' class='LayoutBeta-wrapper'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div data-view-component='true' class='LayoutBeta-region LayoutBeta-content border'>Main</div></div></div></div>" />

```erb

<%= render(Primer::Beta::SplitLayout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(border: true) { "Pane" } %>
<% end %>
```

### Pane widths

Sets the pane width. The width is predetermined according to the breakpoint instead of it being percentage-based. - `default`: - `narrow`: - `wide`: When flowing as a row, `Pane` takes the full width.

<Example src="<div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-normal LayoutBeta--primary-content LayoutBeta--variant-separateRegions LayoutBeta--column-gap-none LayoutBeta--row-gap-none LayoutBeta--pane-position-start LayoutBeta--pane-divider LayoutBeta--variant-md-multiColumns LayoutBeta--pane-position-start LayoutBeta--pane-divider'>  <div data-view-component='true' class='LayoutBeta-wrapper'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div data-view-component='true' class='LayoutBeta-region LayoutBeta-content border'>Main</div></div></div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-normal LayoutBeta--primary-content LayoutBeta--variant-separateRegions LayoutBeta--column-gap-none LayoutBeta--row-gap-none LayoutBeta--pane-position-start LayoutBeta--pane-divider LayoutBeta--variant-md-multiColumns LayoutBeta--pane-position-start LayoutBeta--pane-width-narrow LayoutBeta--pane-divider mt-5'>  <div data-view-component='true' class='LayoutBeta-wrapper'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div data-view-component='true' class='LayoutBeta-region LayoutBeta-content border'>Main</div></div></div></div><div data-view-component='true' class='LayoutBeta LayoutBeta--inner-spacing-normal LayoutBeta--primary-content LayoutBeta--variant-separateRegions LayoutBeta--column-gap-none LayoutBeta--row-gap-none LayoutBeta--pane-position-start LayoutBeta--pane-divider LayoutBeta--variant-md-multiColumns LayoutBeta--pane-position-start LayoutBeta--pane-width-wide LayoutBeta--pane-divider mt-5'>  <div data-view-component='true' class='LayoutBeta-wrapper'>    <div data-view-component='true' class='LayoutBeta-regions'>      <div data-view-component='true' class='LayoutBeta-pane border'>Pane</div>      <div data-view-component='true' class='LayoutBeta-region LayoutBeta-content border'>Main</div></div></div></div>" />

```erb
<%= render(Primer::Beta::SplitLayout.new) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :default, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::SplitLayout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :narrow, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::SplitLayout.new(mt: 5)) do |c| %>
  <% c.main(border: true) { "Main" } %>
  <% c.pane(width: :wide, border: true) { "Pane" } %>
<% end %>
```
