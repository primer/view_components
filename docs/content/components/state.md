---
title: State
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/state_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-state-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Component for rendering the status of an item.

## Examples

### Default

<Example src="<span title='title' class='State '>State</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
```

### Colors

<Example src="<span title='title' class='State '>Default</span><span title='title' class='State State--open '>Open</span><span title='title' class='State State--closed '>Closed</span><span title='title' class='State State--merged '>Merged</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :open)) { "Open" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :closed)) { "Closed" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :merged)) { "Merged" } %>
```

### Sizes

<Example src="<span title='title' class='State '>Default</span><span title='title' class='State State--small '>Small</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` HTML attribute. |
| `color` | `Symbol` | `:default` | Background color. One of `:open`, `:closed`, `:merged`, `:default`, `:green`, `:red`, or `:purple`. |
| `tag` | `Symbol` | `:span` | HTML tag for element. One of `:span`, `:div`, or `:a`. |
| `size` | `Symbol` | `:default` | One of `:default` and `:small`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
