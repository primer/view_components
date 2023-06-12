# Updating components

Our approach to making API changes and deprecations is heavily guided by a component’s usage in the [github.com codebase](https://github.com/github/github) and your confidence in the scope of your changes.

If making a breaking change to a component’s API will require none or only a few updates in github.com then it is okay to release the breaking change and include any required updates in the pull request for upgrading the Primer ViewComponents library in github.com (we haven’t established a process for communicating these yet but make sure they’re detailed in your pull request).

If the change requires a lot of updates or you’re unsure of the consequences of the change it’s best to follow the deprecation process:

1. Make the changes without effecting existing functionality

   For significant changes consider the [component lifecycle](https://primer.style/design/guides/component-lifecycle) criteria; if the changes qualify the component for the next maturity level it’s much easier to introduce, for example, a new Beta component and deprecate the Alpha component than maintaining both APIs in a single component. This also makes it easier to identify which cases have been migrated.

2. Mark old functionality as deprecated

   For arguments add `DEPRECATED` before the YARD argument description, for components update the `status` value to `:deprecated`.

3. Write an ERB linter to detect and fix uses of old functionality

   This will make it easier to find uses of the old functionality in github.com. Our ERB linters also have autocorrection logic so we can automate migrations where possible. [See our linting guide for details on how to write linters](./linting.md).

4. Make a release and upgrade the Primer ViewComponents library in github.com
5. Migrate uses in github.com to new functionality

   To use your linter run:

   ```bash
   bin/bundle exec erblint --enable-linters LinterName -a app/views app/components app/packages
   ```

   You can also enable your linter globally by adding it to [`.erb-lint.yml`](https://github.com/github/github/blob/master/.erb-lint.yml).

   If the migrations result in a lot of changes it’s best to split them up into multiple pull requests. [Here’s an example script for drafting pull requests by codeowners](https://github.com/primer/view_components/pull/972#discussion_r784217378).

6. Remove old functionality

   Deprecated arguments can be removed as soon as they’re no longer used in github.com. If the status has changed the old component can be removed after one month [TBC].

7. Make a release and upgrade the Primer ViewComponents library in github.com
