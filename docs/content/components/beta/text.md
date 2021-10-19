---
title: Text
componentId: text
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/text.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-text
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Text` is a wrapper component that will apply typography styles to the text inside.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:span` |  |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<p data-view-component='true' class='text-bold'>Bold Text</p><p data-view-component='true' class='color-fg-danger'>Danger Text</p>" />

```erb
<%= render(Primer::Beta::Text.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
<%= render(Primer::Beta::Text.new(tag: :p, color: :danger)) { "Danger Text" } %>
```
