---
title: Label
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/label_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-label-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Label` to add contextual metadata to a design.

## Examples

### Schemes

<Example src="<span title='Label: Label' data-view-component='true' class='Label'>Default</span><span title='Label: Label' data-view-component='true' class='Label Label--primary'>Primary</span><span title='Label: Label' data-view-component='true' class='Label Label--secondary'>Secondary</span><span title='Label: Label' data-view-component='true' class='Label Label--info'>Info</span><span title='Label: Label' data-view-component='true' class='Label Label--success'>Success</span><span title='Label: Label' data-view-component='true' class='Label Label--warning'>Warning</span><span title='Label: Label' data-view-component='true' class='Label Label--danger'>Danger</span>" />

```erb
<%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :primary)) { "Primary" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :secondary)) { "Secondary" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :info)) { "Info" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :success)) { "Success" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :warning)) { "Warning" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :danger)) { "Danger" } %>
```

### Variants

<Example src="<span title='Label: Label' data-view-component='true' class='Label'>Default</span><span title='Label: Label' data-view-component='true' class='Label Label--large'>Large</span>" />

```erb
<%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:span` | One of `:a`, `:div`, `:span`, or `:summary`. |
| `title` | `String` | N/A | `title` attribute for the component element. |
| `scheme` | `Symbol` | `nil` | One of `:danger`, `:info`, `:orange`, `:primary`, `:purple`, `:secondary`, `:success`, or `:warning`. |
| `variant` | `Symbol` | `nil` | One of `nil`, `:inline`, or `:large`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
