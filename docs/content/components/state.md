---
title: State
componentId: state
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/state_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-state-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `State` for rendering the status of an item.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` HTML attribute. |
| `scheme` | `Symbol` | `:default` | Background color. One of `:closed`, `:default`, `:green`, `:merged`, `:open`, `:purple`, or `:red`. |
| `tag` | `Symbol` | `:span` | HTML tag for element. One of `:div` and `:span`. |
| `size` | `Symbol` | `:default` | One of `:default` and `:small`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<span title='title' data-view-component='true' class='State'>State</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
```

### Schemes

<Example src="<span title='title' data-view-component='true' class='State'>Default</span><span title='title' data-view-component='true' class='State State--open'>Open</span><span title='title' data-view-component='true' class='State State--closed'>Closed</span><span title='title' data-view-component='true' class='State State--merged'>Merged</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", scheme: :open)) { "Open" } %>
<%= render(Primer::StateComponent.new(title: "title", scheme: :closed)) { "Closed" } %>
<%= render(Primer::StateComponent.new(title: "title", scheme: :merged)) { "Merged" } %>
```

### Sizes

<Example src="<span title='title' data-view-component='true' class='State'>Default</span><span title='title' data-view-component='true' class='State State--small'>Small</span>" />

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
```
