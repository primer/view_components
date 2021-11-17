---
title: HellipButton
componentId: hellip_button
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/hellip_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-hellip-button
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `HellipButton` to render a button with a hellip. Often used for hidden text expanders.

## Accessibility

Always set an accessible label to help the user interact with the component.

* This button is displaying a hellip as its content (The three dots character). Therefore a label is needed for screen readers.
* Set the attribute `aria-label` on the system arguments. E.g. `Primer::HellipButton.new("aria-label": "Expand next part")`

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inline` | `Boolean` | `false` | Whether or not the button is inline. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new("aria-label": "No effect")) %>
```

### Inline

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='inline'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new(inline: true, "aria-label": "No effect")) %>
```

### Styling the button

<Example src="<button aria-label='No effect' aria-expanded='false' type='button' data-view-component='true' class='custom-class p-1'>&hellip;</button>" />

```erb
<%= render(Primer::HellipButton.new(p: 1, classes: "custom-class", "aria-label": "No effect")) %>
```
