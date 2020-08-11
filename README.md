<p align="center">
  <img width="300px" src="/static/assets/readme-components.png">
</p>

<h1 align="center">Primer ViewComponents</h1>

<p align="center">ViewComponents for the Primer Design System</p>

_Note: This library is in pre-release development and should not be considered stable._

## Installation

In `Gemfile`, add:

```ruby
gem "primer_view_components"
```

In `config/application.rb`, add **after the application definition**

```ruby
require "primer/view_components/engine"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/primer/view_components. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Setting up

Run

```bash
script/setup
```

to install all necessary dependencies

### Storybook

*We recommend having [overmind](https://github.com/DarthSim/overmind) installed to run both rails and storybook, but it is not required.*

To run storybook:

```bash
script/storybook
```

### Developing with another app

In your app, change the Gemfile from

```ruby
gem "primer_view_components"
```

to

```ruby
gem "primer_view_components", path: "path_to_the_gem" # e.g. path: "~/primer/view_components"
```

Then, `bundle install` to update references. You'll now be able to see changes from the gem without having to build it.
Remember that restarting the Rails server is necessary to see changes, as the gem is loaded at boot time.

To minimize the number of restarts, we recommend checking the component in Storybook first, and then when it's in a good state,
you can check it in your app.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
