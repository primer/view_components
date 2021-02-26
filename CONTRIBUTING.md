# Contributing

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

If you have any substantial changes that you would like to make, please [open an issue](http://github.com/primer/view_components/issues/new) first to discuss them with us.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [project's open source license](LICENSE.txt).

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Submitting a pull request

0. [Fork](https://github.com/primer/view_components/fork) and clone the repository
0. Configure and install the dependencies: `./script/setup`
0. Make sure the tests pass on your machine: `bundle exec rake`
0. Create a new branch: `git checkout -b my-branch-name`
0. Make your change, add tests, and make sure the tests still pass
0. Add an entry to the top of `CHANGELOG.md` for your changes
0. Push to your fork and [submit a pull request](https://github.com/primer/view_components/compare)
0. Pat yourself on the back and wait for your pull request to be reviewed and merged.

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

- Write tests.
- Write [YARD comments](https://yardoc.org/) for component and slot initializers. Please document the purpose and general use of new components or slots you add, as well as the parameters they accept. See for example the comment style in app/components/primer/counter_component.rb.
- Add new components to the `components` list in Rakefile in the `docs:build` task, so that Markdown documentation is generated for them within docs/content/components/.
- Keep your change as focused as possible. If there are multiple changes you would like to make that are not dependent upon each other, consider submitting them as separate pull requests.
- Write a [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Releasing

If you are the current maintainer of this gem:

1. Checkout to `main`
1. Run `./script/release` and follow the instructions.

## Criteria for changing component status

### Promote from alpha to beta

The following criteria should be met:

- The component does not use any deprecated `view_components` platform features (eg - Slots v1).
- Documentation and storybook stories are complete.
- The API is expected to be stable.
