---
title: Details
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
storybook: https://primer-view-components.herokuapp.com/?path=/story/primer-details-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use DetailsComponent to reveal content after clicking a button.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:none` | Dictates the type of overlay to render with. One of `:none`, `:default`, or `:dark`. |
| `reset` | `Boolean` | `false` | Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `body` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

Use the Body slot as the main content to be shown when triggered by the Summary.

### `summary` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `button` | `Boolean` | `true` | Whether to render the Summary as a button or not. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

Use the Summary slot as a trigger to reveal the content.
