---
title: HiddenTextExpander
componentId: hidden_text_expander
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/hidden_text_expander.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-hidden-text-expander
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `HiddenTextExpander` to indicate and toggle hidden text.

## Accessibility

`HiddenTextExpander` requires an `aria-label`, which will provide assistive technologies with an accessible label.
The `aria-label` should describe the action to be invoked by the `HiddenTextExpander`. For instance,
if your `HiddenTextExpander` expands a list of 5 comments, the `aria-label` should be
`"Expand 5 more comments"` instead of `"More"`.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inline` | `Boolean` | `false` | Whether or not the expander is inline. |
| `button_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the button element. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<span aria-label='No effect' data-view-component='true' class='hidden-text-expander'><button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new("aria-label": "No effect")) %>
```

### Inline

<Example src="<span aria-label='No effect' data-view-component='true' class='hidden-text-expander inline'><button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new(inline: true, "aria-label": "No effect")) %>
```

### Styling the button

<Example src="<span aria-label='No effect' data-view-component='true' class='hidden-text-expander'><button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander custom-class p-1'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new("aria-label": "No effect", button_arguments: { p: 1, classes: "custom-class" })) %>
```
