---
title: BorderBox
componentId: border_box
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/border_box_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-border-box-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`BorderBox` is a Box component with a border.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `padding` | `Symbol` | `:default` | One of `:condensed`, `:default`, or `:spacious`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Header`

Optional Header.

When using header.title, the recommended tag is a heading tag, such as h1, h2, h3, etc.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Body`

Optional Body.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Footer`

Optional Footer.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Rows`

Use Rows to add rows with borders and maintain the same padding.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | N/A | Color scheme. One of `:default`, `:info`, `:neutral`, or `:warning`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Header with title, body, rows, and footer

<Example src="<div data-view-component='true' class='Box'>  <div data-view-component='true' class='Box-header'>  <h2 data-view-component='true' class='Box-title'>      Header</h2>  </div>  <div data-view-component='true' class='Box-body'>    Body</div>    <ul>        <li data-view-component='true' class='Box-row'>      Row one</li>        <li data-view-component='true' class='Box-row'>    Row two</li>    </ul>  <div data-view-component='true' class='Box-footer'>    Footer</div></div>" />

```erb
<%= render(Primer::BorderBoxComponent.new) do |component| %>
  <% component.header do |h| %>
    <% h.title(tag: :h2) do %>
      Header
    <% end %>
  <% end %>
  <% component.body do %>
    Body
  <% end %>
  <% component.row do %>
    <% if true %>
      Row one
    <% end %>
  <% end %>
  <% component.row do %>
    Row two
  <% end %>
  <% component.footer do %>
    Footer
  <% end %>
<% end %>
```

### Padding density

<Example src="<div data-view-component='true' class='Box Box--condensed'>  <div data-view-component='true' class='Box-header'>        Header</div>  <div data-view-component='true' class='Box-body'>    Body</div>    <ul>        <li data-view-component='true' class='Box-row'>    Row two</li>    </ul>  <div data-view-component='true' class='Box-footer'>    Footer</div></div>" />

```erb
<%= render(Primer::BorderBoxComponent.new(padding: :condensed)) do |component| %>
  <% component.header do %>
    Header
  <% end %>
  <% component.body do %>
    Body
  <% end %>
  <% component.row do %>
    Row two
  <% end %>
  <% component.footer do %>
    Footer
  <% end %>
<% end %>
```

### Row colors

<Example src="<div data-view-component='true' class='Box'>        <ul>        <li data-view-component='true' class='Box-row'>    Default</li>        <li data-view-component='true' class='Box-row Box-row--gray'>    Neutral</li>        <li data-view-component='true' class='Box-row Box-row--blue'>    Info</li>        <li data-view-component='true' class='Box-row Box-row--yellow'>    Warning</li>    </ul>  </div>" />

```erb
<%= render(Primer::BorderBoxComponent.new) do |component| %>
  <% component.row do %>
    Default
  <% end %>
  <% component.row(scheme: :neutral) do %>
    Neutral
  <% end %>
  <% component.row(scheme: :info) do %>
    Info
  <% end %>
  <% component.row(scheme: :warning) do %>
    Warning
  <% end %>
<% end %>
```
