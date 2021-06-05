---
title: IconButton
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/icon_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-icon-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `IconButton` to render Icon-only buttons without the default button styles.

## Accessibility

`IconButton` requires an `aria-label`, which will provide assistive technologies with an accessible label.
The `aria-label` should describe the action to be invoked rather than the icon itself. For instance,
if your `IconButton` renders a magnifying glass icon and invokves a search action, the `aria-label` should be
`"Search"` instead of `"Magnifying glass"`.
[Learn more about best functional image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/functional)

## Examples

### Default

<Example src="<button aria-label='Search' type='button' data-view-component='true' class='btn-octicon'><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg></button>" />

```erb

<%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
```

### Schemes

<Example src="<button aria-label='Search' type='button' data-view-component='true' class='btn-octicon'><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg></button><button aria-label='Delete' type='button' data-view-component='true' class='btn-octicon btn-octicon-danger'><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-trash'>    <path fill-rule='evenodd' d='M6.5 1.75a.25.25 0 01.25-.25h2.5a.25.25 0 01.25.25V3h-3V1.75zm4.5 0V3h2.25a.75.75 0 010 1.5H2.75a.75.75 0 010-1.5H5V1.75C5 .784 5.784 0 6.75 0h2.5C10.216 0 11 .784 11 1.75zM4.496 6.675a.75.75 0 10-1.492.15l.66 6.6A1.75 1.75 0 005.405 15h5.19c.9 0 1.652-.681 1.741-1.576l.66-6.6a.75.75 0 00-1.492-.149l-.66 6.6a.25.25 0 01-.249.225h-5.19a.25.25 0 01-.249-.225l-.66-6.6z'></path></svg></button>" />

```erb

<%= render(Primer::IconButton.new(icon: :search, "aria-label": "Search")) %>
<%= render(Primer::IconButton.new(icon: :trash, "aria-label": "Delete", scheme: :danger)) %>
```

### In a BorderBox

<Example src="<div data-view-component='true' class='Box'>    <div data-view-component='true' class='Box-body'>    <span data-view-component='true' class='pr-2'>Body</span>    <button aria-label='Edit' type='button' data-view-component='true' class='btn-octicon Box-btn-octicon'><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-pencil'>    <path fill-rule='evenodd' d='M11.013 1.427a1.75 1.75 0 012.474 0l1.086 1.086a1.75 1.75 0 010 2.474l-8.61 8.61c-.21.21-.47.364-.756.445l-3.251.93a.75.75 0 01-.927-.928l.929-3.25a1.75 1.75 0 01.445-.758l8.61-8.61zm1.414 1.06a.25.25 0 00-.354 0L10.811 3.75l1.439 1.44 1.263-1.263a.25.25 0 000-.354l-1.086-1.086zM11.189 6.25L9.75 4.81l-6.286 6.287a.25.25 0 00-.064.108l-.558 1.953 1.953-.558a.249.249 0 00.108-.064l6.286-6.286z'></path></svg></button></div>  </div>" />

```erb

<%= render(Primer::BorderBoxComponent.new) do |component| %>
  <% component.body do %>
    <%= render(Primer::TextComponent.new(pr: 2)) { "Body" } %>
    <%= render(Primer::IconButton.new(icon: :pencil, box: true, "aria-label": "Edit")) %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:danger` and `:default`. |
| `icon` | `String` | N/A | Name of [Octicon](https://primer.style/octicons/) to use. |
| `tag` | `Symbol` | N/A | One of `:a`, `:button`, or `:summary`. |
| `type` | `Symbol` | N/A | One of `:button`, `:reset`, or `:submit`. |
| `box` | `Boolean` | `false` | Whether the button is in a [BorderBox](/components/borderbox). If `true`, the button will have the `Box-btn-octicon` class. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
