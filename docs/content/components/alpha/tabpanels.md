---
title: TabPanels
componentId: tab_panels
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/tab_panels.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-tab-panels
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `TabPanels` for tabs with panel navigation.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | Sets an `aria-label` that helps assistive technology users understand the purpose of the tabs. |
| `align` | `Symbol` | N/A | One of `:left` and `:right`. - Defaults to left |
| `body_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the body wrapper. |
| `wrapper_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the `TabContainer` wrapper. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Tabs to be rendered. For more information, refer to [NavigationTab](/components/navigationtab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `id` | `String` | N/A | Unique ID of tab. |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Extra`

Renders extra content to the `TabPanels`. This will be rendered after the tabs.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `align` | `Symbol` | N/A | One of `:left` and `:right`. |

## Examples

### Default

<Example src="<tab-container data-view-component='true'>  <div data-view-component='true' class='tabnav'>        <ul role='tablist' aria-label='With panels' data-view-component='true' class='tabnav-tabs'>        <li role='presentation' data-view-component='true' class='d-inline-flex '>  <button id='tab-1' type='button' role='tab' aria-controls='panel-tab-1' aria-selected='true' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Tab 1</span>    </button></li>        <li role='presentation' data-view-component='true' class='d-inline-flex '>  <button id='tab-2' type='button' role='tab' aria-controls='panel-tab-2' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Tab 2</span>    </button></li></ul>    </div>    <div id='panel-tab-1' role='tabpanel' tabindex='0' aria-labelledby='tab-1' data-view-component='true'>      Panel 1</div>    <div id='panel-tab-2' role='tabpanel' tabindex='0' hidden='hidden' aria-labelledby='tab-2' data-view-component='true'>      Panel 2</div></tab-container>" />

```erb
<%= render(Primer::Alpha::TabPanels.new(label: "With panels")) do |component| %>
  <% component.tab(id: "tab-1", selected: true) do |t| %>
    <% t.text { "Tab 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab(id: "tab-2") do |t| %>
    <% t.text { "Tab 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
<% end %>
```
