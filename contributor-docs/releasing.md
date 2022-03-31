# Releasing

## When to make a release

All changes that effect library output should be documented in [the Changelog](https://github.com/primer/view_components/blob/main/CHANGELOG.md) as part of the pull request process, so when the `main` branch has changes that aren't released yet they will be documented under the 'main' title in the Changelog.

We use [semver](https://semver.org/) for our release naming but we’re currently pre-v1 so every change is a patch release, and may contain breaking changes.

It's preferable to group changes so we don't release a new version for every small change, but for fixes or urgent features it's okay to make releases for a small amount of changes.

## Release process

### Authentication

Before publishing you need to authenticate with [npm](https://www.npmjs.com/) and [RubyGems](https://rubygems.org/).

For [RubyGems](https://rubygems.org/) create an account with your personal email and set up two factor authentication. Ask an owner of the [`primer_view_components` gem](https://rubygems.org/gems/primer_view_components) to add you as a contributor, and then run `gem signin` to authenticate with the CLI.

For [npm](https://www.npmjs.com/) create an account with your personal email and set up two factor authentication. Ask one of the collaborators on the [`@primer/view-components` package](https://www.npmjs.com/package/@primer/view-components) to add you to the Primer team, then run `npm adduser` to authenticate with the CLI. You can confirm your authentication with `npm whoami`.

### Preparing a release

Run `script/release` to prepare a release. This will check you're on the latest version of the `main` branch, bump the gem and npm package versions, tag the Changelog, and open a pull request with the changes. Even if no changes have been made to the JavaScript package we make a release anyway so the version numbers are always in sync. Once the tests have passed you can merge this pull request.

### Publishing a release

When the release pull request is merged into `main`, pull the changes and run `script/publish` to publish the library on rubygems and npm. This will also open a pre-filled release on GitHub, if you’re happy with the release notes hit ‘Publish’.

## Revert plan

If you’ve released a version of the library that introduces significant visual regressions or unintended breaking changes the best thing to do is make a new release which reverts the offending changes. Do not include any other unreleased changes besides the reverts, as they could have unintended side-effects.

[Process TBC]

## Docs deployment

The [documentation site](https://primer.style/view-components) and [Storybook](https://primer.style/view-components/stories) are automatically deployed by GitHub Action workflows when changes are made to the `main` branch. The documentation site is deployed with Vercel (aliased from [view-components.vercel.app](https://view-components.vercel.app)) and Storybook is deployed with Azure as it relies on a live Rails server (aliased from [view-components-storybook.eastus.cloudapp.azure.com](https://view-components-storybook.eastus.cloudapp.azure.com)).
