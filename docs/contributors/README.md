# Contributing

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

If you have any substantial changes that you would like to make, please [open an issue](http://github.com/primer/view_components/issues/new) first to discuss them with us.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](https://github.com/primer/view_components/blob/main/LICENSE.txt).

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/primer/view_components/blob/main/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Adding a new component

Use the provided generator to create a component:

```sh
bundle exec thor component_generator my_component_name
```

To declare a dependency on an `npm` package, pass `js` to the generator:

```sh
bundle exec thor component_generator my_component_name --js=some-npm-package-name
```

### Tag considerations

Components and slots should restrict which HTML tags they will render. For example, an `Image` component should never be rendered as an `<h1>`.

Consider which HTML tags make sense. Components typically fall under one of the following patterns:

1) Fixed tag that cannot be updated by the consumer:

```rb
system_arguments[:tag] = :h1
```

2) Allowed list of tags that are set with the `tag:` argument using the `fetch_or_fallback` helper.

```rb
system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
```

## Testing

Before running the whole test suite with: `script/test`, you must run `bundle exec rake docs:preview`.

Run a subset of tests by supplying arguments to `script/test`:

1. `script/test FILE` runs all tests in the file.
1. `script/test FILE:LINE` runs test in specific line of the file.
1. `script/test 'GLOB'` runs all tests for matching glob.
    * make sure to wrap the `GLOB` in single quotes `''`.

### System tests

Primer ViewComponents utilizes Cuprite for system testing components that rely on JavaScript functionality.

By default, the system tests run in a headless Chrome browser. Prefix the test command with `HEADLESS=false` to run the system tests in a normal browser.

## Writing documentation

Documentation is written as [YARD](https://yardoc.org/) comments directly in the source code, compiled into Markdown via `bundle exec rake docs:build` and served by [Doctocat](https://github.com/primer/doctocat).

### Documentation / Demo Rails App

#### Demo App

See components on a plain page with no interfering framework or styling. Used to test functionality.

* Typically runs on port 4000 - visit `/rails/view_components/` in your browser
* To rerender the templates, you do not have to restart the server. Run `bundle exec rake docs:preview` and refresh the page.

---
To run the demo app, run:

```bash
script/dev
```

If you are running into issues or not seeing your updates, a few things you can try:

* Delete the `overmind.sock` file and run `script/dev` again
* Ensure you have run `script/setup`
* Delete the `node_modules` directory and re-run `script/setup`

_Note: Overmind is required to run script/dev._

#### Documentation

To run the documentation site locally, one option is to generate the `info_arch.json` file required for the documentation site to run, then updating the path to your generated version in a clone of the [`primer/design` repo](https://github.com/primer/design).

To generate the `info_arch.json` file with your changes to preview, in the `view_components` repo, run:

```bash
bundle exec rake static:dump_info_arch
```

You should see a generated `static/info_arch.json` file. Clone the [`primer/design` repo](https://github.com/primer/design) repo and copy/paste the `info_arch.json` file into the root of that repo.

Then, change the path in the [`gatsby-node.esm.js` file](https://github.com/primer/design/blob/main/gatsby-node.esm.js#L199) to point to your new, generated file.

Note: if you're pointing to the file locally (i.e. `./info_arch.json`), you will also need to change the following lines since you don't need to `fetch` this data from an API.

Change:

```js
const argsJson = await fetch(url).then(res => res.json())
const argsContent = JSON.parse(Buffer.from(argsJson.content, 'base64').toString())
```

to

```js
const argsJson = fs.readFileSync(url, 'utf-8')
const argsContent = JSON.parse(argsJson)
```

Then, in the **primer/design repo**, run `yarn run start` to spin up the Gatsby docs to preview locally with your changes!

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

To minimize the number of restarts, we recommend checking the component in Lookbook first, and then when it's in a good state, you can check it in your app.

## Submitting a pull request

1. [Fork](https://github.com/primer/view_components/fork) and clone the repository
1. Configure and install the dependencies: `./script/setup`
1. Make sure the tests pass on your machine
1. Create a new branch: `git checkout -b my-branch-name`
1. Make your change, add tests, and make sure all the tests still pass
1. Add a [changeset](https://github.com/changesets/changesets/blob/main/docs/adding-a-changeset.md) for your changes if needed
1. Push to your fork and [submit a pull request](https://github.com/primer/view_components/compare)
1. Pat yourself on the back and wait for your pull request to be reviewed and merged. After merging it will be included in the next release.

### PR tips

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

* Write thorough [tests](#testing).
* Write a descriptive pull request message.
* Write comprehensive [documentation](#writing-documentation) and make sure the generated documentation is committed.
* Add new components to the `components` list in the `docs:build` task, so that Markdown documentation is generated for them within docs/content/components/.
* Keep your change as focused as possible; if there are multiple changes you would like to make that are not dependent on one other consider submitting them as separate pull requests.

## Deploying the Rails Lookbook

The Rails lookbook is currently deployed via GitHub Actions using [this workflow](https://github.com/primer/view_components/actions/workflows/deploy-production.yml). Deployments happen automatically on every merge to the `main` branch. The Lookbook runs in a Kubernetes cluster hosted within our team's Azure subscription. Please contact a member of the team for access.

## Publishing a Release

To publish a release, you must have an account on [rubygems](https://rubygems.org/) and [npmjs](https://www.npmjs.com/). Additionally, you must have been added as a maintainer to the project. Please verify that you have 2FA enabled on both accounts.

If you're a Hubber, refer to these more detailed [release docs](https://github.com/github/primer/blob/main/how-we-work/releasing-primer-view-components.md).
