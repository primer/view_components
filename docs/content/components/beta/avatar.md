---
title: Avatar
componentId: avatar
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/avatar.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-avatar
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Avatar` can be used to represent users and organizations on GitHub.

- Use the default circle avatar for users, and the square shape
for organizations or any other non-human avatars.
- By default, `Avatar` will render a static `<img>`. To have `Avatar` function as a link, set the `href` which will wrap the `<img>` in a `<a>`.
- Set `size` to update the height and width of the `Avatar` in pixels.
- To stack multiple avatars together, use [AvatarStack](/components/beta/avatarstack).

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
| `size` | `Integer` | `20` | One of `16`, `20`, `24`, `32`, `40`, `48`, or `80`. |
| `shape` | `Symbol` | `:circle` | Shape of the avatar. One of `:circle` and `:square`. |
| `href` | `String` | `nil` | The URL to link to. If used, component will be wrapped by an `<a>` tag. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' data-view-component='true' class='avatar avatar-small circle' />" />

```erb
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser")) %>
```

### Square

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' data-view-component='true' class='avatar avatar-small' />" />

```erb
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", shape: :square)) %>
```

### Link

<Example src="<a href='#' data-view-component='true' class='avatar avatar-small circle lh-0'><img src='http://placekitten.com/200/200' alt='@kittenuser profile' size='20' height='20' width='20' data-view-component='true' /></a>" />

```erb
<%= render(Primer::Beta::Avatar.new(href: "#", src: "http://placekitten.com/200/200", alt: "@kittenuser profile")) %>
```

### With size

<Example src="<img src='http://placekitten.com/200/200' alt='@kittenuser' size='16' height='16' width='16' data-view-component='true' class='avatar avatar-small circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' data-view-component='true' class='avatar avatar-small circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='24' height='24' width='24' data-view-component='true' class='avatar circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='32' height='32' width='32' data-view-component='true' class='avatar circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='40' height='40' width='40' data-view-component='true' class='avatar circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='48' height='48' width='48' data-view-component='true' class='avatar circle' /><img src='http://placekitten.com/200/200' alt='@kittenuser' size='80' height='80' width='80' data-view-component='true' class='avatar circle' />" />

```erb
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 16)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 20)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 24)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 32)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 40)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 48)) %>
<%= render(Primer::Beta::Avatar.new(src: "http://placekitten.com/200/200", alt: "@kittenuser", size: 80)) %>
```
