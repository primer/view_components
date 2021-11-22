---
title: ButtonMarketing
componentId: button_marketing
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/button_marketing.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-button-marketing
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `ButtonMarketing` for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:outline`, `:primary`, or `:transparent`. |
| `variant` | `Symbol` | `:default` | One of `:default` and `:large`. |
| `tag` | `Symbol` | `:button` | One of `:a` and `:button`. |
| `type` | `Symbol` | `:button` | One of `:button` and `:submit`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Schemes

<Example src="<button type='button' data-view-component='true' class='btn-mktg mr-2'>Default</button><button type='button' data-view-component='true' class='btn-mktg btn-signup-mktg mr-2'>Primary</button><button type='button' data-view-component='true' class='btn-mktg btn-muted-mktg'>Outline</button><div class='color-bg-emphasis'>  <button type='button' data-view-component='true' class='btn-mktg btn-subtle-mktg'>Transparent</button></div>" />

```erb
<%= render(Primer::Alpha::ButtonMarketing.new(mr: 2)) { "Default" } %>
<%= render(Primer::Alpha::ButtonMarketing.new(scheme: :primary, mr: 2)) { "Primary" } %>
<%= render(Primer::Alpha::ButtonMarketing.new(scheme: :outline)) { "Outline" } %>
<div class="color-bg-emphasis">
  <%= render(Primer::Alpha::ButtonMarketing.new(scheme: :transparent)) { "Transparent" } %>
</div>
```

### Sizes

<Example src="<button type='button' data-view-component='true' class='btn-mktg mr-2'>Default</button><button type='button' data-view-component='true' class='btn-mktg btn-large-mktg'>Large</button>" />

```erb
<%= render(Primer::Alpha::ButtonMarketing.new(mr: 2)) { "Default" } %>
<%= render(Primer::Alpha::ButtonMarketing.new(variant: :large)) { "Large" } %>
```
