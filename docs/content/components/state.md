---
title: State
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/state_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Component for rendering the status of an item.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>State</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
```

### Colors

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>Default</span><span title='title' class='State State--open '>Open</span><span title='title' class='State State--closed '>Closed</span><span title='title' class='State State--merged '>Merged</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :open)) { "Open" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :closed)) { "Closed" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :merged)) { "Merged" } %>
```

### Sizes

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span title='title' class='State '>Default</span><span title='title' class='State State--small '>Small</span></body></html>"></iframe>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` HTML attribute. |
| `color` | `Symbol` | `:default` | Background color. One of `:open`, `:closed`, `:merged`, `:default`, `:green`, `:red`, or `:purple`. |
| `tag` | `Symbol` | `:span` | HTML tag for element. One of `:span`, `:div`, or `:a`. |
| `size` | `Symbol` | `:default` | One of `:default` and `:small`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
