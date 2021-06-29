---
title: TabNav
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-tab-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `TabNav` to style navigation with a tab-based selected state. There are two main ways this component can be rendered:

- With tabs that hold links for page navigation. This is the default.
- With tabs that hold buttons and a configurable panel for panel navigation. This is configured with `with_panel` and has associated JavaScript behavior.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | Used to set the `aria-label` on the top level element. |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. When true, [TabContainer](/components/tabcontainer) is rendered along with JavaScript behavior. Additionally, the `tab` slot will render as a button as opposed to an anchor. |
| `body_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the body wrapper. |
| `wrapper_arguments` | `Hash` | `{}` | [System arguments](/system-arguments) for the `TabContainer` wrapper. Only applies if `with_panel` is `true`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use the tabs to list navigation items. By default, an anchor tag is rendered for page navigation. When `with_panel` is set on the parent, this renders as a button
with a configurable panel slot. See the example below or refer to [NavigationTab](/components/navigationtab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Extra`

Renders extra content to the `TabNav`. This will be rendered after the tabs.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `align` | `Symbol` | N/A | One of `:left` and `:right`. |

## Examples

### Default

<Example src="  <nav aria-label='Default' data-view-component='true' class='tabnav'>        <ul data-view-component='true' class='tabnav-tabs'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 3    </a></li></ul>    </nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "Default")) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```

### With panels

<Example src="<tab-container data-view-component='true'>  <div data-view-component='true' class='tabnav'>        <ul role='tablist' aria-label='With panels' data-view-component='true' class='tabnav-tabs'>        <li role='presentation' data-view-component='true' class='d-flex'>  <button type='button' role='tab' aria-selected='true' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Tab 1</span>    </button></li>        <li role='presentation' data-view-component='true' class='d-flex'>  <button type='button' role='tab' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Tab 2</span>    </button></li>        <li role='presentation' data-view-component='true' class='d-flex'>  <button type='button' role='tab' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Tab 3</span>    </button></li></ul>    </div>      <div role='tabpanel' data-view-component='true'>      Panel 1</div>      <div role='tabpanel' hidden='hidden' data-view-component='true'>      Panel 2</div>      <div role='tabpanel' hidden='hidden' data-view-component='true'>      Panel 3</div></tab-container>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "With panels", with_panel: true)) do |c| %>
  <% c.tab(selected: true) do |t| %>
    <% t.text { "Tab 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.text { "Tab 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.text { "Tab 3" } %>
    <% t.panel do %>
      Panel 3
    <% end %>
  <% end %>
<% end %>
```

### With icons and counters

<Example src="  <nav aria-label='With icons and counters' data-view-component='true' class='tabnav'>        <ul data-view-component='true' class='tabnav-tabs'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-star'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 1</span>    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-star'>    <path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span data-view-component='true'>Item 2</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          <span data-view-component='true'>Item 3</span>    <span title='10' data-view-component='true' class='Counter'>10</span></a></li></ul>    </nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "With icons and counters")) do |component| %>
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
<% end %>
```

### With extra content

<Example src="  <nav aria-label='With extra content' data-view-component='true' class='tabnav'>        <button type='button' data-view-component='true' class='btn float-right'>    Button  </button>    <ul data-view-component='true' class='tabnav-tabs'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 3    </a></li></ul>    </nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "With extra content")) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
  <% c.extra do %>
    <%= render(Primer::ButtonComponent.new(float: :right)) { "Button" } %>
  <% end %>
<% end %>
```

### Adding extra content after the tabs

<Example src="  <nav aria-label='Adding extra content after the tabs' data-view-component='true' class='tabnav d-flex'>        <ul data-view-component='true' class='tabnav-tabs flex-1'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 3    </a></li></ul>        <div>      <button type='button' data-view-component='true' class='btn'>    Button  </button>    </div></nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "Adding extra content after the tabs", display: :flex, body_arguments: { flex: 1 })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
  <% c.extra(align: :right) do %>
    <div>
      <%= render(Primer::ButtonComponent.new) { "Button" } %>
    </div>
  <% end %>
<% end %>
```

### Customizing the body

<Example src="  <nav aria-label='Default' data-view-component='true' class='tabnav'>        <ul data-view-component='true' class='tabnav-tabs custom-class border color-border-info'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 3    </a></li></ul>    </nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "Default", body_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```

### Customizing the wrapper

<Example src="  <nav aria-label='Default' data-view-component='true' class='tabnav'>        <ul data-view-component='true' class='tabnav-tabs'>        <li data-view-component='true' class='d-flex'>  <a href='#' aria-current='page' data-view-component='true' class='tabnav-tab'>          Tab 1    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 2    </a></li>        <li data-view-component='true' class='d-flex'>  <a href='#' data-view-component='true' class='tabnav-tab'>          Tab 3    </a></li></ul>    </nav>" />

```erb
<%= render(Primer::TabNavComponent.new(label: "Default", wrapper_arguments: { classes: "custom-class", border: true, border_color: :info })) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```
