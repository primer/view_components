---
title: Link
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/link_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-link-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Link` for navigating from one page to another. `Link` styles anchor tags with default blue styling and hover text-decoration.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `String` | `:a` | One of `:a` and `:span`. |
| `href` | `String` | `nil` | URL to be used for the Link. Required if tag is `:a`. If the requirements are not met an error will be raised in non production environments. In production, an empty link element will be rendered. |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:primary`, or `:secondary`. |
| `muted` | `Boolean` | `false` | Uses light gray for Link color, and blue on hover. |
| `underline` | `Boolean` | `true` | Whether or not to underline the link. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<a href='#' data-view-component='true'>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#")) { "Link" } %>
```

### Muted

<Example src="<a href='#' data-view-component='true' class='Link--muted'>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", muted: true)) { "Link" } %>
```

### Schemes

<Example src="<a href='#' data-view-component='true' class='Link--primary'>Primary</a><a href='#' data-view-component='true' class='Link--secondary'>Secondary</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", scheme: :primary)) { "Primary" } %>
<%= render(Primer::LinkComponent.new(href: "#", scheme: :secondary)) { "Secondary" } %>
```

### Without underline

<Example src="<a href='#' data-view-component='true' class='no-underline'>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", underline: false)) { "Link" } %>
```

### Span as link

<Example src="<span data-view-component='true' class='Link'>Span as a link</span>" />

```erb
<%= render(Primer::LinkComponent.new(tag: :span)) { "Span as a link" } %>
```
