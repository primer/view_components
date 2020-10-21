---
title: Primer ViewComponents
---

import {HeroLayout} from '@primer/gatsby-theme-doctocat'
export default HeroLayout

Primer ViewComponents is an implementation of the Primer Design System, using [ViewComponent](https://github.com/github/view_component).

## Usage

Render Primer ViewComponents from templates:

```erb
<%= render(Primer::CounterComponent.new(count: 25)) %>
```

## Installation

In `Gemfile`, add:

```ruby
gem "primer_view_components"
```

In `config/application.rb`, add **after the application definition**:

```ruby
require "primer/view_components/engine"
```
