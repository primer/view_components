---
title: HiddenTextExpander
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/hidden_text_expander.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-hidden-text-expander-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `HiddenTextExpander` to indicate and toggle hidden text.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inline` | `Boolean` | `false` | Whether or not the expander is inline. |
| `button_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the button element. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<span data-view-component='true' class='hidden-text-expander'><button aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new) %>
```

### Inline

<Example src="<span data-view-component='true' class='hidden-text-expander inline'><button aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new(inline: true)) %>
```

### Styling the button

<Example src="<span data-view-component='true' class='hidden-text-expander'><button aria-expanded='false' type='button' data-view-component='true' class='ellipsis-expander custom-class p-1'>&hellip;</button></span>" />

```erb
<%= render(Primer::HiddenTextExpander.new(button_arguments: { p: 1, classes: "custom-class" })) %>
```
