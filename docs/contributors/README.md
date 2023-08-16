# Contributing

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

If you have any substantial changes that you would like to make, please [open an issue](http://github.com/opf/primer_view_components/issues/new) first to discuss them with us.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](https://github.com/opf/primer_view_components/blob/main/LICENSE.txt).

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/opf/primer_view_components/blob/main/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Developing locally

Checkout [this guide](./setup.md) on how to develop locally.

## Adding a new component

Check out our guide for [adding new components](./adding-components.md).

## Testing

We have an advanced test setup described in our [test guide](./playwright-testing.md)., including visual regression tests.

## Writing documentation

Documentation is written as [YARD](https://yardoc.org/) comments directly in the source code, compiled into Markdown via `bundle exec rake docs:build` and served by [Doctocat](https://github.com/primer/doctocat).

### Documentation / Demo Rails App - TODO: NEEDED?

* **Docs**: Generated YARD docs with examples, see components with usage instructions and examples
  * Typically runs on port 5400
  * To rebuild docs, run `bundle exec rake docs:build`
* **Demo App**: See components on a plain page with no interfering framework or styling. Used to test functionality.
  * Typically runs on port 4000 - visit `/rails/view_components/` in your browser
  * To rerender the templates, you do not have to restart the server. Run `bundle exec rake docs:preview` and refresh the page.

---
To run the documentation site and the demo app, run:

```bash
script/dev
```

If you are running into issues or not seeing your updates, a few things you can try:

* Delete the `overmind.sock` file and run `script/dev` again
* Ensure you have run `script/setup`
* Delete the `node_modules` directory and re-run `script/setup`
* Run `bundle exec rake docs:build`
* Run `bundle exec rake docs:preview`

_Note: Overmind is required to run script/dev._

## Submitting a pull request

1. Checkout the repository
1. Configure and install the dependencies: `./script/setup`
1. Make sure the tests pass on your machine
1. Create a new branch: `git checkout -b my-branch-name`
1. Make your change, add tests, and make sure all the tests still pass
1. Add a [changeset](https://github.com/changesets/changesets/blob/main/docs/adding-a-changeset.md) for your changes if needed
   1. We have a bot as well as a Github workflow enabled in order to remind you about the changeset as it is an essential part for the release process.
1. Push to your branch and [submit a pull request](https://github.com/opf/primer_view_components/compare)
1. Pat yourself on the back and wait for your pull request to be reviewed and merged. After merging it will be included in the next release.

### PR tips

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

* Write thorough [tests](#testing).
* Write a descriptive pull request message.
* Write comprehensive [documentation](#writing-documentation) and make sure the generated documentation is committed.
* Add new components to the `components` list in the `docs:build` task, so that Markdown documentation is generated for them within docs/content/components/.
* Keep your change as focused as possible; if there are multiple changes you would like to make that are not dependent on one other consider submitting them as separate pull requests.
