# Setup

The easiest way to get started contributing to Primer ViewComponents is with [Codespaces](https://github.com/features/codespaces), Codespace environments come fully set up for development.

## Setup for local development

1. Clone `git@github.com:primer/view_components.git`
2. Install [Overmind](https://github.com/DarthSim/overmind)
3. Run `script/setup` to install dependencies
4. Run `script/dev`, this will run the Lookbook on [localhost:4000](localhost:4000)

### Lookbook

[Lookbook](https://github.com/ViewComponent/lookbook) is a native ViewComponent alternative to Storybook, that works off of ViewComponent preivews and yarddoc.

#### How to run

Starting from view_components root directory

1. `script/setup` - Setups up the whole project, but also bundle installs dependencies for the demo app.
2. Change directory to `/demo/` and run `bin/dev` - Runs the rails server for lookbook.
3. Visit [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

## Running tests

Before running tests make sure you run `bundle exec rake docs:preview`, this will build all the code examples used for accessibility and system tests.

- `script/test` runs the full test suite
- `script/test <file>` runs all the tests in one file
- `script/test <file>:<line>` runs the test defined on the specified line of a file
- `script/test '<glob>'` runs tests in all the files matching the glob
