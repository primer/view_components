---
title: UnderlineNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/underline_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-underline-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `UnderlineNav` to style navigation with a minimal
underlined selected state, typically used for navigation placed at the top
of the page.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | The `aria-label` on top level `<nav>` element. |
| `with_panel` | `Boolean` | `false` | Whether the `UnderlineNav` should navigate through pages or panels. When true, [TabContainer](/components/tabcontainer) is rendered along with JavaScript behavior. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `body_arguments` | `Hash` | `{ tag: BODY_TAG_DEFAULT }` | [System arguments](/system-arguments) for the body wrapper. |
| `wrapper_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the `TabContainer` wrapper. Only applies if `with_panel` is `true`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use the tabs to list navigation items. When `with_panel` is set on the parent, a button is rendered for panel navigation. Otherwise,
an anchor tag is rendered for page navigation. For more information, refer to [NavigationTab](/components/navigationtab).

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

### Default

<Example src="  <nav aria-label='Default' data-view-component='true' class='UnderlineNav'>    <div data-view-component='true' class='UnderlineNav-body'>          <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Item 1    </a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>          Item 2    </a></div>      <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "Default")) do |component| %>
  <% component.tab(href: "#", selected: true) { "Item 1" } %>
  <% component.tab(href: "#") { "Item 2" } %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With icons and counters

<Example src="  <nav aria-label='With icons and counters' data-view-component='true' class='UnderlineNav'>    <div data-view-component='true' class='UnderlineNav-body'>          <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-star UnderlineNav-octicon'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 1</span>    </a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-star UnderlineNav-octicon'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 2</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 3</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a></div>      <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "With icons and counters")) do |component| %>
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

<Example src="  <nav aria-label='Align right' data-view-component='true' class='UnderlineNav UnderlineNav--right'>      <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div>    <div data-view-component='true' class='UnderlineNav-body'>          <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 1</span>    </a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 2</span>    </a></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "Align right", align: :right)) do |component| %>
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

### As a list

<Example src="  <nav aria-label='As a list' data-view-component='true' class='UnderlineNav'>    <ul data-view-component='true' class='UnderlineNav-body list-style-none'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 1</span>    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 2</span>    </a></li></ul>      <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "As a list", body_arguments: { tag: :ul })) do |component| %>
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

### With panels

<Example src="<tab-container data-view-component='true'>  <div data-view-component='true' class='UnderlineNav'>    <div role='tablist' aria-label='With panels' data-view-component='true' class='UnderlineNav-body'>          <button type='button' role='tab' aria-selected='true' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 1</span>    </button>          <button type='button' role='tab' data-view-component='true' class='UnderlineNav-item'>          <span data-view-component='true'>Item 2</span>    </button></div>      <div data-view-component='true' class='UnderlineNav-actions'>    <button type='button' data-view-component='true' class='btn'>    Button!  </button></div></div>      <div role='tabpanel' data-view-component='true'>      Panel 1</div>      <div role='tabpanel' hidden='hidden' data-view-component='true'>      Panel 2</div></tab-container>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "With panels", with_panel: true)) do |component| %>
  <% component.tab(selected: true) do |t| %>
    <% t.text { "Item 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab do |t| %>
    <% t.text { "Item 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Customizing the body

<Example src="  <nav aria-label='Default' data-view-component='true' class='UnderlineNav'>    <ul data-view-component='true' class='UnderlineNav-body custom-class list-style-none border color-border-info'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 3    </a></li></ul>      </nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "Default", body_arguments: { tag: :ul, classes: "custom-class", border: true, border_color: :info })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```

### Customizing the wrapper

<Example src="  <nav aria-label='Default' data-view-component='true' class='UnderlineNav'>    <div data-view-component='true' class='UnderlineNav-body'>          <a href='#' aria-current='page' data-view-component='true' class='UnderlineNav-item'>          Tab 1    </a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 2    </a>          <a href='#' data-view-component='true' class='UnderlineNav-item'>          Tab 3    </a></div>      </nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(label: "Default", wrapper_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```
