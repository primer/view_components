---
title: ButtonGroup
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_group_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use ButtonGroupComponent to render a series of buttons.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='BtnGroup '>    <button type='button' class='btn BtnGroup-item '>Default</button>    <button type='button' class='btn BtnGroup-item btn-primary '>Primary</button>    <button type='button' class='btn BtnGroup-item btn-danger '>Danger</button>    <button type='button' class='btn BtnGroup-item btn-outline '>Outline</button>    <button type='button' class='btn BtnGroup-item my-class '>Custom class</button></div></body></html>"></iframe>

```erb
<%= render(Primer::ButtonGroupComponent.new) do |component|
  component.button { "Default" }
  component.button(button_type: :primary) { "Primary" }
  component.button(button_type: :danger) { "Danger" }
  component.button(button_type: :outline) { "Outline" }
  component.button(classes: "my-class") { "Custom class" }
end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
