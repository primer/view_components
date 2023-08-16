# Releasing

## When to make a release

All changes that effect library output should be documented in [the Changelog](https://github.com/primer/view_components/blob/main/CHANGELOG.md) as part of the pull request process, so when the `main` branch has changes that aren't released yet they will be documented under the 'main' title in the Changelog.

We use [semver](https://semver.org/) for our release naming but we’re currently pre-v1 so every change is a patch release, and may contain breaking changes.

It's preferable to group changes so we don't release a new version for every small change, but for fixes or urgent features it's okay to make releases for a small amount of changes.

## Release process

### Preparing a release

Releases are managed by 🦋 [Changesets](https://github.com/atlassian/changesets#documentation) which is a great tool for managing major/minor/patch bumps and changelogs.

We have the [changeset-bot comment on new pull requests](https://github.com/changesets/bot#readme) asking contributors or maintainers to add a changeset file, which will become the markdown supported changelog entry for the change.

When creating the changeset always commit into the working branch (pull request branch), not `main`.

When a pull request is approved merge it into the `main` branch. The changeset action will then create a Release pull request that includes this new pull request.

Once maintainers have agreed and are satisfied with the release, they will merge the Release pull request. Changesets will then publish a new GitHub release to the repository with the changelog and new version number, as well as a new version of the Rubygem and NPM package.

## Revert plan

If you’ve released a version of the library that introduces significant visual regressions or unintended breaking changes the best thing to do is make a new release which reverts the offending changes. Do not include any other unreleased changes besides the reverts, as they could have unintended side-effects.

[Process TBC]
