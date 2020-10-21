---
title: Label
---

Use labels to add contextual metadata to a design.

## Examples

### Schemes

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span title='Label: Label' class='Label bg-blue'>default</span><span title='Label: Label' class='Label Label--gray '>gray</span><span title='Label: Label' class='Label Label--gray-darker '>dark_gray</span><span title='Label: Label' class='Label Label--yellow '>yellow</span><span title='Label: Label' class='Label Label--green '>green</span><span title='Label: Label' class='Label Label--purple '>purple</span></body></html>"></iframe>

```erb
<%= render(Primer::LabelComponent.new(title: "Label: Label")) { "default" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :gray)) { "gray" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :dark_gray)) { "dark_gray" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :yellow)) { "yellow" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :green)) { "green" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", scheme: :purple)) { "purple" } %>
```

### Variants

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span title='Label: Label' class='Label bg-blue'>Default</span><span title='Label: Label' class='Label Label--large bg-blue'>Large</span></body></html>"></iframe>

```erb
<%= render(Primer::LabelComponent.new(title: "Label: Label")) { "Default" } %>
<%= render(Primer::LabelComponent.new(title: "Label: Label", variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` attribute for the component element. |
| `scheme` | `Symbol` | `nil` | One of `:gray`, `:dark_gray`, `:yellow`, `:orange`, `:red`, `:green`, `:blue`, `:purple`, `:pink`, `:outline`, `:green_outline`, or `nil`. |
| `variant` | `Symbol` | `nil` | One of `:large`, `:inline`, or `nil`. |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
