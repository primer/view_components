---
title: HellipButton
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/hellip_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-hellip-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `HellipButton` to render a button with an hellip. Often used for hidden text expanders.

## Accessibility

Always set an accessible label to help the user interact with the component.

* This button is displaying an hellip as its content (The three dot character). Therefor a label is needed for screen readers.
* Set the attribute `aria-label` on the system arguments. E.g. `Primer::HellipButton.new("aria-label": "Expend next part")`

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inline` | `Boolean` | `false` | Whether or not the button is inline. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='hellip-button'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new("aria-label": "No effect")) %>
```

### Inline

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='hellip-button inline'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new(inline: true, "aria-label": "No effect")) %>
```

### Styling the button

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='hellip-button custom-class p-1'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new(p: 1, classes: "custom-class", "aria-label": "No effect")) %>
```
