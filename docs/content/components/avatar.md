---
title: Avatar
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/avatar_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-avatar-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Avatar` can be used to represent users and organizations on GitHub.

- Use the default round avatar for users, and the `square` argument
for organizations or any other non-human avatars.
- By default, `Avatar` will render a static `<img>`. To have `Avatar` function as a link, set the `href` which will wrap the `<img>` in a `<a>`.
- Set `size` to update the height and width of the `Avatar` in pixels.
- To stack multiple avatars together, use [AvatarStack](/components/avatarstack).

## Accessibility

Images should have text alternatives that describe the information or function represented.
If the avatar functions as a link, provide alt text that helps convey the function. For instance,
if `Avatar` is a link to a user profile, the alt attribute should be `@kittenuser profile`
rather than `@kittenuser`.
[Learn more about best image practices (WAI Images)](https://www.w3.org/WAI/tutorials/images/)

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The source url of the avatar image. |
| `alt` | `String` | N/A | Passed through to alt on img tag. |
| `size` | `Integer` | `20` | Adds the avatar-small class if less than 24. |
| `square` | `Boolean` | `false` | Used to create a square avatar. |
| `href` | `String` | `nil` | The URL to link to. If used, component will be wrapped by an `<a>` tag. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' data-view-component='' height='20' width='20' class='avatar avatar-small circle'></img>" />

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
```

### Square

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' data-view-component='' height='20' width='20' class='avatar avatar-small'></img>" />

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", square: true)) %>
```

### Link

<Example src="<a href='#' data-view-component='' class='avatar avatar-small circle lh-0'><img src='http://placekitten.com/200/200' alt='@kittenuser profile' size='20' data-view-component='' height='20' width='20'></img></a>" />

```erb
<%= render(Primer::AvatarComponent.new(href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser profile")) %>
```

### With size

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='16' data-view-component='' height='16' width='16' class='avatar avatar-small circle'></img><img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' data-view-component='' height='20' width='20' class='avatar avatar-small circle'></img><img src='http://placekitten.com/200/200' alt='@kittenuser' size='24' data-view-component='' height='24' width='24' class='avatar circle'></img><img src='http://placekitten.com/200/200' alt='@kittenuser' size='28' data-view-component='' height='28' width='28' class='avatar circle'></img><img src='http://placekitten.com/200/200' alt='@kittenuser' size='32' data-view-component='' height='32' width='32' class='avatar circle'></img><img src='http://placekitten.com/200/200' alt='@kittenuser' size='36' data-view-component='' height='36' width='36' class='avatar circle'></img>" />

```erb
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 16)) %>
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 20)) %>
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 24)) %>
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 28)) %>
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 32)) %>
<%= render(Primer::AvatarComponent.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 36)) %>
```
