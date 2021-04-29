---
title: AvatarStack
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/avatar_stack_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-avatar-stack-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `AvatarStack` to stack multiple avatars together.

## Examples

### Default

<Example src="<div class='AvatarStack AvatarStack--three-plus'>  <div class='AvatarStack-body'>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>        <div class='avatar avatar-more'></div>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img></div></div>" />

```erb
<%= render(Primer::AvatarStackComponent.new) do |c| %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
<% end  %>
```

### Align right

<Example src="<div class='AvatarStack AvatarStack--right AvatarStack--three-plus'>  <div class='AvatarStack-body'>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>        <div class='avatar avatar-more'></div>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img></div></div>" />

```erb
<%= render(Primer::AvatarStackComponent.new(align: :right)) do |c| %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
<% end  %>
```

### With tooltip

<Example src="<div class='AvatarStack AvatarStack--three-plus'>  <div aria-label='This is a tooltip!' class='AvatarStack-body tooltipped tooltipped-n'>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img>        <div class='avatar avatar-more'></div>      <img src='http://placekitten.com/200/200' alt='@kittenuser' size='20' height='20' width='20' class='avatar avatar-small circle'></img></div></div>" />

```erb
<%= render(Primer::AvatarStackComponent.new(tooltipped: true, body_arguments: { label: 'This is a tooltip!' })) do |c| %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
  <%= c.avatar(src: "http://placekitten.com/200/200", alt: "@kittenuser") %>
<% end  %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:div` | One of `:div` and `:span`. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. |
| `tooltipped` | `Boolean` | `false` | Whether to add a tooltip to the stack or not. |
| `body_arguments` | `Hash` | `{}` | Parameters to add to the Body. If `tooltipped` is set, has the same arguments as [Tooltip](/components/tooltip). |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Avatars`

Required list of stacked avatars.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Avatar](/components/avatar). |
