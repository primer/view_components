# Setup

## Setup for local development

1. Clone `git@github.com:opf/primer_view_components.git`
1. Run `script/setup` to install dependencies
1. Run `script/dev`, this will run the documentation site on [localhost:5400](localhost:5400) and Lookbook on [localhost:4000](localhost:5000)

### Lookbook

[Lookbook](https://github.com/ViewComponent/lookbook) is a native ViewComponent alternative to Storybook, that works off of ViewComponent previews and yarddoc.

#### How to run

Starting from view_components root directory

1. `script/setup` - Setups up the whole project, but also bundle installs dependencies for the demo app.
2. Change directory to `/demo/` and run `bin/dev` - Runs the rails server for lookbook.
3. Visit [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

## Developing within OpenProject

**IMPORTANT!**

At the moment, you have to restart the rails server, as well as the npm server (including a fresh install) after every change to see changes, as the gem and the npm package are loaded at boot time.
To minimize the number of restarts, we recommend checking the component in Lookbook first, and then when it's in a good state, you can check it in OpenProject.

In your `Gemfile`, change:

```ruby
gem "oppenproject-primer_view_components"
```

to

```ruby
gem "openproject-primer_view_components", path: "path_to_the_gem" # e.g. path: "~/openproject/primer_view_components"
```

Then, `bundle install` in the core to update references. You'll now be able to see changes from the gem without having to build it.

In your `frontend/package.json`, change:

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
  "@openproject/primer-view-components": "file:path_to_file"  // e.g. path: "file:~/path/to/local/primer_view_component"
}

"overrides": {
  "@primer/view-components": "file:path_to_file"
}

```

Then, `npm install` in the `frontend` folder and the reference should be updated. If that does not work out, try to remove the `node_modules` folder as well as the `package-lock.json`.
