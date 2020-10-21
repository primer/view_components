---
title: State
---

Component for rendering the status of an item.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>State</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
```

### Colors

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>Default</span><span title='title' class='State State--green '>Green</span><span title='title' class='State State--red '>Red</span><span title='title' class='State State--purple '>Purple</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :green)) { "Green" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :red)) { "Red" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :purple)) { "Purple" } %>
```

### Sizes

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>Default</span><span title='title' class='State State--small '>Small</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` HTML attribute. |
| `color` | `Symbol` | `COLOR_DEFAULT` | Background color. One of `:default`, `:green`, `:red`, or `:purple`. |
| `tag` | `Symbol` | `TAG_DEFAULT` | HTML tag for element. One of `:span`, `:div`, or `:a`. |
| `size` | `Symbol` | `SIZE_DEFAULT` | One of `:default` and `:small`. |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
