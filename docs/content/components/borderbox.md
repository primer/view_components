---
title: BorderBox
componentId: border_box
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/border_box_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-border-box-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`BorderBox` is a Box component with a border.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `padding` | `Symbol` | `:default` | One of `:condensed`, `:default`, or `:spacious`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Header`

Optional Header.

When using header.title, the recommended tag is a heading tag, such as h1, h2, h3, etc.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Body`

Optional Body.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Footer`

Optional Footer.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Rows`

Use Rows to add rows with borders and maintain the same padding.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | N/A | Color scheme. One of `:default`, `:info`, `:neutral`, or `:warning`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Header with title, body, rows, and footer

