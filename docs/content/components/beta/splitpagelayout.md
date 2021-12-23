---
title: SplitPageLayout
componentId: split_page_layout
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/split_page_layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-split-page-layout
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

In the `SplitPageLayout`, changes in the Pane region are reflected in the `Content` region. This is also known as a "List/Detail" or "Master/Detail" pattern.

On larger screens, the user sees both regions side by side, with the `Pane` region appearing flushed to the left.

On smaller screens, the user only sees one of `Pane` or `Content` regions at a time.
Pages may decide if it's more important to show the `Pane` region or the `Content` region first by the `:primary_region` property.

## Accessibility

Keyboard navigation follows the markup order. In the case of the `SplitPageLayout`, the `Pane` region is the first region, and the `Content` region is the second.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inner_spacing` | `Symbol` | `:normal` | Sets padding to regions individually. One of `:condensed` and `:normal`. |
| `primary_region` | `Symbol` | `:content` | When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. One of `:content` and `:pane`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Content_region`

The layout's content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `tag` | `Symbol` | N/A | One of `:div` and `:main`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Pane_region`

The layout's pane.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `tag` | `Symbol` | N/A | One of `:aside`, `:div`, `:nav`, or `:section`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='PageLayout PageLayout--innerSpacing-normal PageLayout--responsive-primary-content PageLayout--responsive-separateRegions PageLayout--columnGap-none PageLayout--rowGap-none PageLayout--panePos-start PageLayout--hasPaneDivider'>  <div data-view-component='true' class='PageLayout-wrapper'>    <div data-view-component='true' class='PageLayout-columns'>      <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>      <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div></div></div>" />

```erb

<%= render(Primer::Beta::SplitPageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Inner spacing

Sets padding to regions individually. - `:condensed` keeps the margin at 16px. - `:normal` sets the margin to 16px, and to 24px on lg breakpoints and above.

<Example src="<div inner_spacing='condensed' data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div inner_spacing='normal' data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(inner_spacing: :condensed)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(inner_spacing: :normal)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Responsive primary region

When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. - `:content` - `:pane`

<Example src="<div resposive_primary_region='content' data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div><div data-view-component='true' class='PageLayout PageLayout--outerSpacing-normal PageLayout--columnGap-normal PageLayout--rowGap-normal PageLayout--responsive-stackRegions PageLayout--panePos-start PageLayout--responsive-panePos-start'>  <div data-view-component='true' class='PageLayout-wrapper '>        <div data-view-component='true' class='PageLayout-columns'>        <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>        <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div>    </div></div>" />

```erb
<%= render(Primer::Beta::PageLayout.new(resposive_primary_region: :content)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::PageLayout.new(primary_region: :pane)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(border: true) { "Pane" } %>
<% end %>
```

### Pane widths

Sets the pane width. The width is predetermined according to the breakpoint instead of it being percentage-based. - `default`: - `narrow`: - `wide`: When flowing as a row, `Pane` takes the full width.

<Example src="<div data-view-component='true' class='PageLayout PageLayout--innerSpacing-normal PageLayout--responsive-primary-content PageLayout--responsive-separateRegions PageLayout--columnGap-none PageLayout--rowGap-none PageLayout--panePos-start PageLayout--hasPaneDivider'>  <div data-view-component='true' class='PageLayout-wrapper'>    <div data-view-component='true' class='PageLayout-columns'>      <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>      <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div></div></div><div data-view-component='true' class='PageLayout PageLayout--innerSpacing-normal PageLayout--responsive-primary-content PageLayout--responsive-separateRegions PageLayout--columnGap-none PageLayout--rowGap-none PageLayout--panePos-start PageLayout--hasPaneDivider PageLayout--paneWidth-narrow mt-5'>  <div data-view-component='true' class='PageLayout-wrapper'>    <div data-view-component='true' class='PageLayout-columns'>      <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>      <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div></div></div><div data-view-component='true' class='PageLayout PageLayout--innerSpacing-normal PageLayout--responsive-primary-content PageLayout--responsive-separateRegions PageLayout--columnGap-none PageLayout--rowGap-none PageLayout--panePos-start PageLayout--hasPaneDivider PageLayout--paneWidth-wide mt-5'>  <div data-view-component='true' class='PageLayout-wrapper'>    <div data-view-component='true' class='PageLayout-columns'>      <div data-view-component='true' class='PageLayout-region PageLayout-pane border'>Pane</div>      <div data-view-component='true' class='PageLayout-region PageLayout-content border'>Content</div></div></div></div>" />

```erb
<%= render(Primer::Beta::SplitPageLayout.new) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :default, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::SplitPageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :narrow, border: true) { "Pane" } %>
<% end %>
<%= render(Primer::Beta::SplitPageLayout.new(mt: 5)) do |c| %>
  <% c.content_region(border: true) { "Content" } %>
  <% c.pane_region(width: :wide, border: true) { "Pane" } %>
<% end %>
```
