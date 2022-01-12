# Updating components

## Workflow with Primer CSS changes

All the styling for Primer ViewComponents comes from [Primer CSS](https://github.com/primer/css). ViewComponents shouldn’t use Primer CSS utility classes directly for styling, there should be a 1:1 mapping between components in Primer ViewComponents and component classes in Primer CSS.

Currently Primer CSS is in a separate repository so the workflow for making changes to Primer ViewComponents and CSS is quite cumbersome.

As part of its actions workflow Primer CSS makes [snapshot releases](https://github.com/changesets/changesets/blob/main/docs/snapshot-releases.md) which you can use to test your changes in Primer ViewComponents. Develop your changes in Primer CSS and make a draft pull request. Once the checks have been completed you can get the snapshot release version from the check description:

![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159950-642252c8-d71b-47c7-a991-d23b74135bc7.png#gh-light-mode-only)
![Screenshot of Primer CSS PR merge box with snapshot release version highlighted](https://user-images.githubusercontent.com/1901935/149159954-2e5225a2-8bf5-4610-8eea-5b865e24c637.png#gh-dark-mode-only)

Run `script/upgrade-primer-css <version>` to update the Primer CSS version for Storybook, the demo site, and the docs site. The snapshot release is anchored to a particular commit so if you make changes to your Primer CSS pull request you have to get the new snapshot version and re-run the upgrade. Remember to remove the changes before merging your Primer ViewComponents pull request.
