---
title: TimelineItem
componentId: timeline_item
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/timeline_item_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-timeline-item-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `condensed` | `Boolean` | `false` | Reduce the vertical padding and remove the background from the badge item. Most commonly used in commits. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Avatar`

Avatar to be rendered to the left of the Badge.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Avatar](/components/beta/avatar). |

### `Badge`

Badge that will be connected to other TimelineItems.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `icon` | `String` | N/A | Name of [Octicon](https://primer.style/octicons/) to use. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Body`

Body to be rendered to the left of the Badge.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div style='padding-left: 60px'>  <div data-view-component='true' class='TimelineItem'>  <img src='https://github.com/github.png' alt='github' size='40' height='40' width='40' data-view-component='true' class='TimelineItem-avatar avatar' />  <div data-view-component='true' class='TimelineItem-badge color-bg-success-emphasis color-fg-on-emphasis'><svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg></div>  <div data-view-component='true' class='TimelineItem-body'>Success!</div></div></div>" />

```erb
<div style="padding-left: 60px">
  <%= render(Primer::TimelineItemComponent.new) do |component| %>
    <% component.avatar(src: "https://github.com/github.png", alt: "github") %>
    <% component.badge(bg: :success_emphasis, color: :on_emphasis, icon: :check) %>
    <% component.body { "Success!" } %>
  <% end %>
</div>
```
