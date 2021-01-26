---
title: Text
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/text_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Text component is a wrapper component that will apply typography styles to the text inside.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 70px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><p class='text-bold'>Bold Text</p><p class='color-red-5'>Red Text</p></body></html>"></iframe>

```erb
<%= render(Primer::TextComponent.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
<%= render(Primer::TextComponent.new(tag: :p, color: :red_5)) { "Red Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
