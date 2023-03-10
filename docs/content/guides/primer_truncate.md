---
title: Moving Away From `Primer::Truncate`
---

This guide will show you how to upgrade from the now-deprecated
[`Primer::Truncate`](https://primer.style/view-components/components/truncate)
to the latest
[`Primer::Beta::Truncate`](https://primer.style/view-components/components/beta/truncate)
component.

The new `Truncate` component additionally now includes a text slot used for the
truncated text.

## Some Migration Examples

Migrating the most common use cases of the `Truncate` component simply requires
changing the name.

Previously we might have something like:

```ruby
<%= render(Primer::Truncate.new(tag: :p)) { "Some really, really verbose content" } %>
```

That's now:

```ruby
<%= render(Primer::Beta::Truncate.new(tag: :p)) { "Some really, really verbose content" } %>
```

The `tag` argument now defaults to `:span` instead of `:div`, so if we want to
continue wrapping content in `<div>` tags we'll need to explicitly set that. So,
if we'd been using:

```ruby
<%= render(Primer::Truncate.new) { "Some more very very long text" } %>
```

We can now equivalently write:

```ruby
<%= render(Primer::Beta::Truncate.new(tag: :div)) { "Some more very very long text" } %>
```

## Arguments

The following arguments for the component initializer have changed between the deprecated and newer versions
of the `Truncate` component.

| From `Primer::Truncate` | To `Primer::Beta::Truncate` | Notes                                                                    |
|-------------------------|-----------------------------|--------------------------------------------------------------------------|
| `tag`                   | `tag`                       | Previously defaulted to `:div`, now `:span`.                             |
| `inline`                | n/a                         | Removed in `Primer::Beta::Truncate`.                                     |
| n/a                     | `priority`                  | If `true`, the text will be given priority (by increasing `flex-basis`). |

The remaining arguments for `Truncate` can be found in the documentation for
that component.

Please see the following for complete descriptions and examples.

* [Deprecated `Primer::Truncate`](https://primer.style/view-components/components/truncate)
* [`Primer::Beta::Truncate` component](https://primer.style/view-components/components/beta/truncate)
* [`Primer::Beta::Truncate` Lookbook examples](https://primer.style/view-components/lookbook/inspect/primer/beta/truncate/default)

<p>&nbsp;</p>

[&larr; Back to migration guides](https://primer.style/view-components/migration)
