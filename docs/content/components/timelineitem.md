---
title: TimelineItem
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/timeline_item_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `TimelineItem` to display items on a vertical timeline, connected by badge elements.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='padding-left: 60px'>  <div class='TimelineItem '>    <img src='https://github.com/github.png' alt='github' size='40' height='40' width='40' class='avatar TimelineItem-avatar '></img>    <div class='TimelineItem-badge bg-green text-white'>      <svg class='octicon octicon-check' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg></div>    <div class='TimelineItem-body '>      Success!</div></div></div></body></html>"></iframe>

```erb
<div style="padding-left: 60px">
  <%= render(Primer::TimelineItemComponent.new) do |component| %>
    <% component.slot(:avatar, src: "https://github.com/github.png", alt: "github") %>
    <% component.slot(:badge, bg: :green, color: :white, icon: :check) %>
    <% component.slot(:body) { "Success!" } %>
  <% end %>
</div>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `condensed` | `Boolean` | `false` | Reduce the vertical padding and remove the background from the badge item. Most commonly used in commits. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `avatar` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `alt` | `String` | `nil` | Alt text for avatar image. |
| `src` | `String` | `nil` | Src attribute for avatar image. |
| `size` | `Integer` | `40` | Image size. |
| `square` | `Boolean` | `true` | Whether to round the edges of the image. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `badge` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `icon` | `String` | `nil` | Name of [Octicon](https://primer.style/octicons/) to use. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `body` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
