---
title: Link
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/link_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-link-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use links for moving from one page to another. The Link component styles anchor tags with default blue styling and hover text-decoration.

## Examples

### Default

<Example src="<a href='#'>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#")) { "Link" } %>
```

### Muted

<Example src="<a href='#' class='Link--muted '>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", muted: true)) { "Link" } %>
```

### Variants

<Example src="<a href='#' class='Link--primary '>Primary</a><a href='#' class='Link--secondary '>Secondary</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", variant: :primary)) { "Primary" } %>
<%= render(Primer::LinkComponent.new(href: "#", variant: :secondary)) { "Secondary" } %>
```

### Without underline

<Example src="<a href='#' class='no-underline '>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "#", underline: false)) { "Link" } %>
```

### Span as link

<Example src="<span class='Link '>Span as a link</span>" />

```erb
<%= render(Primer::LinkComponent.new(tag: :span)) { "Span as a link" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `String` | `:a` | One of `:a` and `:span`. |
| `href` | `String` | `nil` | URL to be used for the Link. Required if tag is `:a`. If the requirements are not met an error will be raised in non production environments. In production, an empty link element will be rendered. |
| `variant` | `Symbol` | `:default` | One of `:default`, `:primary`, or `:secondary`. |
| `muted` | `Boolean` | `false` | Uses light gray for Link color, and blue on hover. |
| `underline` | `Boolean` | `true` | Whether or not to underline the link. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
