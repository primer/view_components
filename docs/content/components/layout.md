---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-layout-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Examples

### Sidebar widths

<Example src="  <div data-view-component='true' class='Layout'>    Example</div>  <div data-view-component='true' class='Layout Layout--sidebar-narrow'>    Example</div>  <div data-view-component='true' class='Layout Layout--sidebar-wide'>    Example</div>" />

```erb

<%= render(Primer::Layout.new(sidebar_width: :default)) { "Example" } %>
<%= render(Primer::Layout.new(sidebar_width: :narrow)) { "Example" } %>
<%= render(Primer::Layout.new(sidebar_width: :wide)) { "Example" } %>
```

### Gutters

<Example src="  <div data-view-component='true' class='Layout'>    Example</div>  <div data-view-component='true' class='Layout Layout--gutter-none'>    Example</div>  <div data-view-component='true' class='Layout Layout--gutter-condensed'>    Example</div>  <div data-view-component='true' class='Layout Layout--gutter-spacious'>    Example</div>" />

```erb

<%= render(Primer::Layout.new(gutter: :default)) { "Example" } %>
<%= render(Primer::Layout.new(gutter: :none)) { "Example" } %>
<%= render(Primer::Layout.new(gutter: :condensed)) { "Example" } %>
<%= render(Primer::Layout.new(gutter: :spacious)) { "Example" } %>
```

### Using containers

<Example src="  <div data-view-component='true' class='Layout'>    Example</div><div data-view-component='true' class='container-xl'>  <div data-view-component='true' class='Layout'>    Example</div></div><div data-view-component='true' class='container-lg'>  <div data-view-component='true' class='Layout'>    Example</div></div><div data-view-component='true' class='container-md'>  <div data-view-component='true' class='Layout'>    Example</div></div>" />

```erb

<%= render(Primer::Layout.new(container: :full)) { "Example" } %>
<%= render(Primer::Layout.new(container: :xl)) { "Example" } %>
<%= render(Primer::Layout.new(container: :lg)) { "Example" } %>
<%= render(Primer::Layout.new(container: :md)) { "Example" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `container` | `Symbol` | `:full` | Container to wrap the layout in. One of `:full`, `:xl`, `:lg`, or `:md`. |
| `sidebar_width` | `Symbol` | `:default` | One of `:default`, `:narrow`, or `:wide`. |
| `gutter` | `Symbol` | `:default` | Space between `main` and `sidebar`. One of `:default`, `:none`, `:condensed`, or `:spacious`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
