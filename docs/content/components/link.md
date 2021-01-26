---
title: Link
source: https://github.com/primer/view_components/tree/main/app/components/primer/link_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use links for moving from one page to another. The Link component styles anchor tags with default blue styling and hover text-decoration.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><a href='http://www.google.com'>Link</a></body></html>"></iframe>

```erb
<%= render(Primer::LinkComponent.new(href: "http://www.google.com")) { "Link" } %>
```

### Muted

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><a href='http://www.google.com' class='muted-link '>Link</a></body></html>"></iframe>

```erb
<%= render(Primer::LinkComponent.new(href: "http://www.google.com", muted: true)) { "Link" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | URL to be used for the Link |
| `muted` | `Boolean` | `false` | Uses light gray for Link color, and blue on hover |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
