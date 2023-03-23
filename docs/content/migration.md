---
title: Migration and Upgrade Guides
---

## Migrate from Primer CSS

Many Primer CSS use cases are supported by Primer ViewComponents.

When migrating from Primer CSS classes to ViewComponents, use this mapping to
help guide your implementation. This list includes components currently in
stable status.

| Primer CSS Class | ViewComponent |
|------------------|---------------|
| [`State`](https://primer.style/css/components/labels#states)             | [`Primer::Beta::State`](https://primer.style/view-components/components/state)              |
| [`breadcrumb-item`](https://primer.style/css/components/breadcrumb)      | [`Primer::Beta::Breadcrumbs`](https://primer.style/view-components/components/beta/breadcrumbs)    |
| [`Counter`](https://primer.style/css/stickersheet/labels#counters)       | [`Primer::Beta::Counter`](https://primer.style/view-components/components/counter)          |
| [`Subhead`](https://primer.style/css/components/subhead)                 | [`Primer::Beta::Subhead`](https://primer.style/view-components/components/subhead)          |
| [`blankslate`](https://primer.style/css/components/blankslate)           | [`Primer::Beta::Blankslate`](https://primer.style/view-components/components/beta/blankslate)    |

## Upgrading Deprecated Components

As Primer ViewComponents are updated, there are often breaking changes and
deprecations that require changes which cannot be auto-corrected with Rubocop or
other tools. These guides will walk you through the upgrade process for specific
components.

| Deprecated Component | Replacement Component | Guide |
|----------------------|-----------------------|-------|
| [`Primer::ButtonComponent`](https://primer.style/view-components/components/button) | [`Primer::Beta::Button`](https://primer.style/view-components/components/beta/button) | [Upgrade to Primer::Beta::Button](https://primer.style/view-components/guides/primer_button_component) |
| [`Primer::LocalTime`](https://primer.style/view-components/components/localtime) | [`Primer::Beta::RelativeTime`](https://primer.style/view-components/components/beta/relativetime) | [Upgrade to Primer::Beta::RelativeTime](https://primer.style/view-components/guides/primer_local_time) |
| [`Primer::TimeAgoComponent`](https://primer.style/view-components/components/timeago) | [`Primer::Beta::RelativeTime`](https://primer.style/view-components/components/beta/relativetime) | [Upgrade to Primer::Beta::RelativeTime](https://primer.style/view-components/guides/primer_time_ago) |
| [`Primer::Truncate`](https://primer.style/view-components/components/truncate) | [`Primer::Beta::Truncate`](https://primer.style/view-components/components/beta/truncate) | [Upgrade to Primer::Beta::Truncate](https://primer.style/view-components/guides/primer_truncate) |
