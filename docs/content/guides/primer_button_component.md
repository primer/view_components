---
title: Moving Away From `Primer::ButtonComponent`
---

This guide will show you how to upgrade from the now deprecated
[`Primer::ButtonComponent`](https://primer.style/view-components/components/button)
to the latest [`Primer::Beta::Button`](https://primer.style/view-components/components/beta/button)
component.

## Arguments

The following arguments for the component initialier have changed between the deprecated and newer versions
of the Primer Button.

| From `Primer::ButtonComponent` | To `Primer::Beta::Button` | Notes |
|--------------------------------|---------------------------|-------|
| `variant`    | `size` | renamed; values remain the same   |
| `group_item` | n/a    | removed in `Primer::Beta::Button` |
| `dropdown`   | n/a    | removed in `Primer::Beta::Button` |

`Primer::Beta::Button` no longer supports the boolean settings for being part of
a group, or displaying the dropdown caret. If you need a button group, please
see [`Primer::Beta::ButtonGroup`](https://primer.style/view-components/components/beta/buttongroup). For dropdown menus, please see
[`Primer::Alpha::Dropdown`](https://primer.style/view-components/components/alpha/dropdown).

The remaining arguments have stayed the same.

## Slot Names

The following slots have changed with the newer Primer Button.

| From `Primer::ButtonComponent` | To `Primer::Beta::Button` | Notes |
|--------------------------------|---------------------------|-------|
| n/a | `trailing_action` | appears to the right of the `trailing_visual` slot |

The remaining slot names have stayed the same.

[&larr; Back to migration guides](https://primer.style/view-components/migration)
