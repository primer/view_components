---
title: TabNavContainer
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_nav_container_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabNavContainer to create a tabbed navigation without changing pages.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><tab-container>  <div class='tabnav '>  <nav role='tablist' aria-label='' class='tabnav-tabs'>      <button type='button' role='tab' aria-selected='true' class='tabnav-tab '>Tab 1</button>      <button type='button' role='tab' class='tabnav-tab '>Tab 2</button>      <button type='button' role='tab' class='tabnav-tab '>Tab 3</button>  </nav ></div>    <div role='tabpanel' >      Panel 1    </div>    <div role='tabpanel' hidden>      Panel 2    </div>    <div role='tabpanel' hidden>      Panel 3    </div></tab-container></body></html>"></iframe>

```erb
<%= render(Primer::TabNavContainerComponent.new) do |c| %>
  <% c.nav do |nav| %>
    <% nav.tab(selected: true, title: "Tab 1") { "Panel 1" } %>
    <% nav.tab(title: "Tab 2") { "Panel 2" } %>
    <% nav.tab(title: "Tab 3") { "Panel 3" } %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Nav`

The TabNav component.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [TabNav](/components/tabnav). |
