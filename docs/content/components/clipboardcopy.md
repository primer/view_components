---
title: ClipboardCopy
componentId: clipboard_copy
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/clipboard_copy.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-clipboard-copy
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `ClipboardCopy` to copy element text content or input values to the clipboard.

## Accessibility

Always set an accessible label to help the user interact with the component.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `aria-label` | `String` | N/A | String that will be read to screenreaders when the component is focused |
| `value` | `String` | `nil` | Text to copy into the users clipboard when they click the component. |
| `for` | `String` | N/A | Element id from where to get the copied value. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<clipboard-copy aria-label='Copy text to the system clipboard' value='Text to copy' data-view-component='true'>    <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-copy'>    <path fill-rule='evenodd' d='M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z'></path><path fill-rule='evenodd' d='M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.75-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z'></path></svg>    <svg style='display: none;' aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-check color-icon-success'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg></clipboard-copy>" />

```erb
<%= render(Primer::ClipboardCopy.new(value: "Text to copy", "aria-label": "Copy text to the system clipboard")) %>
```

### With text instead of icons

<Example src="<clipboard-copy aria-label='Copy text to the system clipboard' value='Text to copy' data-view-component='true'>      Click to copy!</clipboard-copy>" />

```erb
<%= render(Primer::ClipboardCopy.new(value: "Text to copy", "aria-label": "Copy text to the system clipboard")) do %>
  Click to copy!
<% end %>
```

### Copying from an element

<Example src="<clipboard-copy for='blob-path' aria-label='Copy text to the system clipboard' data-view-component='true'>    <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-copy'>    <path fill-rule='evenodd' d='M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z'></path><path fill-rule='evenodd' d='M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.75-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z'></path></svg>    <svg style='display: none;' aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-check color-icon-success'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg></clipboard-copy><div id='blob-path'>src/index.js</div>" />

```erb
<%= render(Primer::ClipboardCopy.new(for: "blob-path", "aria-label": "Copy text to the system clipboard")) %>
<div id="blob-path">src/index.js</div>
```
