---
title: NavigationList
componentId: navigation_list
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/navigation_list.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-navigation-list
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`NavigationList` provides a simple way to render side navigation, i.e. navigation
that appears to the left or right side of some main content.
`NavigationList` contains a list of navigation items (links) and corresponding leading
and trailing visuals such as icons. Items can themselves have sub-items.
Finally, `NavigationList` supports sections, which are logical groups of items with
a section header.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected_item_id` | `Symbol` | `nil` | The id of the selected item. Should correspond to one of the item ids in the list. |
| `item_classes` | `Array<String>` | `""` | Additional classes to add to the list's items. |
| `list_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

Top-level nav items shown above all sections.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `component_klass` | `Class` | N/A | A custom component class to use instead of the default Item class. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Sections`

Sections.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<action-list>  <nav aria-label='Settings' data-view-component='true'>    <ul aria-label='Settings' id='an_id' data-view-component='true' class='ActionList'>        <li data-item-id='general' data-view-component='true' class='ActionList-item'>  <a href='/settings/general' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>          General Settings    </span></a></li>        <li class='ActionList-sectionDivider'></li>        <li id='nav-list-section-5f3dc95f-4b82-4331-84d7-f430119788ac' aria-hidden='true' data-view-component='true' class='ActionList-sectionDivider'>      Account Settings</li><li data-view-component='true' class='ActionList-item ActionList-item--hasSubItem'>  <ul aria-label='Account settings' aria-labelledby='nav-list-section-5f3dc95f-4b82-4331-84d7-f430119788ac' data-view-component='true' class='ActionList ActionList--subGroup'>      <li data-item-id='personal_info' data-view-component='true' class='ActionList-item--navActive ActionList-item'>  <a href='/account/info' tabindex='0' aria-current='page' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>            Personal Information    </span></a></li>      <li data-item-id='password' data-view-component='true' class='ActionList-item'>  <a href='/account/password' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>            Password    </span></a></li>      <li data-item-id='billing' data-view-component='true' class='ActionList-item'>  <a href='/account/billing' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>            Billing info    </span></a></li></ul></li></ul></nav></action-list>" />

```erb

<%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :personal_info, id: "an_id")) do |component| %>
  <% component.item(selected_by_ids: :general, href: "/settings/general") do %>
    General Settings
  <% end %>

  <% component.section(aria: { label: "Account settings" }) do |section| %>
    <% section.heading do %>
      Account Settings
    <% end %>
    <% section.item(selected_by_ids: :personal_info, href: "/account/info") do %>
      Personal Information
    <% end %>
    <% section.item(selected_by_ids: :password, href: "/account/password") do %>
      Password
    <% end %>
    <% section.item(selected_by_ids: :billing, href: "/account/billing") do %>
      Billing info
    <% end %>
  <% end %>
