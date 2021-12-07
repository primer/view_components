---
title: BaseLayout
componentId: base_layout
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/base_layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-base-layout
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
