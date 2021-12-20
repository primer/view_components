---
title: AutocompleteItem
componentId: autocomplete_item
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/autocomplete/item.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-autocomplete-item
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `AutocompleteItem` to list results of an auto-completed search.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `value` | `String` | N/A | Value of the item. |
| `selected` | `Boolean` | `false` | Whether the item is selected. |
| `disabled` | `Boolean` | `false` | Whether the item is disabled. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<li role='option' data-autocomplete-value='value' aria-selected='true' data-view-component='true' class='autocomplete-item'>  Selected</li><li role='option' data-autocomplete-value='value' data-view-component='true' class='autocomplete-item'>  Not selected</li>" />

```erb
<%= render(Primer::Beta::Autocomplete::Item.new(selected: true, value: "value")) do |c| %>
  Selected
<% end %>
<%= render(Primer::Beta::Autocomplete::Item.new(value: "value")) do |c| %>
  Not selected
<% end %>
```
