---
title: TabContainer
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_container_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabContainer to create tabbed content with keyboard support. This component does not add any styles.
It only provides the tab functionality. If you want styled Tabs you can look at [TabNav](/components/tabnav).

This component requires javascript.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><tab-container>  <div role='tablist'>    <button type='button' role='tab' aria-selected='true'>Tab one</button>    <button type='button' role='tab' tabindex='-1'>Tab two</button>    <button type='button' role='tab' tabindex='-1'>Tab three</button>  </div>  <div role='tabpanel'>    Panel 1  </div>  <div role='tabpanel' hidden>    Panel 2  </div>  <div role='tabpanel' hidden>    Panel 3  </div></tab-container></body></html>"></iframe>

```erb
<%= render(Primer::TabContainerComponent.new)  do %>
  <div role="tablist">
    <button type="button" role="tab" aria-selected="true">Tab one</button>
    <button type="button" role="tab" tabindex="-1">Tab two</button>
    <button type="button" role="tab" tabindex="-1">Tab three</button>
  </div>
  <div role="tabpanel">
    Panel 1
  </div>
  <div role="tabpanel" hidden>
    Panel 2
  </div>
  <div role="tabpanel" hidden>
    Panel 3
  </div>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
