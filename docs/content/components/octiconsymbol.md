---
title: OcticonSymbol
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/octicon_symbol_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-octicon-symbol-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

OcticonSymbol renders a symbol dictionary using a list of [Octicon](https://primer.style/octicons/).

## Examples

### Symbol dictionary

<Example src="<svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-check color-icon-success'>    <use href='#octicon_check_16'></use></svg><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-check color-text-danger'>    <use href='#octicon_check_16'></use></svg><svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' height='32' width='32' class='octicon octicon-check'>    <use href='#octicon_check_24'></use></svg><svg xmlns='http://www.w3.org/2000/svg' hidden>  <defs>      <symbol id='octicon-check-16' viewBox='0 0 16 16' width='16' height='16'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></symbol>      <symbol id='octicon-check-24' viewBox='0 0 24 24' width='24' height='24'><path fill-rule='evenodd' d='M21.03 5.72a.75.75 0 010 1.06l-11.5 11.5a.75.75 0 01-1.072-.012l-5.5-5.75a.75.75 0 111.084-1.036l4.97 5.195L19.97 5.72a.75.75 0 011.06 0z'></path></symbol>  </defs></svg>" />

```erb
<%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, color: :icon_success)) %>
<%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, color: :text_danger)) %>
<%= render(Primer::OcticonComponent.new(icon: :check, use_symbol: true, size: :medium)) %>
<%= render(Primer::OcticonSymbolsComponent.new) do |c| %>
  <%= c.icon(symbol: :check) %>
  <%= c.icon(symbol: :check, size: :medium) %>
<% end %>
```

## Slots

### `Icons`

Required list of icons. These will be the icons that are rendered.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `symbol` | `String` | N/A | Name of [Octicon](https://primer.style/octicons/) to use. |
| `size` | `Symbol` | N/A | One of `:small` (`16`), `:medium` (`32`), or `:large` (`64`). |
