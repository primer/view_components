---
title: CtaLink
componentId: cta_link
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/cta_link.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-cta-link
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
| `href` | `String` | N/A | URL to be used for the Link. |
| `scheme` | `Symbol` | N/A | One of `:danger`, `:default`, `:invisible`, `:link`, `:outline`, or `:primary`. |
| `size` | `Symbol` | N/A | One of `:medium` and `:small`. |
| `block` | `Boolean` | N/A | Whether button is full-width with `display: block`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Schemes

<Example src="<a data-view-component='true' class='btn'>  Default<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn-primary btn'>  Primary<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn-danger btn'>  Danger<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn-outline btn'>  Outline<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn-invisible btn'>  Invisible<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn-link'>  Link<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a>" />

```erb
<%= render(Primer::Alpha::CtaLink.new(href: "#")) { "Default" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :primary)) { "Primary" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :danger)) { "Danger" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :outline)) { "Outline" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :invisible)) { "Invisible" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", scheme: :link)) { "Link" } %>
```

### Sizes

<Example src="<a data-view-component='true' class='btn-sm btn'>  Small<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a><a data-view-component='true' class='btn'>  Medium<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-right ml-2 mr-n1'>    <path fill-rule='evenodd' d='M6.22 3.22a.75.75 0 011.06 0l4.25 4.25a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06-1.06L9.94 8 6.22 4.28a.75.75 0 010-1.06z'></path></svg></a>" />

```erb
<%= render(Primer::Alpha::CtaLink.new(href: "#", size: :small)) { "Small" } %>
<%= render(Primer::Alpha::CtaLink.new(href: "#", size: :medium)) { "Medium" } %>
```
