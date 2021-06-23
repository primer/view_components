---
title: Popover
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/popover_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-popover-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Popover` to bring attention to specific user interface elements, typically to suggest an action or to guide users through a new experience.

By default, the popover renders with absolute positioning, meaning it should usually be wrapped in an element with a relative position in order to be positioned properly. To render the popover with relative positioning, use the relative property.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Heading`

The heading

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Body`

The body

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `caret` | `Symbol` | N/A | One of `:bottom`, `:bottom_left`, `:bottom_right`, `:left`, `:left_bottom`, `:left_top`, `:right`, `:right_bottom`, `:right_top`, `:top`, `:top_left`, or `:top_right`. |
| `large` | `Boolean` | N/A | Whether to use the large version of the component. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='' class='Popover position-relative right-0 left-0'>  <div data-view-component='' class='Popover-message Box p-4 mt-2 mx-auto text-left color-shadow-large'>    <h4 data-view-component='' class='mb-2'>    Activity feed</h4>        This is the Popover body.</div></div>" />

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.heading do %>
    Activity feed
  <% end %>
  <% component.body do %>
    This is the Popover body.
  <% end %>
<% end %>
```

### Large

<Example src="<div data-view-component='' class='Popover position-relative right-0 left-0'>  <div data-view-component='' class='Popover-message Box Popover-message--large p-4 mt-2 mx-auto text-left color-shadow-large'>    <h4 data-view-component='' class='mb-2'>    Activity feed</h4>        This is the large Popover body.</div></div>" />

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.heading do %>
    Activity feed
  <% end %>
  <% component.body(large: true) do %>
    This is the large Popover body.
  <% end %>
<% end %>
```

### Caret position

<Example src="<div data-view-component='' class='Popover position-relative right-0 left-0'>  <div data-view-component='' class='Popover-message Box Popover-message--left p-4 mt-2 mx-auto text-left color-shadow-large'>    <h4 data-view-component='' class='mb-2'>    Activity feed</h4>        This is the Popover body.</div></div>" />

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.heading do %>
    Activity feed
  <% end %>
  <% component.body(caret: :left) do %>
    This is the Popover body.
  <% end %>
<% end %>
```

### With HTML body

<Example src="<div data-view-component='' class='Popover position-relative right-0 left-0'>  <div data-view-component='' class='Popover-message Box Popover-message--left p-4 mt-2 mx-auto text-left color-shadow-large'>    <h4 data-view-component='' class='mb-2'>    Activity feed</h4>        <p> This is the Popover body.</p>    <div>      This is using HTML.      <ul>        <li>Thing #1</li>        <li>Thing #2</li>      </ul>    </div></div></div>" />

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.heading do %>
    Activity feed
  <% end %>
  <% component.body(caret: :left) do %>
    <p> This is the Popover body.</p>
    <div>
      This is using HTML.
      <ul>
        <li>Thing #1</li>
        <li>Thing #2</li>
      </ul>
    </div>
  <% end %>
<% end %>
```
