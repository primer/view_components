---
title: TabContainer
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_container_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-tab-container-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabContainer to create tabbed content with keyboard support. This component does not add any styles.
It only provides the tab functionality. If you want styled Tabs you can look at [TabNav](/components/tabnav).

This component requires javascript.

## Examples

### Default

<Example src="<tab-container>  <div role='tablist'>    <button type='button' role='tab' aria-selected='true'>Tab one</button>    <button type='button' role='tab' tabindex='-1'>Tab two</button>    <button type='button' role='tab' tabindex='-1'>Tab three</button>  </div>  <div role='tabpanel'>    Panel 1  </div>  <div role='tabpanel' hidden>    Panel 2  </div>  <div role='tabpanel' hidden>    Panel 3  </div></tab-container>" />

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
