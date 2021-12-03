# CHANGELOG

<!--
Authoring changelog entries

This file holds all the changes made in previous versions of Primer View Components and the ones coming to the next version.
To add yours, you need to find in which category to write it under the `main` section. `Main` is the first section on top of the document.
There are six categories currently in use, `New`, `Updates`, `Bug fixes`, `Breaking changes`, `Deprecations` and `Misc`.

- New
Category for new components, system behaviours, options and arguments changes

- Updates
Every non-breaking change to the source code go there.

- Bug Fixes
Non-breaking bug fixes to existing code.

- Breaking Changes
The category for changes creating incompatibilities to code written with previous versions.
It includes any changes to components name, signature and behaviour. Also, include removing tags options or changing file location.
If you are not sure you made breaking changes, ask us in your pull request.

- Deprecations
For changes that explicitly deprecate part of the code base.

- Misc
The category for changes related to documentation, testing and tooling. Also, for pull requests that can't fit in other sections.
-->

## main

### Deprecations

* Deprecate `variant` in favor of `size` in `ButtonComponent` and `ButtonGroup`.

    *Manuel Puyol*

## 0.0.63

### Breaking Changes

* Rename `caret` argument to `dropdown` in `ButtonComponent`.

    *Manuel Puyol*

* Remove `:large` variant from `ButtonComponent`.

    *Manuel Puyol*

* Update `Spinner` to add system arguments to outermost element

    *Charlotte Dann*

### Deprecations

* Deprecate `icon` and `counter` slots in `ButtonComponent` in favor of `leading_visual` and `trailing_visual`.

    *Manuel Puyol*

### Bug Fixes

* Fix `PopoverComponent`, allowing to reset `left` and `right` positioning.

    *Manuel Puyol*

## 0.0.62

### New

* Add linter for tracking deprecated `LayoutComponent` callsites

    *Josh Klina*

### Updates

* Update `Button` to add `8px` spacing between icon, text and counter.

    *Manuel Puyol*

* Update `BlankslateApiMigration` linter to support interpolations.

    *Manuel Puyol*

* Change spacing in `Blankslate`:
  * Between `description` and `primary_action` to `32px`.
  * Between `primary_action` and `secondary_action` to `16px`.

    *Manuel Puyol*

* Improve performance of `Classify#call`.

    *Cameron Dutro*

### Breaking Changes

* Add a warning to users if they try to use `tag:` parameters on a component where the tag is fixed.

    *Owen Niblock*

* Updating to @primer/css@19.0.0 and @primer/primitives@7.1.0. Which removes support for deprecated system color arguments.

    *Jon Rohan*

* Prevent `aria-label` to be used with `:div, :span, :p` tags without an explicit `role`.

    *Manuel Puyol*

## 0.0.61

### New

* Adding new Alpha component: `Layout` with `main` and `sidebar` slots

    *Cameron Dutro*

* Add a two-column layout linter.

    *Cameron Dutro*

* Add the `HellipButton` component

    *Amélia Chavot*, *Owen Niblock*

### Updates

* Bump Storybook version to include Skip to Content links for keyboard auditors.

    *Katie Foster @inkblotty*

* Update the `HiddenTextExpander` component to use the `HellipButton`.

    *Amélia Chavot*, *Owen Niblock*

### Misc

* Fix components not rendering in Storybook because of kebab case arguments.

    *Amélia Chavot*, *Manuel Puyol*, *Owen Niblock*

* Fix a typo on a command on the contribution page.

    *Amélia Chavot*, *Owen Niblock*

### Bug Fixes

* Fix issue where tags were not self-closing when they are void elements.

    *Owen Niblock*

### Deprecations

* Deprecate `Primer::BlankslateComponent` in favor of `Primer::Beta::Blankslate`.

    *Manuel Puyol*

### Breaking Changes

* Require an `aria-label` to be provided for the `HiddenTextExpander` component.

    *Amélia Chavot*, *Owen Niblock*

* Rename `force_system_arguments` to `raise_on_invalid_options` to better reflect its functionality

    *Owen Niblock*

* Renamed `Blankslate` `title` slot to `heading`.

    *Manuel Puyol*

* Removed `Blankslate` `large` variant.

    *Manuel Puyol*

