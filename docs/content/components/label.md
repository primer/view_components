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
| `scheme` | `Symbol` | `:default` | One of `:accent`, `:attention`, `:danger`, `:default`, `:done`, `:info`, `:orange`, `:primary`, `:purple`, `:secondary`, `:severe`, `:sponsors`, `:success`, or `:warning`. |
| `size` | `Symbol` | `:medium` | One of `:large` or `:medium`. |
| `inline` | `Boolean` | `false` | Whether or not to render this label inline. |
| `variant` | `Symbol` | `:none` | One of `:inline`, `:large`, or `:none`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Schemes

<Example src="<span data-view-component='true' class='Label Label--large'>Default</span><span data-view-component='true' class='Label Label--primary Label--large'>Primary</span><span data-view-component='true' class='Label Label--secondary Label--large'>Secondary</span><span data-view-component='true' class='Label Label--accent Label--large'>Accent</span><span data-view-component='true' class='Label Label--success Label--large'>Success</span><span data-view-component='true' class='Label Label--attention Label--large'>Attention</span><span data-view-component='true' class='Label Label--danger Label--large'>Danger</span><span data-view-component='true' class='Label Label--severe Label--large'>Severe</span><span data-view-component='true' class='Label Label--done Label--large'>Done</span><span data-view-component='true' class='Label Label--sponsors Label--large'>Sponsors</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Default" } %>
<%= render(Primer::LabelComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::LabelComponent.new(scheme: :secondary)) { "Secondary" } %>
<%= render(Primer::LabelComponent.new(scheme: :accent)) { "Accent" } %>
<%= render(Primer::LabelComponent.new(scheme: :success)) { "Success" } %>
<%= render(Primer::LabelComponent.new(scheme: :attention)) { "Attention" } %>
<%= render(Primer::LabelComponent.new(scheme: :danger)) { "Danger" } %>
<%= render(Primer::LabelComponent.new(scheme: :severe)) { "Severe" } %>
<%= render(Primer::LabelComponent.new(scheme: :done)) { "Done" } %>
<%= render(Primer::LabelComponent.new(scheme: :sponsors)) { "Sponsors" } %>
```

### Sizes

<Example src="<span data-view-component='true' class='Label Label--large'>Medium</span><span data-view-component='true' class='Label Label--large'>Large</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Medium" } %>
<%= render(Primer::LabelComponent.new(size: :large)) { "Large" } %>
```

### Inline

<Example src="<span data-view-component='true' class='Label Label--large'>Default</span><span data-view-component='true' class='Label Label--large Label--inline'>Inline</span>" />

```erb
<%= render(Primer::LabelComponent.new) { "Default" } %>
<%= render(Primer::LabelComponent.new(inline: true)) { "Inline" } %>
```
