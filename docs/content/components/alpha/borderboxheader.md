---
title: BorderBoxHeader
componentId: border_box_header
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/border_box/header.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-border-box-header
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

BorderBox::Header: used inside the BorderBoxComponent to render its header slot
Optional title slot

## Accessibility

When using `header.title`, set `tag` to one of `h1`, `h2`, `h3`, etc. based on what is appropriate for the page context. [Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

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

<Example src="<div data-view-component='true' class='Box-header'>      Header</div>" />

```erb

<%= render(Primer::Alpha::BorderBox::Header.new) do %>
  Header
<% end %>
```

### with title

<Example src="<div data-view-component='true' class='Box-header'>  <div data-view-component='true' class='Box-title'>I am a title</div>  </div>" />

```erb
<%= render(Primer::Alpha::BorderBox::Header.new) do |h| %>
  <% h.title do %>I am a title<% end %>
<% end %>
```
