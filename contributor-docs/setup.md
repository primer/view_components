# Setup

The easiest way to get started contributing to Primer ViewComponents is with [Codespaces](https://github.com/features/codespaces), Codespace environments come fully set up for development.

## Setup for local development

1. Clone `git@github.com:primer/view_components.git`
2. Install [Overmind](https://github.com/DarthSim/overmind) and [Yarn](https://classic.yarnpkg.com/lang/en/docs/install)
3. Run `script/setup` to install dependencies
4. Run `script/demo`, this will run the documentation site on Lookbook on [localhost:4000](localhost:4000) and Storybook on [localhost:5000](localhost:5000)

### Troubleshooting

When running Storybook locally, if you see:

> Cannot GET /

Try deleting your `node_modules` directory and rerunning `script/setup` followed by `script/dev`.

## Running tests

Before running tests make sure you run `bundle exec rake docs:preview`, this will build all the code examples used for accessibility and system tests.

- `script/test` runs the full test suite
- `script/test <file>` runs all the tests in one file
- `script/test <file>:<line>` runs the test defined on the specified line of a file
- `script/test '<glob>'` runs tests in all the files matching the glob
