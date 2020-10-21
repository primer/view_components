---
title: Primer ViewComponents
---

import {HeroLayout} from '@primer/gatsby-theme-doctocat'
export default HeroLayout

## Design philosophy

Primer ViewComponents aims to mimic the API of [Primer Components](https://github.com/primer/components), while using [Primer CSS](https://github.com/primer/css) under the hood.

## Installation

In `Gemfile`, add:

```ruby
gem "primer_view_components"
```

In `config/application.rb`, add **after the application definition**:

```ruby
require "primer/view_components/engine"
```