<% end %>
```

### Items with leading and trailing visuals

<Example src="<action-list>  <nav aria-label='Settings' data-view-component='true'>    <ul aria-label='Settings' id='an_id' data-view-component='true' class='ActionList'>        <li class='ActionList-sectionDivider'></li>        <li id='nav-list-section-c4e8237b-4b95-4949-b69c-8813c926ada3' aria-hidden='true' data-view-component='true' class='ActionList-sectionDivider'>      Account Settings</li><li data-view-component='true' class='ActionList-item ActionList-item--hasSubItem'>  <ul aria-label='Account settings' aria-labelledby='nav-list-section-c4e8237b-4b95-4949-b69c-8813c926ada3' data-view-component='true' class='ActionList ActionList--subGroup'>      <li data-item-id='personal_info' data-view-component='true' class='ActionList-item--navActive ActionList-item'>  <a href='/account/info' tabindex='0' aria-current='page' data-view-component='true' class='ActionList-content ActionList-content--visual16'>      <span class='ActionList-item-visual ActionList-item-visual--leading'>        <img src='https://github.com/github.png' alt='GitHub' size='16' height='16' width='16' data-view-component='true' class='avatar avatar-small circle' />      </span>    <span class='ActionList-item-label'>            Personal Information    </span></a></li>      <li data-item-id='password' data-view-component='true' class='ActionList-item'>  <a href='/account/password' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>      <span class='ActionList-item-visual ActionList-item-visual--leading'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-key'>    <path fill-rule='evenodd' d='M6.5 5.5a4 4 0 112.731 3.795.75.75 0 00-.768.18L7.44 10.5H6.25a.75.75 0 00-.75.75v1.19l-.06.06H4.25a.75.75 0 00-.75.75v1.19l-.06.06H1.75a.25.25 0 01-.25-.25v-1.69l5.024-5.023a.75.75 0 00.181-.768A3.995 3.995 0 016.5 5.5zm4-5.5a5.5 5.5 0 00-5.348 6.788L.22 11.72a.75.75 0 00-.22.53v2C0 15.216.784 16 1.75 16h2a.75.75 0 00.53-.22l.5-.5a.75.75 0 00.22-.53V14h.75a.75.75 0 00.53-.22l.5-.5a.75.75 0 00.22-.53V12h.75a.75.75 0 00.53-.22l.932-.932A5.5 5.5 0 1010.5 0zm.5 6a1 1 0 100-2 1 1 0 000 2z'></path></svg>      </span>    <span class='ActionList-item-label'>            Password    </span></a></li>      <li data-item-id='billing' data-view-component='true' class='ActionList-item'>  <a href='/account/billing' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>      <span class='ActionList-item-visual ActionList-item-visual--leading'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-package'>    <path fill-rule='evenodd' d='M8.878.392a1.75 1.75 0 00-1.756 0l-5.25 3.045A1.75 1.75 0 001 4.951v6.098c0 .624.332 1.2.872 1.514l5.25 3.045a1.75 1.75 0 001.756 0l5.25-3.045c.54-.313.872-.89.872-1.514V4.951c0-.624-.332-1.2-.872-1.514L8.878.392zM7.875 1.69a.25.25 0 01.25 0l4.63 2.685L8 7.133 3.245 4.375l4.63-2.685zM2.5 5.677v5.372c0 .09.047.171.125.216l4.625 2.683V8.432L2.5 5.677zm6.25 8.271l4.625-2.683a.25.25 0 00.125-.216V5.677L8.75 8.432v5.516z'></path></svg>      </span>    <span class='ActionList-item-label'>            Billing info    </span></a></li></ul></li></ul></nav></action-list>" />

```erb

<%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :personal_info, id: "an_id")) do |component| %>
  <% component.section(aria: { label: "Account settings" }) do |section| %>
    <% section.heading do %>
      Account Settings
    <% end %>
    <% section.item(selected_by_ids: :personal_info, href: "/account/info") do |item| %>
      Personal Information
      <% item.leading_visual_avatar(src: "https://github.com/github.png", alt: "GitHub") %>
    <% end %>
    <% section.item(selected_by_ids: :password, href: "/account/password") do |item| %>
      Password
      <% item.leading_visual_icon(icon: :key) %>
    <% end %>
    <% section.item(selected_by_ids: :billing, href: "/account/billing") do |item| %>
      Billing info
      <% item.leading_visual_icon(icon: :package) %>
    <% end %>
  <% end %>
<% end %>
```

### Items with sub-items

<Example src="<action-list>  <nav aria-label='Settings' data-view-component='true'>    <ul aria-label='Settings' id='an_id' data-view-component='true' class='ActionList'>        <li class='ActionList-sectionDivider'></li>        <li id='nav-list-section-e1162a3c-56ed-4f70-af02-e769f618e4b5' aria-hidden='true' data-view-component='true' class='ActionList-sectionDivider'>      Account Settings</li><li data-view-component='true' class='ActionList-item ActionList-item--hasSubItem'>  <ul aria-label='Account settings' aria-labelledby='nav-list-section-e1162a3c-56ed-4f70-af02-e769f618e4b5' data-view-component='true' class='ActionList ActionList--subGroup'>      <li label='Notifications settings' data-item-id='notifications' aria-expanded='true' aria-haspopup='true' tabindex='0' data-view-component='true' class='ActionList-item--hasSubItem ActionList-item'>  <span data-view-component='true' class='ActionList-content ActionList-content--visual16'>      <span class='ActionList-item-visual ActionList-item-visual--leading'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-bell'>    <path d='M8 16a2 2 0 001.985-1.75c.017-.137-.097-.25-.235-.25h-3.5c-.138 0-.252.113-.235.25A2 2 0 008 16z'></path><path fill-rule='evenodd' d='M8 1.5A3.5 3.5 0 004.5 5v2.947c0 .346-.102.683-.294.97l-1.703 2.556a.018.018 0 00-.003.01l.001.006c0 .002.002.004.004.006a.017.017 0 00.006.004l.007.001h10.964l.007-.001a.016.016 0 00.006-.004.016.016 0 00.004-.006l.001-.007a.017.017 0 00-.003-.01l-1.703-2.554a1.75 1.75 0 01-.294-.97V5A3.5 3.5 0 008 1.5zM3 5a5 5 0 0110 0v2.947c0 .05.015.098.042.139l1.703 2.555A1.518 1.518 0 0113.482 13H2.518a1.518 1.518 0 01-1.263-2.36l1.703-2.554A.25.25 0 003 7.947V5z'></path></svg>      </span>    <span class='ActionList-item-label'>            Notifications    </span>      <span class='ActionList-item-action ActionList-item-action--trailing'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-down ActionList-item-collapseIcon'>    <path fill-rule='evenodd' d='M12.78 6.22a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06 0L3.22 7.28a.75.75 0 011.06-1.06L8 9.94l3.72-3.72a.75.75 0 011.06 0z'></path></svg>      </span></span>    <ul data-view-component='true' class='ActionList ActionList--subGroup'>        <li data-item-id='email_notifications' data-view-component='true' class='ActionList-item--navActive ActionList-item ActionList-item--subItem'>  <a href='/account/notifications/email' tabindex='0' aria-current='page' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>              Email    </span>      <span class='ActionList-item-visual ActionList-item-visual--trailing'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-mail'>    <path fill-rule='evenodd' d='M1.75 2A1.75 1.75 0 000 3.75v.736a.75.75 0 000 .027v7.737C0 13.216.784 14 1.75 14h12.5A1.75 1.75 0 0016 12.25v-8.5A1.75 1.75 0 0014.25 2H1.75zM14.5 4.07v-.32a.25.25 0 00-.25-.25H1.75a.25.25 0 00-.25.25v.32L8 7.88l6.5-3.81zm-13 1.74v6.441c0 .138.112.25.25.25h12.5a.25.25 0 00.25-.25V5.809L8.38 9.397a.75.75 0 01-.76 0L1.5 5.809z'></path></svg>      </span></a></li>        <li data-item-id='sms_notifications' data-view-component='true' class='ActionList-item ActionList-item--subItem'>  <a href='/account/notifications/sms' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>              SMS    </span>      <span class='ActionList-item-visual ActionList-item-visual--trailing'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-device-mobile'>    <path fill-rule='evenodd' d='M3.75 0A1.75 1.75 0 002 1.75v12.5c0 .966.784 1.75 1.75 1.75h8.5A1.75 1.75 0 0014 14.25V1.75A1.75 1.75 0 0012.25 0h-8.5zM3.5 1.75a.25.25 0 01.25-.25h8.5a.25.25 0 01.25.25v12.5a.25.25 0 01-.25.25h-8.5a.25.25 0 01-.25-.25V1.75zM8 13a1 1 0 100-2 1 1 0 000 2z'></path></svg>      </span></a></li></ul></li>      <li label='Notifications settings' data-item-id='messages' aria-expanded='false' aria-haspopup='true' tabindex='0' data-view-component='true' class='ActionList-item--hasSubItem ActionList-item'>  <span data-view-component='true' class='ActionList-content ActionList-content--visual16'>      <span class='ActionList-item-visual ActionList-item-visual--leading'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-bookmark'>    <path fill-rule='evenodd' d='M4.75 2.5a.25.25 0 00-.25.25v9.91l3.023-2.489a.75.75 0 01.954 0l3.023 2.49V2.75a.25.25 0 00-.25-.25h-6.5zM3 2.75C3 1.784 3.784 1 4.75 1h6.5c.966 0 1.75.784 1.75 1.75v11.5a.75.75 0 01-1.227.579L8 11.722l-3.773 3.107A.75.75 0 013 14.25V2.75z'></path></svg>      </span>    <span class='ActionList-item-label'>            Messages    </span>      <span class='ActionList-item-action ActionList-item-action--trailing'>        <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-chevron-down ActionList-item-collapseIcon'>    <path fill-rule='evenodd' d='M12.78 6.22a.75.75 0 010 1.06l-4.25 4.25a.75.75 0 01-1.06 0L3.22 7.28a.75.75 0 011.06-1.06L8 9.94l3.72-3.72a.75.75 0 011.06 0z'></path></svg>      </span></span>    <ul data-view-component='true' class='ActionList ActionList--subGroup'>        <li data-item-id='' data-view-component='true' class='ActionList-item ActionList-item--subItem'>  <a href='/account/messages/inbox' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>              Inbox    </span>      <span class='ActionList-item-visual ActionList-item-visual--trailing'>        <span title='10' data-view-component='true' class='Counter'>10</span>      </span></a></li>        <li data-item-id='' data-view-component='true' class='ActionList-item ActionList-item--subItem'>  <a href='/account/messages/organizer' tabindex='0' data-view-component='true' class='ActionList-content ActionList-content--visual16'>    <span class='ActionList-item-label'>              Organizer    </span>      <span class='ActionList-item-visual ActionList-item-visual--trailing'>        <span data-view-component='true' class='Label Label--primary'>New</span>      </span></a></li></ul></li></ul></li></ul></nav></action-list>" />

```erb

