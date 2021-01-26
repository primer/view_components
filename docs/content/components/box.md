---
title: Box
source: https://github.com/primer/view_components/tree/main/app/components/primer/box_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

A basic wrapper component for most layout related needs.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 20px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div>Your content here</div></body></html>"></iframe>

```erb
<%= render(Primer::BoxComponent.new) { "Your content here" } %>
```

### Color and padding

<iframe style="width: 100%; border: 0px; height: 54px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='bg-gray p-3'>Hello world</div></body></html>"></iframe>

```erb
<%= render(Primer::BoxComponent.new(bg: :gray, p: 3)) { "Hello world" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
