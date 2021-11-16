---
title: Subhead
componentId: subhead
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/subhead_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-subhead-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Subhead` as the start of a section. The `:heading` slot will render an `<h2>` font-sized text.

- Optionally set the `:description` slot to render a short description and the `:actions` slot for a related action.
- Use a succint, one-line description for the `:description` slot. For longer descriptions, omit the description slot and render a paragraph below the `Subhead`.
- Use the actions slot to render a related action to the right of the heading. Use [Button](/components/button) or [Link](/components/link).

## Accessibility

The `:heading` slot defaults to rendering a `<div>`. Update the tag to a heading element with the appropriate level to improve page navigation for assistive technologies.
[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `spacious` | `Boolean` | `false` | Whether to add spacing to the Subhead. |
| `hide_border` | `Boolean` | `false` | Whether to hide the border under the heading. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Heading`

The heading

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | N/A | One of `:div`, `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, or `:h6`. |
| `danger` | `Boolean` | N/A | Whether to style the heading as dangerous. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Actions

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Description`

The description

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='Subhead'>  <h3 data-view-component='true' class='Subhead-heading'>    My Heading</h3>    <div data-view-component='true' class='Subhead-description'>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading(tag: :h3) do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
<% end %>
```

### With dangerous heading

<Example src="<div data-view-component='true' class='Subhead'>  <h3 data-view-component='true' class='Subhead-heading Subhead-heading--danger'>    My Heading</h3>    <div data-view-component='true' class='Subhead-description'>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading(tag: :h3, danger: true) do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
<% end %>
```

### With long description

<Example src="<div data-view-component='true' class='Subhead'>  <h3 data-view-component='true' class='Subhead-heading'>    My Heading</h3>    </div><p> This is a longer description that is sitting below the Subhead. It's much longer than a description that could sit comfortably in the Subhead. </p>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading(tag: :h3) do %>
    My Heading
  <% end %>
<% end %>
<p> This is a longer description that is sitting below the Subhead. It's much longer than a description that could sit comfortably in the Subhead. </p>
```

### Without border

<Example src="<div data-view-component='true' class='Subhead border-bottom-0 mb-0'>  <div data-view-component='true' class='Subhead-heading'>    My Heading</div>    <div data-view-component='true' class='Subhead-description'>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
  <% component.heading do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
<% end %>
```

### With actions

<Example src="<div data-view-component='true' class='Subhead'>  <div data-view-component='true' class='Subhead-heading'>    My Heading</div>  <div data-view-component='true' class='Subhead-actions'>    <a href='http://www.google.com' data-view-component='true' class='btn-danger btn'>  Action</a></div>  <div data-view-component='true' class='Subhead-description'>    My Description</div></div>" />

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.heading do %>
    My Heading
  <% end %>
  <% component.description do %>
    My Description
  <% end %>
  <% component.actions do %>
    <%= render(
      Primer::ButtonComponent.new(
        tag: :a, href: "http://www.google.com", scheme: :danger
      )
    ) { "Action" } %>
  <% end %>
<% end %>
```
