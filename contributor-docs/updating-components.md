# Updating components

## Deprecation and removal process

Our approach to making API changes and deprecations is heavily guided by a component’s usage in the [github.com codebase](https://github.com/github/github) and your confidence in the scope of your changes. If making a breaking change to a component’s API will require none or only a few updates in github.com then it is okay to release the breaking change and include any required updates in the pull request for upgrading the Primer ViewComponents library in github.com (we haven’t established a process for communicating these yet but make sure they’re detailed in your pull request).

If the change requires a lot of updates or you’re unsure of the consequences of the change it’s best to follow the deprecation process:

1. Make the changes without effecting existing functionality

   For significant changes consider the [component lifecycle](https://primer.style/contribute/component-lifecycle) criteria; if the changes qualify the component for the next maturity level it’s much easier to introduce, for example, a new Beta component and deprecate the Alpha component than maintaining both APIs in a single component. This also makes it easier to identify which cases have been migrated.

2. Mark old functionality as deprecated

   For arguments add `DEPRECATED` before the YARD argument description, for components update the `status` value to `:deprecated`.

3. Write an ERB linter to detect and fix uses of old functionality

   This will make it easier to find uses of the old functionality in github.com. Our ERB linters also have autocorrection logic so we can automate migrations where possible. [See our linting guide for details on how to write linters](https://primer.style/view-components/linting).

4. Make a release and upgrade the Primer ViewComponents library in github.com
5. Migrate uses in github.com to new functionality

   [How do we run the migrations / get data from the linter?]

   If the migrations result in a lot of changes it’s best to split them up into multiple pull requests. [Is there a strategy for this to ping as few teams as possible?]

6. Remove old functionality

   Deprecated arguments can be removed as soon as they’re no longer used in github.com. If the status has changed the old component can be removed after one month [TBC].

7. Make a release and upgrade the Primer ViewComponents library in github.com

## Workflow with Primer CSS changes

All the styling for Primer ViewComponents comes from [Primer CSS](https://github.com/primer/css). ViewComponents shouldn’t use Primer CSS utility classes directly for styling, there should be a 1:1 mapping between components in Primer ViewComponents and component classes in Primer CSS.

Currently Primer CSS is in a separate repository so the workflow for making changes to Primer ViewComponents and CSS is not straightforward. You can choose between a local setup with hot reloading or use the snapshot releases.

### Hot reloading (Local only)

This setup leverages [yarn link](https://classic.yarnpkg.com/en/docs/cli/link) to hot reload any changes in Primer CSS. It links the Primer CSS dependency on the documentation site, demo app and Storybook to the `/dist` folder in your local installation of Primer CSS.

1. [Set up Primer ViewComponents](./setup.md) and [Primer CSS](https://github.com/primer/css) for local development.

2. On the Primer CSS folder, run `yarn link`. This will register `@primer/css` as a source.

3. Run `yarn link "@primer/css"` in the Primer ViewComponents root, `/docs` and `/demo` folders.

4. Run `yarn dist:watch` on your Primer CSS folder. This process will keep the `/dist` folder up to date.

5. Run `script/dev` on your Primer ViewComponents folder.

The Primer ViewComponents documentation site and Storybook will hot reload any changes to Primer CSS after a few seconds. Once you are done, we recommend using a snapshot release for the pull request review.

To reverse this process, follow the [yarn unlink instructions](https://classic.yarnpkg.com/en/docs/cli/unlink).

_Note: The demo app doesn't hot reload, but this workflow still works. Simply run `yarn postinstall` on the `/demo` folder to refresh your changes._

### Snapshot releases (Local or Codespaces)

As part of its actions workflow Primer CSS makes [snapshot releases](https://github.com/changesets/changesets/blob/main/docs/snapshot-releases.md) which you can use to test your changes in Primer ViewComponents. Develop your changes in Primer CSS and make a draft pull request. Once the checks have been completed you can get the snapshot release version from the check description:

![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159950-642252c8-d71b-47c7-a991-d23b74135bc7.png#gh-light-mode-only)
![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159954-2e5225a2-8bf5-4610-8eea-5b865e24c637.png#gh-dark-mode-only)

Run `script/upgrade-primer-css <version>` to update the Primer CSS version for Storybook, the demo site, and the docs site. The snapshot release is anchored to a particular commit so if you make changes to your Primer CSS pull request you have to get the new snapshot version and re-run the upgrade. Remember to remove the changes before merging your Primer ViewComponents pull request.
