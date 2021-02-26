---
title: Details
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use DetailsComponent to reveal content after clicking a button.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:none` | Dictates the type of overlay to render with. One of `:none`, `:default`, or `:dark`. |
| `reset` | `Boolean` | `false` | Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Summary`

Use the Summary slot as a trigger to reveal the content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |

### `Body`

Use the Body slot as the main content to be shown when triggered by the Summary.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |
