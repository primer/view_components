---
title: Moving Away From `Primer::DropdownMenuComponent`
---

This guide will show you how to upgrade from the now deprecated
[`Primer::DropdownMenuComponent`](https://primer.style/view-components/components/dropdownmenu)
to the latest [`Primer::Alpha::Dropdown`](https://primer.style/view-components/components/alpha/dropdown)
component.

## Arguments

The following arguments for the component initializer have changed between the deprecated and newer versions
of the Primer Dropdown.

| From `Primer::DropdownMenuComponent` | To `Primer::Alpha::Dropdown` | Notes |
|--------------------------------------|------------------------------|-------|
| `direction` | n/a          | Moved to `menu` slot, below                                |
| `scheme`    | n/a          | Moved to `menu` slot, below                                |
| `header`    | n/a          | Moved to `menu` slot, below                                |
| n/a         | `overlay`    | Color of the menu overlay: `:default`, `:dark`, or `:none` |
| n/a         | `with_caret` | Whether or not a caret should be displayed on the button   |

The remaining arguments have stayed the same.

Please see the following documentation for complete descriptions and examples.

* [Deprecated `Primer::DropdownMenuComponent`](https://primer.style/view-components/components/dropdownmenu)
* [Updated `Primer::Alpha::Dropdown` component](https://primer.style/view-components/components/alpha/dropdown)
* [`Primer::Alpha::Dropdown` Lookbook examples](https://primer.style/view-components/lookbook/inspect/primer/alpha/dropdown/default)

## Slot Names

The following slots have changed with the newer Primer Dropdown.

| From `Primer::DropdownMenuComponent` | To `Primer::Alpha::Dropdown` | Notes |
|--------------------------------------|------------------------------|-------|
| n/a | `menu`   | Required context menu for the dropdown. See the "Arguments for `menu` slot" section, below |
| n/a | `button` | The [`Primer::Beta::Button`](https://primer.style/view-components/components/beta/button) to display for the dropdown action |

The remaining slot names have stayed the same.

### Arguments for `menu` slot

The following arguments are available with the `menu` named slot in Primer Dropdown.

| Argument    | Description |
|-------------|-------------|
| `as`               | when `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item |
| `direction`        | relative position to show dropdown, when button is clicked                   |
| `header`           | optional string to display as the header                                     |
| `scheme`           | pass `:dark` for dark mode theming                                           |
| `system_arguments` | [System arguments](https://primer.style/view-components/system-arguments)    |

[&larr; Back to migration guides](https://primer.style/view-components/migration)
