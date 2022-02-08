---
title: Dialog
componentId: dialog
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/dialog.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-dialog
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Dialog` for an overlayed dialog window.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | N/A | The title of the dialog. |
| `description` | `String` | `nil` | The optional description of the dialog. |
| `dialog_id` | `String` | `nil` | The optional ID of the dialog, defaults to random string. |
| `show_header_divider` | `Boolean` | `true` | Whether to show the header divider. |
| `show_footer_divider` | `Boolean` | `true` | Whether to show the footer divider. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Buttons`

Optional list of buttons to be rendered.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | The same arguments as [Button](/components/button). |

### `Show_button`

Required button to open the dialog.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | The same arguments as [Button](/components/button). |

### `Body`

Required body content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<button type='button' data-view-component='true' class='js-dialog-show-my-custom-id btn'>  Show dialog</button><div class='Overlay-backdrop Overlay-backdrop--positionCenter'>  <modal-dialog role='dialog' id='my-custom-id' aria-modal='true' aria-labelledby='my-custom-id-header' aria-describedby='my-custom-id-description' data-view-component='true' class='Dialog Overlay'>    <header class='Overlay-header Overlay-header--divided'>      <div class='Overlay-header--contentWrap'>        <div class='Overlay-header--titleWrap'>          <h1 id='my-custom-id-header' class='Overlay-title'>Title</h1>            <h2 id='my-custom-id-description' class='Overlay-description'>Description</h2>        </div>        <button aria-label='Close' type='button' data-view-component='true' class='close-button Overlay-closeButton'><svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-x'>    <path fill-rule='evenodd' d='M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z'></path></svg></button>      </div>    </header>     <div class='Overlay-body'><div data-view-component='true' class='dialog-body'>    <em>Your custom content here</em></div></div></modal-dialog></div>" />

```erb
<%= render(Primer::Alpha::Dialog.new(
 title: "Title",
 description: "Description",
 dialog_id: "my-custom-id"
)) do |c| %>
  <% c.show_button { "Show dialog" } %>
  <% c.body do %>
    <em>Your custom content here</em>
  <% end %>
<% end %>
```

### With buttons

<Example src="<button type='button' data-view-component='true' class='js-dialog-show-my-custom-id btn'>  Show dialog</button><div class='Overlay-backdrop Overlay-backdrop--positionCenter'>  <modal-dialog role='dialog' id='my-custom-id' aria-modal='true' aria-labelledby='my-custom-id-header' aria-describedby='my-custom-id-description' data-view-component='true' class='Dialog Overlay'>    <header class='Overlay-header Overlay-header--divided'>      <div class='Overlay-header--contentWrap'>        <div class='Overlay-header--titleWrap'>          <h1 id='my-custom-id-header' class='Overlay-title'>Title</h1>            <h2 id='my-custom-id-description' class='Overlay-description'>Description</h2>        </div>        <button aria-label='Close' type='button' data-view-component='true' class='close-button Overlay-closeButton'><svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-x'>    <path fill-rule='evenodd' d='M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z'></path></svg></button>      </div>    </header>     <div class='Overlay-body'><div data-view-component='true' class='dialog-body'>    <em>Your custom content here</em></div></div>      <footer class='Dialog-footer Overlay-footer Overlay-footer--divided'>          <button type='button' data-view-component='true' class='btn'>  Button 1</button>          <button type='button' data-view-component='true' class='btn'>  Button 1</button>          <button type='button' data-view-component='true' class='btn'>  Button 2</button>      </footer></modal-dialog></div>" />

```erb
<%= render(Primer::Alpha::Dialog.new(
 title: "Title",
 description: "Description",
 dialog_id: "my-custom-id"
)) do |c| %>
  <% c.show_button { "Show dialog" } %>
  <% c.button { "Button 1" } %>
  <% c.button { "Button 1" } %>
  <% c.button { "Button 2" } %>
  <% c.body do %>
    <em>Your custom content here</em>
  <% end %>
<% end %>
```
