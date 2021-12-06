---
title: Label
componentId: label
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/label_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-label-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Label` to add contextual metadata to a design.

## Accessibility

Use `aria-label` if the `Label` or the context around it don't explain the label.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:span` | One of `:a`, `:div`, `:span`, or `:summary`. |
| `scheme` | `Symbol` | `nil` | One of `:danger`, `:info`, `:orange`, `:primary`, `:purple`, `:secondary`, `:success`, or `:warning`. |
| `size` | `Symbol` | `:medium` | One of `:large` and `:medium`. |
| `variant` | `Symbol` | `nil` | One of `nil` and `:inline`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Schemes

<Example src="<span data-view-component='true' class='Label'>Default</span><span data-view-component='true' class='Label Label--primary'>Primary</span><span data-view-component='true' class='Label Label--secondary'>Secondary</span><span data-view-component='true' class='Label Label--info'>Info</span><span data-view-component='true' class='Label Label--success'>Success</span><span data-view-component='true' class='Label Label--warning'>Warning</span><span data-view-component='true' class='Label Label--danger'>Danger</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Default" } %>
<%= render(Primer::LabelComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::LabelComponent.new(scheme: :secondary)) { "Secondary" } %>
<%= render(Primer::LabelComponent.new(scheme: :info)) { "Info" } %>
<%= render(Primer::LabelComponent.new(scheme: :success)) { "Success" } %>
<%= render(Primer::LabelComponent.new(scheme: :warning)) { "Warning" } %>
<%= render(Primer::LabelComponent.new(scheme: :danger)) { "Danger" } %>
```

### Sizes

<Example src="<span data-view-component='true' class='Label'>Medium</span><span data-view-component='true' class='Label Label--large'>Large</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Medium" } %>
<%= render(Primer::LabelComponent.new(size: :large)) { "Large" } %>
```

### Variants

<Example src="<span data-view-component='true' class='Label'>Default</span><span data-view-component='true' class='Label Label--inline'>Inline</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Default" } %>
<%= render(Primer::LabelComponent.new(variant: :inline)) { "Inline" } %>
```
