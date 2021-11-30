---
title: Details
componentId: details
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-details-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `DetailsComponent` to reveal content after clicking a button.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:none` | Dictates the type of overlay to render with. One of `:dark`, `:default`, or `:none`. |
| `reset` | `Boolean` | `false` | Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Summary`

Use the Summary slot as a trigger to reveal the content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `button` | `Boolean` | `true` | Whether to render the Summary as a button or not. |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |

### `Body`

Use the Body slot as the main content to be shown when triggered by the Summary.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:div` | One of `:details-dialog`, `:details-menu`, `:div`, or `:ul`. |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |

## Examples

### Default

<Example src="<details data-view-component='true'>  <summary role='button' data-view-component='true' class='btn'>  Summary</summary>  <div data-view-component='true'>    Body</div></details>" />

```erb

<%= render Primer::DetailsComponent.new do |c| %>
  <% c.summary do %>
    Summary
  <% end %>
  <% c.body do %>
    Body
  <% end %>
<% end %>
```
