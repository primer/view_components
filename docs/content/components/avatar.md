---
title: Avatar
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/avatar_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-avatar-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Avatars are images used to represent users and organizations on GitHub.
Use the default round avatar for users, and the `square` argument
for organizations or any other non-human avatars.

## Examples

### Default

<IFrame height="auto" content="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar--small circle '></img>"></IFrame>

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
```

### Square

<IFrame height="auto" content="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar--small '></img>"></IFrame>

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", square: true)) %>
```

### Link

<IFrame height="auto" content="<a href='#' class='avatar '><img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar--small circle '></img></a>"></IFrame>

```erb
<%= render(Primer::AvatarComponent.new(href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The source url of the avatar image. |
| `alt` | `String` | N/A | Passed through to alt on img tag. |
| `size` | `Integer` | `20` | Adds the avatar-small class if less than 24. |
| `square` | `Boolean` | `false` | Used to create a square avatar. |
| `href` | `String` | `nil` | The URL to link to. If used, component will be wrapped by an `<a>` tag. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
