---
title: Primer::AvatarComponent
---

Avatars are images used to represent users and organizations on GitHub.
Use the default round avatar for users, and the `square` argument
for organizations or any other non-human avatars.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 34px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' class='avatar avatar--small CircleBadge ' height='20' width='20'></img></body></html>"></iframe>

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The source url of the avatar image |
| `alt` | `String` | N/A | Passed through to alt on img tag |
| `size` | `Integer` | `20` | Adds the avatar-small class if less than 24 |
| `square` | `Boolean` | `false` | Used to create a square avatar. |
