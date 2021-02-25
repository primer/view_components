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

<Example src="<a href='http://www.google.com'>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "http://www.google.com")) { "Link" } %>
```

### Muted

<Example src="<a href='http://www.google.com' class='muted-link '>Link</a>" />

```erb
<%= render(Primer::LinkComponent.new(href: "http://www.google.com", muted: true)) { "Link" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | URL to be used for the Link |
| `muted` | `Boolean` | `false` | Uses light gray for Link color, and blue on hover |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
