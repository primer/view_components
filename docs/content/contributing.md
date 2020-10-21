---
title: Contributing
---

Bug reports and pull requests are welcome on GitHub at [https://github.com/primer/view_components](https://github.com/primer/view_components). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Setting up

Run

```bash
script/setup
```

To install all necessary dependencies.

## Running tests

To run the full test suite:

```bash
bundle exec rake
```

## Writing documentation

Documentation is written as [YARD](https://yardoc.org/) comments directly in the source code, compiled into Markdown via `rake docs:build` and served by [Doctocat](https://github.com/primer/doctocat).

## Storybook / Documentation

To run Storybook and the documentation site, run:

```bash
script/dev
```

_Note: Overmind is required to run script/dev._

## Developing with another app

In your `Gemfile`, change:

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

## Deploying to Heroku

We have both `staging` and `production` environments. To deploy Storybook to Heroku, run the following in `#primer-view-components-ops`:

```bash
.deploy primer-view-components</branch> to <environment>
```

If no `branch` is passed, `main` will be deployed.