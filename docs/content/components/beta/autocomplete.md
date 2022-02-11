---
title: AutoComplete
componentId: auto_complete
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/auto_complete.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-auto-complete
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
input field. This list is populated by server search results.

## Accessibility

Always set an accessible label to help the user interact with the component.

* `label_text` is required and visible by default.
* If you must use a non-visible label, set `is_label_visible` to `false`.
However, please note that a visible label should almost always
be used unless there is compelling reason not to. A placeholder is not a label.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label_text` | `String` | N/A | The label of the input. |
| `src` | `String` | N/A | The route to query. |
| `input_id` | `String` | N/A | Id of the input element. |
| `list_id` | `String` | N/A | Id of the list element. |
| `is_label_visible` | `Boolean` | `true` | Controls if the label is visible. If `false`, screen reader only text will be added. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Input`

Optional slot to customize classes for the input field.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `type` | `Symbol` | N/A | One of `:search` and `:text`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Icon`

Optional icon to be rendered before the input. Has the same arguments as [Octicon](/components/octicon).

### `Results`

Customizable results list.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Label`

Optionally render a visible label. See [Accessibility](#accessibility)

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

