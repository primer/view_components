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

Releases are managed by 🦋 [Changesets](https://github.com/atlassian/changesets#documentation) which is a great tool for managing major/minor/patch bumps and changelogs. More info can be found in our [how we work docs](https://github.com/github/design-infrastructure/blob/main/how-we-work/engineering/changesets.md#using-changesets-to-prepare-and-publish-a-release).

We have the [changeset-bot comment on new pull requests](https://github.com/changesets/bot#readme) asking contributors or maintainers to add a changeset file, which will become the markdown supported changelog entry for the change.

When creating the changeset always commit into the working branch (pull request branch), not `main`.

When a pull request is approved merge it into the `main` branch. The changeset action will then create a Release pull request that includes this new pull request.

Once maintainers have agreed and are satisfied with the release. Merge the Release pull request. Changesets will then publish a new GitHub release to the repository with the changelog and new version number.

### Publishing a release

When the release pull request is merged into `main`, pull the changes and run `script/publish` to publish the library on rubygems and npm.

🎉 Congratulations! The new release has been published.

## Revert plan

If you’ve released a version of the library that introduces significant visual regressions or unintended breaking changes the best thing to do is make a new release which reverts the offending changes. Do not include any other unreleased changes besides the reverts, as they could have unintended side-effects.

[Process TBC]

## Docs deployment

The [documentation site](https://primer.style/view-components) and [Lookbook](https://primer.style/view-components/lookbook) are automatically deployed by GitHub Action workflows when changes are made to the `main` branch. The documentation site is deployed with GitHub Pages (aliased from [https://primer.github.io/view_components/](https://primer.github.io/view_components/)) and Lookbook is deployed with Azure as it relies on a live Rails server (aliased from [view-components-storybook.eastus.cloudapp.azure.com](https://view-components-storybook.eastus.cloudapp.azure.com)).
