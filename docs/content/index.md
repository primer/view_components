---
title: Primer ViewComponents
---

import {HeroLayout} from '@primer/gatsby-theme-doctocat'
export default HeroLayout

Primer ViewComponents is an implementation of the Primer Design System, using [ViewComponent](https://github.com/github/view_component).
<Note variant="warning">This library is under active pre-1.0 development. Breaking changes are likely in patch releases.</Note>

## Usage

Render Primer ViewComponents from templates:

```erb
<%= render(Primer::Beta::Counter.new(count: 25)) %>
```

## Installation

In `Gemfile`, add:

```ruby
gem "primer_view_components"
```

In `config/application.rb`, add **after the application definition**:

```ruby
require "view_component"
require "primer/view_components/engine"
```

Optionally, to add the JavaScript behaviours, in your `application.html.erb` in the `<head>` tag add:

```erb
<%= javascript_include_tag("primer_view_components") %>
```

Or alternatively, you can install the `@primer/view-components` npm package and in your JavaScript code add:

```js
import '@primer/view-components/app/assets/javascripts/primer_view_components.js'
```

You can also import only the components you need:

```js
import '@primer/view-components/tab_container'
```

## Dependencies

In addition to the dependencies declared in the `gemspec`, Primer ViewComponents assumes the presence of [Primer CSS](https://primer.style/css/getting-started).
