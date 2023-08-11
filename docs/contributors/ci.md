# CI

Next to the several test, there are other GitHub workflows automatically triggered on certain actions.

We disabled all workflows that we do not need (e.g the lookbook deployment) by changing the `on` keyword to

```yml
on:
  pull_request:
    branches:
      - DO_NOT_EXECUTE_THIS_WORKFLOW
```

## Pull request automation

* [Test](../../.github/workflows/test.yml)
* [Triage](../../.github/workflows/triage.yml)
  * Put a semver label on the PR
  * Check for the existence of a changeset (can be skipped with the label "**skip changeset**")
* [Linting](../../.github/workflows/lint.yml)

### Changeset bot

Additionally to the Triage automation, we installed a changeset bot which automatically comments on every PR. If there is no changeset yet, it provides a link to add one.

You can read more on why the changeset are important, in our [release documentation](./releasing.md).

## Release automation

* [Release PR](../../.github/workflows/release.yml)
  * The release PR is automatically created when changeset files are merged to the main branch. The PR contains all changes which are not published yet. So it remains open until a new release shall be triggered.
* [Publishing](../../.github/workflows/publish.yml)
  * When the release PR is merged, the publish workflow bumps the version on Github, release a new gem version as well as the new npm package version.
