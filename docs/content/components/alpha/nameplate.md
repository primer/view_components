---
title: Nameplate
componentId: nameplate
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/nameplate.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-nameplate
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `name` | `String` | N/A | Name to be rendered beside the Avatar. |
| `tag` | `Symbol` | `:span` |  |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Avatar`

Required Avatar

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Avatar](/components/beta/avatar). |

## Examples

### Default

<Example src="<span data-view-component='true' class='d-flex flex-items-center text-bold'>  <img aria-disabled='true' src='https://github.com/github.png' alt='' size='24' height='24' width='24' data-view-component='true' class='avatar circle mr-1'></img>  github</span>" />

```erb

<%= render(Primer::Alpha::Nameplate.new(name: "github")) do |c| %>
  <% c.avatar(src: "https://github.com/github.png") %>
<% end %>
```

### As a link

<Example src="<a href='#' data-view-component='true' class='d-flex flex-items-center text-bold'>  <img aria-disabled='true' src='https://github.com/github.png' alt='' size='24' height='24' width='24' data-view-component='true' class='avatar circle mr-1'></img>  github</a>" />

```erb

<%= render(Primer::Alpha::Nameplate.new(tag: :a, name: "github", href: "#")) do |c| %>
  <% c.avatar(src: "https://github.com/github.png") %>
<% end %>
```