<%= render(Primer::Alpha::NavigationList.new(aria: { label: "Settings" }, selected_item_id: :email_notifications, id: "an_id")) do |component| %>
  <% component.section(aria: { label: "Account settings" }) do |section| %>
    <% section.heading do %>
      Account Settings
    <% end %>
    <% section.item(selected_by_ids: :notifications, label: "Notifications settings") do |item| %>
      Notifications
      <% item.leading_visual_icon(icon: :bell) %>
      <% item.subitem(selected_by_ids: :email_notifications, href: "/account/notifications/email") do |subitem| %>
        Email
        <% subitem.trailing_visual_icon(icon: :mail) %>
      <% end %>
      <% item.subitem(selected_by_ids: :sms_notifications, href: "/account/notifications/sms") do |subitem| %>
        SMS
        <% subitem.trailing_visual_icon(icon: :"device-mobile") %>
      <% end %>
    <% end %>
    <% section.item(selected_by_ids: :messages, label: "Notifications settings") do |item| %>
      Messages
      <% item.leading_visual_icon(icon: :bookmark) %>
      <% item.subitem(href: "/account/messages/inbox") do |subitem| %>
        Inbox
        <% subitem.trailing_visual_counter(count: 10) %>
      <% end %>
      <% item.subitem(href: "/account/messages/organizer") do |subitem| %>
        Organizer
        <% subitem.trailing_visual_label(scheme: :primary) { "New" } %>
      <% end %>
    <% end %>
  <% end %>
<% end %>
```