* Renamed `Blankslate` `graphic` slot to `visual`.

    *Manuel Puyol*

## 0.0.60

### Updates

* Adding new Alpha component: BorderBox Header with optional `title` slot

    *Katie Foster @inkblotty*

* Add note about `Breadcrumbs` not being responsive.

    *Joel Hawksley*

* Handling arguments that aren't system arguments or string arguments in primer_octicon.

    *Jon Rohan, Manuel Puyol*

* Improvements to the Procfile so script/dev works as expected.

    *Cameron Dutro*

* Migrating grid classes to utilities.yml process

    *Jon Rohan*

* Adding new system color arguments, and deprecating old arguments.

    *Jon Rohan*

* Make `Spinner` more accessible by adding `sr-only` loading text.

    *Manuel Puyol*

* Make class name validation configurable instead of relying on the Rails env.

    *Cameron Dutro*

### Bug Fixes

* Removes unwanted bottom border from active tab of `Alpha::TabNav`.

    *Ned Schwartz*

### Breaking changes

* Add size restriction to `Avatar`.

    *Kate Higa*

* Remove `square` attribute from `Avatar` in favor of `shape`. This change also affects `TimelineItem` `avatar` slot.

    *Manuel Puyol*

## 0.0.59

### Updates

* Changed `ClipboardCopy` to use `copy` instead of `paste` icon.

    *Cole Bemis*

### Breaking changes

* `Breadcrumbs` no longer accepts padding and font size system arguments.

    *Joel Hawksley*

## 0.0.58

### Updates

* Add accessibility section to `Breadcrumbs` page.

    *Kate Higa*

* Improve performance of the Classify module, i.e. `Classify.call`.

    *Cameron Dutro*

* Background arguments are now pulled in through the utilities class.

    *Jon Rohan*

* Border arguments are now pulled in through the utilities class.

    *Jon Rohan*

### Breaking changes

* `bg:` system argument will no longer accept hex color strings, and deprecated color scale.

    *Jon Rohan*

### Bug fixes

* Fix `ClipboardCopy` octicons not toggling correctly after first click.

    *Manuel Puyol, Kristján Oddsson*

## 0.0.57

### Bug fixes

* Don't suggest empty colors for Octicons when autocorrecting.

    *Manuel Puyol*

## 0.0.56

### Updates

* `Octicon` linter will autocorrect colors.

    *Manuel Puyol*

* `Button` linter will autocorrect when button uses `href`, `name`, `value` or `tabindex`.

    *Manuel Puyol*

* `Flash` linter won't autocorrect flashes with ERB in their content.

    *Manuel Puyol*

* Eager load components.

    *Cameron Dutro*

### Misc

* Refactor some of the rubocop valid_node? logic into BaseCop class.

    *Jon Rohan*

* Fix validation checker to use Utilities for color-* classes.

    *Jon Rohan*

## 0.0.55

### Breaking changes

* `Primer::Breadcrumbs` requires `href`s for all items and no longer accepts the `selected` argument.

    *Joel Hawksley*

* Split `TabNav` into `TabNav` and `TabPanels`.

    *Kate Higa*

### New

* Use the allocation_stats gem to count object allocations in our benchmarks.
* Improve performance of Octicon cache key construction.

    *Cameron Dutro*

* Update `@primer/css` to `17.7.0` which includes a new argument for `word_break`

    *Jon Rohan*

### Misc

* Clean up extra constants in `UnderlineNav`.

    *Kate Higa*

## 0.0.54

### Breaking changes

* Rename `BreadcrumbComponent` to `Beta::Breadcrumbs`.

    *Joel Hawksley*

* Split `UnderlineNavComponent` into `Alpha::UnderlineNav` and `Alpha::UnderlinePanels`.

    *Kate Higa*

## 0.0.53

### New

* Add autocorrection to `FlashComponent` linter when the context is basic text.

    *Manuel Puyol*

### Updates

* Linters won't mark offenses when the ignore count is correct unless explicitly configured to do so.

    *Manuel Puyol*

* Deprecating background and border color presentational arguments

    *Jon Rohan*

* Map the `for` argument when autofixing `ClipboardCopy` migrations.

    *Kristján Oddsson*

