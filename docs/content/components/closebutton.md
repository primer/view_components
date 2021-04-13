---
title: CloseButton
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/close_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-close-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use CloseButton to render an `×` without default button styles.

## Examples

### Default

<Example src="<button type='button' class='close-button '><svg class='octicon octicon-x' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z'></path></svg></button>" />

```erb
<%= render(Primer::CloseButton.new) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `type` | `Symbol` | `:button` | One of `:button` and `:submit`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
