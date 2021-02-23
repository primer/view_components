---
title: State
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/state_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-state-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Component for rendering the status of an item.

## Examples

### Default

<IFrame height="auto" content="<span title='title' class='State '>State</span>"></IFrame>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "State" } %>
```

### Colors

<IFrame height="auto" content="<span title='title' class='State '>Default</span><span title='title' class='State State--green '>Green</span><span title='title' class='State State--red '>Red</span><span title='title' class='State State--purple '>Purple</span>"></IFrame>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :green)) { "Green" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :red)) { "Red" } %>
<%= render(Primer::StateComponent.new(title: "title", color: :purple)) { "Purple" } %>
```

### Sizes

<IFrame height="auto" content="<span title='title' class='State '>Default</span><span title='title' class='State State--small '>Small</span>"></IFrame>

```erb
<%= render(Primer::StateComponent.new(title: "title")) { "Default" } %>
<%= render(Primer::StateComponent.new(title: "title", size: :small)) { "Small" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | `title` HTML attribute. |
| `color` | `Symbol` | `:default` | Background color. One of `:default`, `:green`, `:red`, or `:purple`. |
| `tag` | `Symbol` | `:span` | HTML tag for element. One of `:span`, `:div`, or `:a`. |
| `size` | `Symbol` | `:default` | One of `:default` and `:small`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
