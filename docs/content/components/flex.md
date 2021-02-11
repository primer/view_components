---
title: Flex
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use FlexComponent to make an element lay out its content using the flexbox model.
Before using these utilities, you should be familiar with CSS3 Flexible Box
spec. If you are not, check out MDN's guide  [Using CSS Flexible
Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox).

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='bg-gray d-flex'>  <div class='border p-5 bg-gray-light'>Item 1</div>  <div class='border p-5 bg-gray-light'>Item 2</div>  <div class='border p-5 bg-gray-light'>Item 3</div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlexComponent.new(bg: :gray)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 3" } %>
<% end %>
```

### Justify center

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flex-justify-center bg-gray d-flex'>  <div class='border p-5 bg-gray-light'>Item 1</div>  <div class='border p-5 bg-gray-light'>Item 2</div>  <div class='border p-5 bg-gray-light'>Item 3</div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlexComponent.new(justify_content: :center, bg: :gray)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 3" } %>
<% end %>
```

### Align end

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flex-items-end bg-gray d-flex'>  <div class='border p-5 bg-gray-light'>Item 1</div>  <div class='border p-5 bg-gray-light'>Item 2</div>  <div class='border p-5 bg-gray-light'>Item 3</div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlexComponent.new(align_items: :end, bg: :gray)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 3" } %>
<% end %>
```

### Direction column

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='bg-gray flex-column d-flex'>  <div class='border p-5 bg-gray-light'>Item 1</div>  <div class='border p-5 bg-gray-light'>Item 2</div>  <div class='border p-5 bg-gray-light'>Item 3</div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlexComponent.new(direction: :column, bg: :gray)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :gray_light, classes: "border")) { "Item 3" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `justify_content` | `Symbol` | `JUSTIFY_CONTENT_DEFAULT` | Use this param to distribute space between and around flex items along the main axis of the container. One of `nil`, `:flex_start`, `:flex_end`, `:center`, `:space_between`, or `:space_around`. |
| `inline` | `Boolean` | `false` | Defaults to false. |
| `flex_wrap` | `Boolean` | `FLEX_WRAP_DEFAULT` | Defaults to nil. |
| `align_items` | `Symbol` | `ALIGN_ITEMS_DEFAULT` | Use this param to align items on the cross axis. One of `nil`, `:start`, `:end`, `:center`, `:baseline`, or `:stretch`. |
| `direction` | `Symbol` | `nil` | Use this param to define the orientation of the main axis (row or column). By default, flex items will display in a row. One of `nil`, `:column`, `:column_reverse`, `:row`, or `:row_reverse`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