* Add autocorrection for `CloseButton` linter.

    *Manuel Puyol*

* Moving text color variables to Utilities class

    *Jon Rohan*

### Bug fixes

* Linters won't convert HTML special elements.

    *Manuel Puyol*

### Misc

* Only run CHANGELOG CI on pull requests.

    *Manuel Puyol*

* Run CI actions on pushes to main.

    *Cameron Dutro*

* Get to 100% code coverage.

    *Cameron Dutro*

## 0.0.52

### New

* Adding `Primer::Beta::Truncate` component to reflect changes in primer/css component [Truncate](https://primer.style/css/components/truncate).

    *Jon Rohan*

* Add cop to look for deprecated system arguments and suggest replacements.

    *Jon Rohan*

* Add cop to use `primer_octicon` in favor of `octicon`.

    *Manuel Puyol*

* Fix release script so it doesn't loop continuously.

    *Cameron Dutro*

### Updates

* Promote `ClipboardCopy` to beta.

    *Manuel Puyol*

* PrimerOcticon linter supports `aria-` and `data-` attributes.

    *Manuel Puyol*

* Linters can:
  * convert values with ERB interpolations.
  * autocorrect cases with custom classes.

    *Manuel Puyol*

* Add a `scheme` option to `BorderBoxComponent` rows.

    *Cameron Dutro*

* Upgrade rubocop and support Ruby 3.0.

    *Cameron Dutro*

* Linters will not autocorrect cases where a required argument is missing.

    *Manuel Puyol*

### Misc

* Update benchmarks to run in every supported Ruby version.

    *Manuel Puyol*

* Add a linter generator.

    *Manuel Puyol*

## 0.0.51

### Breaking changes

* Rename `width` and `height` System Arguments to `w` and `h`, resolving conflict with HTML attribute names.

    *Manuel Puyol*

### Updates

* `SystemArgumentInsteadOfClass` linter will check for arguments in ViewHelpers.

    *Manuel Puyol*

## 0.0.50

### Updates

* Fix incorrect slots syntax in docs.

    *Joel Hawksley*, *Blake Williams*

### New

* Add linter suggestions for `CloseButton` component.

    *Manuel Puyol*

### Breaking changes

* Update to `octicons` `v15`, removing open-ended dependency. See [https://github.com/primer/octicons/releases/tag/v15.0.0] for icon name changes in release.

    *Joel Hawksley*

### Updates

* Don't require `title` for `Label`.

    *Manuel Puyol*

* Improve autocorrectable linters to convert known SystemArgument classes.

    *Manuel Puyol*

* Add support for `width: :full` and `height: :full` to System Arguments.

    *Joel Hawksley*

### Bug fixes

* Update linters to not autocorrect attributes with ERB blocks.

    *Manuel Puyol*

* Fix `:height` and `:width` docs to pull from Utilities

    *Jon Rohan*

## 0.0.49

### New

* Add linter suggestions for `Label` component.

    *Manuel Puyol*

* Add linter suggestions for `ClipboardCopy` component.

    *Manuel Puyol*

### Updates

* Update the `Truncate` component to accept `:strong` as a tag.

    *Amélia Chavot*

* Improve `Primer::Classify::Utilities.classes_to_hash` performance.

    *Manuel Puyol*

### Breaking changes

* Require tab with panels to have `panel_id` so `aria-controls` can be set.

    *Kate Higa*

* Renames:
  * `Primer::AvatarStackComponent` to `Primer::Beta::AvatarStack`.

    *Manuel Puyol*

### Misc

* Extract example tag parsing into helper.

    *Kate Higa*

* Generate a static constant JSON and use it when defining linters.

    *Manuel Puyol*

## 0.0.48

### Breaking changes

* Ensure panels in `Navigation::Tab` have a label.

    *Kate Higa*

### Misc

* Expose custom cops and default config for erblint.

    *Manuel Puyol*

* Fix double constant assign.

    *Manuel Puyol*

## 0.0.47

### Breaking changes

* Restrict tag for `Popover` to `:div` and `Popover` heading slot to headings.

    *Kate Higa*

* Renames:
  * `Primer::AutoComplete` to `Primer::Beta::AutoComplete`
  * `Primer::AutoComplete::Item` to `Primer::Beta::AutoComplete::Item`
  * `Primer::AvatarComponent` to `Primer::Beta::Avatar`

    *Manuel Puyol*

### Misc

* Update `doc_examples_axe_test` to exclude non-standalone components and fix `Markdown` example.

    *Kate Higa*

* Update `DetailsComponent` examples.

    *Manuel Puyol*

* Add linter to suggest system arguments instead of classes.

    *Manuel Puyol*

* Update component generator to create components in the right status module.

    *Manuel Puyol*

* Add example for truncating HTML to `Truncate`.

    *Joel Hawksley*

* Update docs generation to point to the correct file sources.

    *Manuel Puyol*

* Add ENV flag to dump linter data into a file.

    *Manuel Puyol*

## 0.0.46

### Updates

* Default to matching `name` and `id` of `input`.

    *Kate Higa*

* Restrict usage of padding system arguments on BorderBox, recommending use of `padding` density instead.

    *Joel Hawksley*

### Breaking changes

* Restrict `TabNav`and `Tab` tags.

    *Kate Higa*

* Restrict `AvatarStack` body slot tag and `ImageCrop` spinner tag.

    *Kate Higa*

* Restrict `Details` body slot tags and `UnderlineNav` body slot tags.

    *Kate Higa*

* Move Primer::Classify from `app/lib/` to `lib/`. This requires an extra `require "primer/classify"` statement for anywhere Classify is needed.

    *Manuel Puyol, Jon Rohan*

* Restrict `Menu` heading slot tags to heading tags and require `tag` argument.

    *Kate Higa*

* Adding animation, vertical_align, word_break, display, visibility, & position arguments to the utilities class. `animation: :grow` is now `animation: :hover_grow` this was a change because we changed the class name in primer.

    *Jon Rohan*

### Misc

* Update contributing guidelines with release instructions.

    *Kate Higa*

* Prevent flexible tag syntax with rubocop rule.

    *Kate Higa*

* Update linter autocorrection to use `""` instead of `true` for boolean attributes.

    *Manuel Puyol*

* Update Storybook version.

    *Manuel Puyol*

* Add a changelog authoring guide to `CHANGELOG.md`.

    *Amélia Chavot*

## 0.0.45

### Updates

* Allow copying from elements using `for` in `ClipboardCopy`.

    *Manuel Puyol*

### Breaking changes

* Remove `label` argument in favor of `aria-label` in `ClipboardCopy`.

    *Manuel Puyol*

### Misc

* Add autocorrect for button linters.

    *Manuel Puyol*

* Unify contributing guidelines.

    *Kate Higa*

* Rerun flaky system tests.

    *Manuel Puyol*

* Check if selector is a classify class in Utilities.

   *Jon Rohan*

## 0.0.44

### Updates

* Allow `Dropdown` menu items to be rendered outside a list.

    *Manuel Puyol*

### Breaking changes

* Require a label or `aria-label` to be provided for `AutoComplete` component.

    *Kate Higa*

* Renames:
  * `DropdownComponent` to `Dropdown`.
  * `Dropdown::MenuComponent` to `Dropdown::Menu`.
  * `Primer::ButtonMarketingComponent` to `Primer::Alpha::ButtonMarketing`.
  * `Primer::TextComponent` to `Primer::Beta::Text`.

    *Manuel Puyol*

* Removes `summary_classes` attribute in favor of the `summary` slot in `Dropdown`.

    *Manuel Puyol*

### Misc

* Replace Classify::Spacing class with pre-generated mappings.

  *Jon Rohan*

* Add linter suggestions for `Button` component.

    *Manuel Puyol*

* Sort documentation arguments.

    *Jon Rohan*

* Add validations for docs generation.

    *Manuel Puyol, Kate Higa*

* Change docs header order.

    *Manuel Puyol, Kate Higa*

* Add preliminary criteria for new `alpha` components.

    *Joel Hawksley*

## 0.0.43

### New

* Add `clearfix` and `container` system arguments.

    *Manuel Puyol*

### Updates

* Promote `TabNav` component to beta.

    *Manuel Puyol*

* Allow customizing `TabContainer` when using `TabNav` and `UnderlineNav` components.

    *Manuel Puyol*

### Breaking changes

* Restrict `col` system arguments to only accept values between 1 and 12.

    *Manuel Puyol*

### Misc

* Raise an error if `class` is used as a system argument.

    *Manuel Puyol*

* Don't commit auto-generated component previews.

    *Kate Higa*

* Provide linters for component migrations.

    *Manuel Puyol*

* Update docs to accept multiline descriptions.

    *Manuel Puyol*

* Upgrade primer/css to 17.2.1

  *Jon Rohan*

## 0.0.42

### New

* Add `font_family`, `font_style` and `text_transform` system arguments.

    *Manuel Puyol*

* Add more options for `font_size` and `font_weight`.

    *Manuel Puyol*

### Updates

* Add `align` option to the `TabNav` extra slot to allow HTML ordering.

    *Manuel Puyol*

### Misc

* Auto-generate component previews from doc examples and run integration test checks.

    *Kate Higa, Joel Hawksley*

* Configure previews controller to allow view helper usage in preview template.

    *Kate Higa*

* Only include `ViewComponent::SlotableV2` if `ViewComponent::Base` does not already include it.

    *Manuel Puyol*

* Add `force_system_arguments` option to raise an error if a class is used instead of using System Arguments.

    *Manuel Puyol*

### Breaking changes

* Restrict allowed tags for `Truncate`, `Markdown`, and `HiddenTextExpander`.

    *Kate Higa*

## 0.0.41

### New

* Create `LocalTime` component.

    *Kristján Oddsson*

* Create `Image` component.

    *Manuel Puyol*

* Add `extra` slot to `TabNav`.

    *Manuel Puyol*

* Do not raise error if Primer CSS class name is passed to component if `PRIMER_WARNINGS_DISABLED` is set.

    *Joel Hawksley*

### Accessibility

* Accept `aria-current="true"` in tabbed components.

    *Manuel Puyol*

### Changes

* Promote `Tooltip` component to beta.

    *Manuel Puyol*

### Bug fixes

* Ensure that `ClipboardCopy` behaviors only target ViewComponents.

    *Manuel Puyol*

* Ensure that the `rounded` attribute for `<image-crop>` is represented as a boolean attribute.

    *Kristján Oddsson*

### Breaking changes

* Rename `TooltipComponent` to `Tooltip`.

    *Manuel Puyol*

* Don't allow `OcticonComponent` height/width values under 16px

   *Jon Rohan*

* Remove `:large` size option from `OcticonComponent` and change `:medium` to 24px

    *Jon Rohan*

* Restrict `Label` tag to `span`, `div`, `a`, `summary`.

    *Kate Higa*

### Misc

* Add a CI check for changes to the CHANGELOG file.

    *Kristján Oddsson*

## 0.0.40

### New

* Create `ImageCrop` component.

    *Kristján Oddsson*

### Changes

* Promote `IconButton` to beta.

    *Manuel Puyol*

* Add `box` argument to `IconButton`.

    *Manuel Puyol*

* Promote `Markdown` to beta.

    *Manuel Puyol*

### Bug fixes

* Fix `IconButton` raising when `aria-label` was provided using an object.

    *Manuel Puyol*

* Fix disabling of default styles for `SpinnerComponent` via `nil` style parameter.

    *Chris Wilson*

### Deprecations

* Deprecate `Flex` in favor of `BoxComponent`.

    *Manuel Puyol*

### Breaking Changes

* Restrict `ButtonGroup` tag to `:div` and update docs for `Text` tag.

    *Kate Higa*

* Remove non-functional `width` and `height` `:fill` option.

    *Jon Rohan*, *Joel Hawksley*

* Restrict `Subhead` `heading` slot tag to `div` and `h1`-`h6`.

    *Kate Higa*

* Restrict `Blankslate` tag to `div`.

    *Kate Higa*

* Explicitly limit tag for `AvatarStack` to `:div` and `:span`.

    *Kate Higa*

* Rename `MarkdownComponent` to `Markdown`.

    *Manuel Puyol*

## 0.0.39

* Promote `CloseButton` to beta.

    *Manuel Puyol*

* Update `ClipboardCopy` to not toggle icons unless they both exist.

    *Kristján Oddsson*

* Add `icon` and `counter` slots to `ButtonComponent`.

    *Manuel Puyol*

* Create `IconButton` component.

    *Manuel Puyol*

* Removing trailing whitespace from output of `class=""` Classify generation.

    *Jon Rohan*

* Deprecate `FlexItem` in favor of `BoxComponent`.

    *Manuel Puyol*

* Dropping requirement of `octicons_helper` and updating `OcticonComponent` to use `octicon` gem directly.

    *Jon Rohan*

* **Breaking change:** Remove `:overlay` option from `border_color`.

    *Simon Luthi*

## 0.0.38

* Extract `BaseButton` component.

    *Manuel Puyol*

* Add default `aria-label` of "Close" to `CloseButton` component.

    *Kate Higa*

* Set button variants in the `ButtonGroup` parent.

    *Manuel Puyol*

* Create `ClipboardCopy` component.

    *Kristján Oddsson*

* **Breaking change:** Rename `ButtonGroupComponent` to `ButtonGroup` and promote it to beta.

    *Manuel Puyol*

* **Breaking change:** Do not provide default for `Heading` and improve documentation.

    *Kate Higa*

* **Breaking change:** Don't allow `StateComponent` to be a link.

    *Kate Higa*

## 0.0.37

* Update NPM package to include subdirectory JS files.

    *Manuel Puyol*

## 0.0.36

* Add `block` flag to `ButtonComponent`.

    *Manuel Puyol*

* Add `link` and `invisible` schemes to `ButtonComponent`.

    *Manuel Puyol*

* Create `CloseButton` and `HiddenTextExpander` component.

    *Manuel Puyol*

* **Breaking change:** Rename `AutoCompleteComponent` to `AutoComplete` and `AutoCompleteItemComponent` to `AutoComplete::Item`.

    *Manuel Puyol*

* **Breaking change:** Rename `TruncateComponent` to `Truncate` and promote it to beta.

    *Manuel Puyol*

## 0.0.35

* Promote `AutoCompleteComponent`, `AutoCompleteItemComponent`, `AvatarStackComponent` and `ButtonComponent` to beta.

    *Manuel Puyol*

* Allow `UnderlineNav` tabs to be rendered as a `<ul><li>` list.

    *Manuel Puyol*

* _Accessibility:_ Don't add tab roles when `UnderlineNav` or `TabNav` use link redirects.

    *Manuel Puyol*

* **Breaking change:** Make `label` required for `UnderlineNav` and `TabNav`.

    *Manuel Puyol*

## 0.0.34

* Add `p: :responsive` and `m: :auto` system arguments.

    *Manuel Puyol*

* Remove `my: :auto` and negative `m:` system arguments.

    *Manuel Puyol*

* **Breaking change:** Rename `FlashComponent` `variant` argument to `scheme`.

    *Manuel Puyol*

* **Breaking change:** Rename `LinkComponent` `variant` argument to `scheme`.

    *Manuel Puyol*

* **Breaking change:** Rename `ButtonComponent` `button_type` argument to `scheme`.

    *Manuel Puyol*

* **Breaking change:** Rename `ButtonMarketing` `button_type` argument to `scheme`.

    *Manuel Puyol*

* **Breaking change:** Rename `StateComponent` `color` argument to `scheme`.

    *Manuel Puyol*

## 0.0.33

* Remove `TabbedComponent` validation requiring a tab to be selected.

    *Manuel Puyol*

## 0.0.32

* Allow passing the icon name as a positional argument to `OcticonComponent`.

    *Manuel Puyol*

* Promote `TimeAgoComponent` to beta.

    *Manuel Puyol*

* **Breaking change:** Update `TabNav#tab` API to accept the tab content as a block and panel content as a slot.

    *Manuel Puyol*

* **Breaking change:** Update `UnderlineNavComponent` API be more strict and support `TabContainer`.

    *Manuel Puyol*

## 0.0.31

* Fix `Popover` bug where body was only returning the last line of the HTML.

    *Manuel Puyol, Blake Williams*

## 0.0.30

* Make `color:`, `bg:` and `border_color:` accept string values.

    *Manuel Puyol*

## 0.0.29

* Add `primer_time_ago` helper.

    *Simon Taranto*

* Add `silence_deprecations` config to supress deprecation warnings.

    *Manuel Puyol*

## 0.0.28

* Update `CounterComponent` to accept functional schemes `primary` and `secondary`. Deprecate `gray` and `light_gray` schemes.

    *Manuel Puyol*

* Add `force_functional_colors` option to convert colors to functional. This change includes a deprecation warning in non-production environments that warns about non functional color usage.

    *Manuel Puyol*

* Promote `DetailsComponent`, `HeadingComponent`, `TextComponent`, `TimelineItemComponent`, and
  `PopoverComponent` to beta status.

    *Simon Taranto*

* Update `LinkComponent`:
  * use `Link--muted` instead of `muted-link`.
  * accept `variant` and `underline` options.
  * accept `:span` as a tag.

    *Manuel Puyol*

* Add `AutoComplete` and `AutoCompleteItem` components.

    *Manuel Puyol*

* Publish types with npm package.

    *Keith Cirkel* & *Clay Miller*

* Fix `AvatarComponent` to apply classes to the link wrapper if present.

    *Steve Richert*

* Fix `AvatarComponent` to apply the `avatar-small` class rather than `avatar--small`.

    *Steve Richert*

* **Breaking change:** Updates `PopoverComponent` to use Slots V2.

    *Manuel Puyol*

## 0.0.27

* Promote `BreadcrumbComponent` and `ProgressBarComponent` to beta status.

    *Simon Taranto*

* Fix `OcticonComponent` not rendering `data-test-selector` correctly.

    *Manuel Puyol*

* Add `TimeAgo` component.

    *Keith Cirkel*

* **Breaking change:** Updates `UnderlineNavComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change:** Upgrade `LayoutComponent` to use Slots V2.

    *Simon Taranto*

## 0.0.26

* Fix `DetailsComponent` summary always being rendered as a `btn`.

    *Manuel Puyol*

* Promote `BlankslateComponent` and `BaseComponent` to beta status.

    *Simon Taranto*

## 0.0.25

* Promote `SubheadComponent` to beta.

    *Simon Taranto*

* Add deprecated `orange` and `purple` schemes to `LabelComponent`.

    *Manuel Puyol*

## 0.0.24

* Fix zeitwerk autoload integration.

    *Manuel Puyol*

* **Breaking change:** Upgrade `ProgressBarComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change:** Upgrade `BreadcrumbComponent` to use Slots V2.

    *Manuel Puyol*

## 0.0.23

* Remove node and yarn version requirements from `@primer/view-components`.

  *Manuel Puyol*

* **Breaking change:** Upgrade `SubheadComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change:** Update `LabelComponent` to use only functional color
  supportive scheme keys. The component no longer accepts colors (`:gray`, for
  example) but only functional schemes (`primary`, for example).
  `LabelComponent` is promoted to beta status.

  *Simon Taranto*

## 0.0.22

* Add view helpers to easily render Primer components.

    *Manuel Puyol*

* Add `TabContainer` and `TabNav` components.

    *Manuel Puyol*

* Promote `StateComponent` to beta.

    *Simon Taranto*

* **Breaking change:** Upgrade `BorderBoxComponent` to use Slots V2.

    *Manuel Puyol*

* **Breaking change:** Upgrade `StateComponent` to support functional colors. This change requires using [@primer/css-next](https://www.npmjs.com/package/@primer/css-next). The required changes will be upstreamed to @primer/css at a later date.

    *Simon Taranto*

* **Breaking change:** Upgrade `DetailsComponent` to use Slots V2.

    *Simon Taranto*

## 0.0.21

* **Breaking change:** Upgrade `FlashComponent` to use Slots V2.

    *Joel Hawksley, Simon Taranto*

* **Breaking change:** Upgrade `BlankslateComponent` to use Slots V2.

    *Manuel Puyol*

* **Breaking change:** Upgrade `TimelineItemComponent` to use Slots V2.

    *Manuel Puyol*

## 0.0.20

* Fix bug when empty string was passed to Classify.

    *Manuel Puyol*

## 0.0.19

* Add support for functional colors to `color` system argument.

    *Jake Shorty*

* Add `AvatarStack`, `Dropdown`, `Markdown` and `Menu` components.

    *Manuel Puyol*

* Deprecate `DropdownMenuComponent`.

    *Manuel Puyol*

* Fix `Avatar` bug when used with links.

    *Manuel Puyol*

* Add cache for common Primer values.

    *Blake Williams*

* Add support for `octicons_helper` v12.

    *Cole Bemis*

* Add support for `border: true` to apply the `border` class.

    *Simon Taranto*

* Promote `Avatar`, `Link`, and `Counter` components to beta.

    *Simon Taranto*

* **Breaking change:** Drop support for Ruby 2.4.

    *Simon Taranto*

## 0.0.18

* Add `border_radius` system argument.

    *Ash Guillaume*

* Add `animation` system argument.

    *Manuel Puyol*

* Add `Truncate`, `ButtonGroup` and `ButtonMarketing` components.

    *Manuel Puyol*

* Add `Tooltip` component.

    *Simon Taranto*

## 0.0.17

* Ensure all components support inline styles.

    *Joel Hawksley*

## 0.0.16

* Adding a `spinner` slot to the `BlankslateComponent` that uses the `SpinnerComponent` added in `0.0.10`.

    *Jon Rohan*

* Bumping node engine to version `15.x`

    *Jon Rohan*

## 0.0.15

* Add ability to disable `limit` on Counter.

    *Christian Giordano*

* Rename `v` system argument to `visibility`.

    *Joel Hawksley*

## 0.0.14

* Add functional colors to Label.

    *Joel Hawksley*

## 0.0.13

* Add support for `xl` breakpoint.

    *Joel Hawksley*

## 0.0.12

* Adds support for disabling inline box-sizing style for `SpinnerComponent` via style parameter `Primer::SpinnerComponent.new(style: nil)`.

    *Chris Wilson*

## 0.0.11

* Renames DetailsComponent::OVERLAY_DEFAULT to DetailsComponent::NO_OVERLAY to more correctly describe its value.

    *Justin Kenyon*

## 0.0.10

* Add SpinnerComponent

    *Cole Bemis*

## 0.0.9

* BREAKING CHANGE: OcticonComponent no longer accepts `class` parameter; use `classes` instead.

    *heynan0*

## 0.0.8

* Add support for border margins, such as: `border_top: 0`.

    *Natasha Umer*

* Add FlashComponent and OcticonComponent.

    *Joel Hawksley*

* BREAKING CHANGE: BlankslateComponent accepts `icon_size` instead of `icon_height`.

    *Joel Hawksley*

## 0.0.7

* Use `octicons_helper` v11.0.0.

    *Joel Hawksley*

## 0.0.6

* Updated the invalid class name error message

    *emplums*

* Updated README with testing instructions

    *emplums*

* Add large and spacious option to BlankslateComponent

    *simurai*

* Add option for `ButtonComponent` to render a `summary` tag

    *Manuel Puyol*

* BREAKING CHANGE: Changed `DetailsComponent` summary and body to be slots

    *Manuel Puyol*

## 0.0.5

* Add support for box_shadow
* Add components:
  * Popover

    *Sarah Vessels*

## 0.0.4

* Added support for mx: and my: :auto.

    *Christian Giordano*

* Added support for custom layout sizes.

    *Manuel Puyol*

## 0.0.3

* Add support for responsive `float` system argument.

    *Joel Hawksley*

* Add components:
  * Avatar
  * Blankslate

    *Manuel Puyol, Ben Emdon*

## 0.0.1

* Add initial gem configuration.

    *Manuel Puyol, Joel Hawksley*

* Add demo app and storybook to test

    *Manuel Puyol*

* Add Classify, FetchOrFallback and ClassName helpers

    *Manuel Puyol*

* Add components:
  * BorderBox
  * Box
  * Breadcrumb
  * Button
  * Counter
  * Details
  * Dropdown
  * Flex
  * FlexItem
  * Heading
  * Label
  * Layout
  * Link
  * ProgressBar
  * State
  * Subhead
  * Text
  * TimelineItem
  * UnderlineNav

    *Manuel Puyol*
