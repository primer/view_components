# Styling

All the styling for Primer ViewComponents comes from [Primer CSS](https://github.com/primer/css). ViewComponents shouldn’t use inline styles or Primer CSS utility classes directly for styling, there should be a 1:1 mapping between components in Primer ViewComponents and component classes in Primer CSS.

## Workflow with Primer CSS

Currently Primer CSS is in a separate repository so the workflow for making changes to Primer ViewComponents and CSS is not straightforward. You can choose between a local setup with hot reloading or use snapshot releases.

### Hot reloading (local only)

This setup leverages [yarn link](https://classic.yarnpkg.com/en/docs/cli/link) to hot reload any changes in Primer CSS. It links the Primer CSS dependency on the documentation site, demo app and Storybook to the `/dist` folder in your local installation of Primer CSS.

1. [Set up Primer ViewComponents](./setup.md) and [Primer CSS](https://github.com/primer/css) for local development.

2. On the Primer CSS folder, run `yarn link`. This will register `@primer/css` as a source.

3. Run `yarn link "@primer/css"` in the Primer ViewComponents root, `/docs` and `/demo` folders.

4. Run `yarn dist:watch` on your Primer CSS folder. This process will keep the /dist folder up to date with your CSS changes.

5. Run `script/dev` on your Primer ViewComponents folder.

The Primer ViewComponents documentation site and Storybook will hot reload any changes to Primer CSS after a few seconds. Once you are done testing we recommend using the snapshot release method below for the pull request review.

To reverse this process follow the [yarn unlink instructions](https://classic.yarnpkg.com/en/docs/cli/unlink).

_Note: Hot reloading doesn’t work on the demo app; run `yarn postinstall` on the `/demo` folder and refresh to see CSS changes._

### Snapshot releases (local or Codespaces)

As part of its actions workflow Primer CSS makes [snapshot releases](https://github.com/changesets/changesets/blob/main/docs/snapshot-releases.md) which you can use to test your changes in Primer ViewComponents. Develop your changes in Primer CSS and make a draft pull request. Once the checks have been completed you can get the snapshot release version from the check description:

![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159950-642252c8-d71b-47c7-a991-d23b74135bc7.png#gh-light-mode-only)
![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159954-2e5225a2-8bf5-4610-8eea-5b865e24c637.png#gh-dark-mode-only)

Run `script/upgrade-primer-css <version>` to update the Primer CSS package version for Storybook, the demo site, and the docs site. The snapshot release is anchored to a particular commit so if you make changes to your Primer CSS pull request you have to get the new snapshot version from the check description and re-run the upgrade script.

Snapshot releases can be useful for Primer ViewComponents pull request reviews when Primer CSS changes aren’t merged or released yet. It’s best practice to make separate commits for upgrading the Primer CSS package version so it’s easy to drop those changes before merging your Primer ViewComponents pull request.
