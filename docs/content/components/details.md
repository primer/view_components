---
title: Details
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-details-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `DetailsComponent` to reveal content after clicking a button.

## Examples

### Default

<Example src="" />

```erb

<%= render Primer::DetailsComponent.new do |c| %>
  component.summary do
    "Summary"
  end
  component.body do
    "Body"
  end
<% end %>
```
