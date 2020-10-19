---
title: Primer::BorderBoxComponent
---

BorderBox is a Box component with a border.

## Examples

### Header, body, rows and footer

<iframe style="width: 100%; border: 0px; height: 350px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Box '>    <div class='Box-header '>      Header</div>    <div class='Box-body '>      Body</div>    <ul>        <li class='Box-row '>          Row one</li>        <li class='Box-row '>          Row two</li>        <li class='Box-row '>          Row three</li>    </ul>    <div class='Box-footer '>      Footer</div></div></body></html>"></iframe>

```erb
<%= render(Primer::BorderBoxComponent.new) do |component|
  component.slot(:header) { "Header" }
  component.slot(:body) { "Body" }
  component.slot(:row) { "Row one" }
  component.slot(:row) { "Row two" }
  component.slot(:row) { "Row three" }
  component.slot(:footer) { "Footer" }
end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to `Primer::Classify` |
### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to `Primer::Classify` |

### `body` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to `Primer::Classify` |

### `footer` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to `Primer::Classify` |

### `row` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to `Primer::Classify` |

