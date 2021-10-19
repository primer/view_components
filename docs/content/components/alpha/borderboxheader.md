---
title: BorderBoxHeader
componentId: border_box_header
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/border_box_header.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-border-box-header
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

BorderBoxHeader: used inside the BorderBoxComponent to render its header slot
Optional title slot

## Accessibility

When using header.title, the recommended tag is a heading tag, such as h1, h2, h3, etc.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Title`

Optional Title.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### default use case

<Example src="<div data-view-component='true' class='Box-header'>    Header</div>" />

```erb

<%= render(Primer::Alpha::BorderBoxHeader.new) do %>
  Header
<% end %>
```

### with title

<Example src="<div data-view-component='true' class='Box-header'></div>" />

```erb
<%= render(Primer::Alpha::BorderBoxHeader.new) do |h| %>
  <% h.title do %>I am a title<% end %>
<% end %>
```
