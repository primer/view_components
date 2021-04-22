---
title: ClipboardCopy
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/clipboard_copy.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-clipboard-copy-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use ClipboardCopy to copy element text content or input values to the clipboard.

## Examples

### Default

<Example src="<clipboard-copy value='Text to copy' aria-label='Copy text to the system clipboard'>    <svg class='octicon octicon-clippy' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M5.75 1a.75.75 0 00-.75.75v3c0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75v-3a.75.75 0 00-.75-.75h-4.5zm.75 3V2.5h3V4h-3zm-2.874-.467a.75.75 0 00-.752-1.298A1.75 1.75 0 002 3.75v9.5c0 .966.784 1.75 1.75 1.75h8.5A1.75 1.75 0 0014 13.25v-9.5a1.75 1.75 0 00-.874-1.515.75.75 0 10-.752 1.298.25.25 0 01.126.217v9.5a.25.25 0 01-.25.25h-8.5a.25.25 0 01-.25-.25v-9.5a.25.25 0 01.126-.217z'></path></svg>    <svg style='display: none;' class='octicon octicon-check color-icon-success' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg></clipboard-copy>" />

```erb
<%= render(Primer::ClipboardCopy.new(value: "Text to copy", label: "Copy text to the system clipboard")) %>
```

### With text instead of icons

<Example src="<clipboard-copy value='Text to copy' aria-label='Copy text to the system clipboard'>      Click to copy!</clipboard-copy>" />

```erb
<%= render(Primer::ClipboardCopy.new(value: "Text to copy", label: "Copy text to the system clipboard")) do %>
  Click to copy!
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | String that will be read to screenreaders when the component is focused |
| `value` | `String` | N/A | Text to copy into the users clipboard when they click the component |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
