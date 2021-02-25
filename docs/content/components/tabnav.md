---
title: TabNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_nav_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabNav to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><div class='tabnav '>  <nav role='tablist' aria-label='' class='tabnav-tabs'>      <a href='#' role='tab' aria-current='page' class='tabnav-tab '>Tab 1</a>      <a href='#' role='tab' class='tabnav-tab '>Tab 2</a>      <a href='#' role='tab' class='tabnav-tab '>Tab 3</a>  </nav ></div></body></html>"></iframe>

```erb
<%= render(Primer::TabNavComponent.new) do |c| %>
  <% c.tab(selected: true, title: "Tab 1", href: "#") %>
  <% c.tab(title: "Tab 2", href: "#") %>
  <% c.tab(title: "Tab 3", href: "#") %>
<% end %>
```

### With panels

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><tab-container class='tabnav '>  <nav role='tablist' aria-label='' class='tabnav-tabs'>      <button type='button' role='tab' aria-selected='true' class='tabnav-tab '>Tab 1</button>      <button type='button' role='tab' class='tabnav-tab '>Tab 2</button>      <button type='button' role='tab' class='tabnav-tab '>Tab 3</button>  </nav >        <div role='tabpanel' >          Panel 1        </div>        <div role='tabpanel' hidden>          Panel 1        </div>        <div role='tabpanel' hidden>          Panel 1        </div></tab-container></body></html>"></iframe>

```erb
<%= render(Primer::TabNavComponent.new(with_panel: true)) do |c| %>
  <% c.tab(selected: true, title: "Tab 1") { "Panel 1" } %>
  <% c.tab(title: "Tab 2") { "Panel 1" } %>
  <% c.tab(title: "Tab 3") { "Panel 1" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `aria_label` | `String` | `nil` | Used to set the `aria-label` on the top level `<nav>` element. |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Tabs to be rendered.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | Text to be rendered by the tab. |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
