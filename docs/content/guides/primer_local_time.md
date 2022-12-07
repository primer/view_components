---
title: Moving Away From `Primer::LocalTime`
---

This guide will show you how to upgrade from the now deprecated
[`Primer::LocalTime`](https://primer.style/view-components/components/localtime)
to the latest [`Primer::Beta::RelativeTime`](https://primer.style/view-components/components/beta/relativetime)
component.

## Arguments

The following arguments are different between `LocalTime` and `RelativeTime`.

| From `Primer::LocalTime` | To `Primer::Beta::RelativeTime` | Notes |
|--------------------------|---------------------------------|-------|
| `initial_text` | n/a         | No longer used.                                                                                                     |
| n/a            | `tense`     | Which tense to use. One of `:auto`, `:future`, or `:past`.                                                          |
| n/a            | `prefix`    | What to prefix the relative ime display with.                                                                       |
| n/a            | `threshold` | The threshold at which relative time displays become absolute.                                                      |
| n/a            | `precision` | The precision elapsed time should display. One of nil, `:day`, `:hour`, `:minute`, `:month`, `:second`, or `:year`. |
| n/a            | `format`    | The format the display should take. One of `:auto`, `:elapsed`, or `:micro`.                                        |
| n/a            | `lang`      | The language to use.                                                                                                |
| n/a            | `title`     | Provide a custom title to the element.                                                                              |

The remaining arguments stayed the same.

Please see the following documentation for complete descriptions and examples.

* [Deprecated `Primer::LocalTime`](https://primer.style/view-components/components/localtime)
* [`Primer::Beta::RelativeTime` component](https://primer.style/view-components/components/beta/relativetime)
* [`Primer::Beta::RelativeTime` Lookbook examples](https://primer.style/view-components/lookbook/inspect/primer/beta/relativetime/default)

[&larr; Back to migration guides](https://primer.style/view-components/migration)
