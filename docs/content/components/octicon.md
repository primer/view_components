---
title: Octicon
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/octicon_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-octicon-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Octicon` renders an [Octicon](https://primer.style/octicons/) with [System arguments](/system-arguments).
`Octicon` can also be rendered with the `primer_octicon` helper, which accepts the same arguments.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `icon` | `Symbol` | `nil` | Name of [Octicon](https://primer.style/octicons/) to use. |
| `size` | `Symbol` | `:small` | One of `:small` (`16`) and `:medium` (`24`). |
| `use_symbol` | `Boolean` | `false` | EXPERIMENTAL (May change or be removed) - Set to true when using with [OcticonSymbols](/components/octiconsymbols). |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg><svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>" />

```erb
<%= render(Primer::OcticonComponent.new(:check)) %>
<%= render(Primer::OcticonComponent.new(icon: :check)) %>
```

### Medium

<Example src="<svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' data-view-component='true' height='24' width='24' class='octicon octicon-people'>    <path fill-rule='evenodd' d='M3.5 8a5.5 5.5 0 118.596 4.547 9.005 9.005 0 015.9 8.18.75.75 0 01-1.5.045 7.5 7.5 0 00-14.993 0 .75.75 0 01-1.499-.044 9.005 9.005 0 015.9-8.181A5.494 5.494 0 013.5 8zM9 4a4 4 0 100 8 4 4 0 000-8z'></path><path d='M17.29 8c-.148 0-.292.01-.434.03a.75.75 0 11-.212-1.484 4.53 4.53 0 013.38 8.097 6.69 6.69 0 013.956 6.107.75.75 0 01-1.5 0 5.193 5.193 0 00-3.696-4.972l-.534-.16v-1.676l.41-.209A3.03 3.03 0 0017.29 8z'></path></svg>" />

```erb
<%= render(Primer::OcticonComponent.new(:people, size: :medium)) %>
```

### Helper

<Example src="<svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>" />

```erb
<%= primer_octicon(:check) %>
```
