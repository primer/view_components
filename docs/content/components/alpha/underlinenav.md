---
title: UnderlineNav
componentId: underline_nav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/underline_nav.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-underline-nav
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `UnderlineNav` to style navigation links with a minimal
underlined selected state, typically placed at the top
of the page.
For panel navigation, use [UnderlinePanels](/components/alpha/underlinepanels) instead.

## Accessibility

- By default, `UnderlineNav` renders links within a `<nav>` element. `<nav>` has an
  implicit landmark role of `navigation` which should be reserved for main links.
  For all other set of links, set tag to `:div`.
- See [NavigationTab](/components/navigationtab) for additional
  accessibility considerations.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:nav` | One of `:div` and `:nav`. |
| `label` | `String` | N/A | Sets an `aria-label` that helps assistive technology users understand the purpose of the links, and distinguish it from similar elements. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `body_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the body wrapper. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use the tabs to list page links.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Use actions for a call to action.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:div` | One of `:div` and `:span`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default with `<nav>`

`<nav>` is a landmark and should be reserved for main navigation links. See [Accessibility](#accessibility).

<Example src="<nav aria-label='Default with nav element' data-view-component='true' class='UnderlineNav'>  <ul data-view-component='true' class='UnderlineNav-body list-style-none'>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Item 1    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Item 2    </a></li></ul>    <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>  Button!</button></div></nav>" />

```erb
<%= render(Primer::Alpha::UnderlineNav.new(label: "Default with nav element")) do |component| %>
  <% component.tab(href: "#", selected: true) { "Item 1" } %>
  <% component.tab(href: "#") { "Item 2" } %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With `<div>`

<Example src="<div data-view-component='true' class='UnderlineNav'>  <ul aria-label='With div element' data-view-component='true' class='UnderlineNav-body list-style-none'>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Item 1    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Item 2    </a></li></ul>    <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>  Button!</button></div></div>" />

```erb
<%= render(Primer::Alpha::UnderlineNav.new(tag: :div, label: "With div element")) do |component| %>
  <% component.tab(href: "#", selected: true) { "Item 1" } %>
  <% component.tab(href: "#") { "Item 2" } %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With icons and counters

<Example src="<nav aria-label='With icons and counters' data-view-component='true' class='UnderlineNav'>  <ul data-view-component='true' class='UnderlineNav-body list-style-none'>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>    <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-star UnderlineNav-octicon'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 1</span>    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>    <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-star UnderlineNav-octicon'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 2</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 3</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a></li></ul>    <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>  Button!</button></div></nav>" />

```erb
<%= render(Primer::Alpha::UnderlineNav.new(label: "With icons and counters")) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.icon(icon: :star) %>
    <% t.text { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.icon(icon: :star) %>
    <% t.text { "Item 2" } %>
    <% t.counter(count: 10) %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.text { "Item 3" } %>
    <% t.counter(count: 10) %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Align right

<Example src="<nav aria-label='Align right' data-view-component='true' class='UnderlineNav UnderlineNav--right'>    <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>  Button!</button></div>  <ul data-view-component='true' class='UnderlineNav-body list-style-none'>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 1</span>    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 2</span>    </a></li></ul></nav>" />

```erb
<%= render(Primer::Alpha::UnderlineNav.new(label: "Align right", align: :right)) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.text { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.text { "Item 2" } %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Customizing the body

<Example src="<nav aria-label='Default' data-view-component='true' class='UnderlineNav'>  <ul data-view-component='true' class='UnderlineNav-body custom-class list-style-none border color-border-accent-emphasis'>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Tab 1    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 2    </a></li>      <li data-view-component='true' class='d-inline-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 3    </a></li></ul>    </nav>" />

```erb
<%= render(Primer::Alpha::UnderlineNav.new(label: "Default", body_arguments: { classes: "custom-class", border: true, border_color: :accent_emphasis })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```
