---
title: IconButton
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/icon_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-icon-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use IconButton to render Icon-only buttons without the default button styles.

## Accessibility

IconButton requires a `label` which will set the element's `aria-label`, providing assistive technologies with an accessible label.

## Examples

### Default

<Example src="<button aria-label='Search' type='button' class='btn-octicon '><svg class='octicon octicon-search' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg></button>" />

```erb

<%= render(Primer::IconButton.new(icon: :search, label: "Search")) %>
```

### Schemes

<Example src="<button aria-label='Search' type='button' class='btn-octicon '><svg class='octicon octicon-search' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg></button><button aria-label='Delete' type='button' class='btn-octicon btn-octicon-danger '><svg class='octicon octicon-trash' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M6.5 1.75a.25.25 0 01.25-.25h2.5a.25.25 0 01.25.25V3h-3V1.75zm4.5 0V3h2.25a.75.75 0 010 1.5H2.75a.75.75 0 010-1.5H5V1.75C5 .784 5.784 0 6.75 0h2.5C10.216 0 11 .784 11 1.75zM4.496 6.675a.75.75 0 10-1.492.15l.66 6.6A1.75 1.75 0 005.405 15h5.19c.9 0 1.652-.681 1.741-1.576l.66-6.6a.75.75 0 00-1.492-.149l-.66 6.6a.25.25 0 01-.249.225h-5.19a.25.25 0 01-.249-.225l-.66-6.6z'></path></svg></button>" />

```erb

<%= render(Primer::IconButton.new(icon: :search, label: "Search")) %>
<%= render(Primer::IconButton.new(icon: :trash, label: "Delete", scheme: :danger)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default` and `:danger`. |
| `icon` | `String` | N/A | Name of [Octicon](https://primer.style/octicons/) to use. |
| `label` | `String` | N/A | String that will be read to screenreaders when the component is focused |
| `tag` | `Symbol` | N/A | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | N/A | One of `:button`, `:reset`, or `:submit`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
