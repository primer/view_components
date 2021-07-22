---
title: Linting
---

Primer ViewComponents offers a suite of linters to make writing UI more consistent. We provide custom linters for [erb-lint](https://github.com/Shopify/erb-lint) and cops for [rubocop](https://github.com/rubocop/rubocop).

## Setup

### rubocop

To use our custom cops, you have to inherit our gem configuration in `.rubocop.yml`:

```yml
inherit_gem:
  primer_view_components: lib/rubocop/config/default.yml
```

You can also modify that configuration enabling/disabling the cops you want:

```yml
Primer/SystemArgumentInsteadOfClass:
  Enabled: false
```

### erb-lint

To get access to our ERB linters, create a `.erb-linters/primer.rb` file with:

```rb
require "primer/view_components/linters"
```

Then, you can enable them in `.erb-lint.yml`. E.g.:

```yml
linters:
  ButtonComponentMigrationCounter:
    enabled: true
```

If you also want to add our cops when linting ERB, you can modify your `.erb-lint.yml` to have:

```yml
linters:
  Rubocop:
    enabled: true
    rubocop_config:
      inherit_gem:
        primer_view_components: lib/rubocop/config/default.yml
```
