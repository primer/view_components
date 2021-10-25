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
| `title` | `String` | N/A | Title to be rendered beside the Avatar. |
| `description` | `String` | `""` | Description to be rendered below the title. |
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

<Example src="<span data-view-component='true' class='d-flex flex-items-center text-bold'>  <img aria-disabled='true' src='https://github.com/github.png' alt='' size='24' height='24' width='24' data-view-component='true' class='avatar circle mr-1'></img>  <div class='d-flex flex-column'>    <span data-view-component='true' class='text-bold'>github</span>    <span data-view-component='true' class='color-fg-muted f6 no-underline'></span>  </div></span>" />

```erb

<%= render(Primer::Alpha::Nameplate.new(title: "github")) do |c| %>
  <% c.avatar(src: "https://github.com/github.png") %>
<% end %>
```

### As a link

<Example src="<a href='#' data-view-component='true' class='d-flex flex-items-center text-bold'>  <img aria-disabled='true' src='https://github.com/github.png' alt='' size='24' height='24' width='24' data-view-component='true' class='avatar circle mr-1'></img>  <div class='d-flex flex-column'>    <span data-view-component='true' class='text-bold'>github</span>    <span data-view-component='true' class='color-fg-muted f6 no-underline'></span>  </div></a>" />

```erb

<%= render(Primer::Alpha::Nameplate.new(tag: :a, title: "github", href: "#")) do |c| %>
  <% c.avatar(src: "https://github.com/github.png") %>
<% end %>
```

### With description

<Example src="<span aria-label='github (GitHub Inc.)' data-view-component='true' class='d-flex flex-items-center text-bold'>  <img aria-disabled='true' src='https://github.com/github.png' alt='' size='32' height='32' width='32' data-view-component='true' class='avatar circle mr-1'></img>  <div class='d-flex flex-column'>    <span data-view-component='true' class='text-bold'>github</span>    <span data-view-component='true' class='color-fg-muted f6 no-underline'>GitHub Inc.</span>  </div></span>" />

```erb

<%= render(Primer::Alpha::Nameplate.new(title: "github", description: "GitHub Inc.")) do |c| %>
  <% c.avatar(src: "https://github.com/github.png") %>
<% end %>
```
