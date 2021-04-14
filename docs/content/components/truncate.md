---
title: Truncate
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/truncate_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-truncate-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TruncateComponent to shorten overflowing text with an ellipsis.

## Examples

### Default

<Example src="<div class='col-2'>  <p class='css-truncate css-truncate-overflow '>branch-name-that-is-really-long</p></div>" />

```erb
<div class="col-2">
  <%= render(Primer::TruncateComponent.new(tag: :p)) { "branch-name-that-is-really-long" } %>
</div>
```

### Inline

<Example src="<span class='css-truncate css-truncate-target '>branch-name-that-is-really-long</span>" />

```erb
<%= render(Primer::TruncateComponent.new(tag: :span, inline: true)) { "branch-name-that-is-really-long" } %>
```

### Expandable

<Example src="<span class='css-truncate css-truncate-target expandable '>branch-name-that-is-really-long</span>" />

```erb
<%= render(Primer::TruncateComponent.new(tag: :span, inline: true, expandable: true)) { "branch-name-that-is-really-long" } %>
```

### Custom size

<Example src="<span style='max-width: 100px;' class='css-truncate css-truncate-target expandable '>branch-name-that-is-really-long</span>" />

```erb
<%= render(Primer::TruncateComponent.new(tag: :span, inline: true, expandable: true, max_width: 100)) { "branch-name-that-is-really-long" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `inline` | `Boolean` | `false` | Whether the element is inline (or inline-block). |
| `expandable` | `Boolean` | `false` | Whether the entire string should be revealed on hover. Can only be used in conjunction with `inline`. |
| `max_width` | `Integer` | `nil` | Sets the max-width of the text. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
