# Setup

## Setup for local development

1. Clone `git@github.com:opf/primer_view_components.git`
1. Run `script/setup` to install dependencies

## Use local packages

In your `Gemfile`, change:

```ruby
gem "oppenproject-primer_view_components"
```

to

```ruby
gem "openproject-primer_view_components", path: "path_to_the_gem" # e.g. path: "~/openproject/primer_view_components"
```

Then, `bundle install` in the core to update references. You'll now be able to see changes from the gem without having to build it.
**Remember that restarting the Rails server is necessary to see changes, as the gem is loaded at boot time.**

In your `package.json`, change:

```json
"dependencies": {
  "@openproject/primer-view-components": "^0.X.Y"
}

"overrides": {
  "@primer/view-components": "npm:@openproject/primer-view-components^0.X.Y"
}
```

to

```json
"dependencies": {
  "@openproject/primer-view-components": "file:path_to_file"
}

"overrides": {
  "@primer/view-components": "file:path_to_file"
}

```
