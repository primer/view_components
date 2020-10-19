---
title: Primer::BaseComponent
---

Base component used by other Primer components.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 34px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><a href='http://www.google.com' class='mt-4'>Link</a></body></html>"></iframe>

```erb
<%= render(Primer::BaseComponent.new(tag: :a, href: "http://www.google.com", mt: 4)) { "Link" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `` | HTML tag name to be passed to tag.send(tag) |
| `classes` | `String` | `nil` | CSS class name value to be concatenated with generated Primer CSS classes |
