---
title: PageLayout
componentId: page_layout
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/page_layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-page-layout
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
| `wrapper_sizing` | `Symbol` | `BaseLayout::WRAPPER_SIZING_DEFAULT` | The size of the container wrapping `Layout`. One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `outer_spacing` | `Symbol` | `BaseLayout::OUTER_SPACING_DEFAULT` | Sets wrapper margins surrounding the component to distance itself from the viewport edges. One of `:condensed`, `:none`, or `:normal`. |
| `column_gap` | `Symbol` | `BaseLayout::COLUMN_GAP_DEFAULT` | Sets gap between columns. One of `:condensed`, `:none`, or `:normal`. |
| `row_gap` | `Symbol` | `BaseLayout::ROW_GAP_DEFAULT` | Sets the gap below the header and above the footer. One of `:condensed`, `:none`, or `:normal`. |
| `responsive_variant` | `Symbol` | `BaseLayout::RESPONSIVE_VARIANT_DEFAULT` | Defines how the layout component adapts to smaller viewports. `:stack_regions` presents the content in a vertical flow, with pane and content vertically arranged. `:separate_regions` presents pane and content as different pages on smaller viewports. |
| `responsive_primary_region` | `Symbol` | `BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT` | When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The layout's main content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:fluid`, `:lg`, `:md`, or `:xl`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Pane`

The layout's sidebar.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `width` | `Symbol` | N/A | One of `:default`, `:narrow`, or `:wide`. |
| `position` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end` and `:start`. |
| `responsive_position` | `Symbol` | N/A | Pane placement when `Layout` is in column modes. One of `:end`, `:inherit`, or `:start`. |
| `divider` | `Boolean` | N/A | Whether to show a pane line divider. |
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

