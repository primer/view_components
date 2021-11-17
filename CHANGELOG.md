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

## 0.0.61

### New

* Adding new Alpha component: `Layout` with `main` and `sidebar` slots

    *@camertron*

* Add a two-column layout linter.

    *@camertron*

* Add the `HellipButton` component

    *@artemisia-absinthium*, *@owenniblock*

### Updates

* Bump Storybook version to include Skip to Content links for keyboard auditors

    *@inkblotty*

* Update the `HiddenTextExpander` component to use the `HellipButton`.

    *@artemisia-absinthium*, *@owenniblock*

### Misc

* Fix components not rendering in Storybook because of kebab case arguments.

    *@artemisia-absinthium*, *@manuelpuyol*, *@owenniblock*

* Fix a typo on a command on the contribution page.

    *@artemisia-absinthium*, *@owenniblock*

### Bug Fixes

* Fix issue where tags were not self-closing when they are void elements

    *@owenniblock*

### Deprecations

* Deprecate `Primer::BlankslateComponent` in favor of `Primer::Beta::Blankslate`.

    *@manuelpuyol*

### Breaking Changes

* Require an `aria-label` to be provided for the `HiddenTextExpander` component.

    *@artemisia-absinthium*, *@owenniblock*

* Rename `force_system_arguments` to `raise_on_invalid_options` to better reflect its functionality

    *@owenniblock*

* Renamed `Blankslate` `title` slot to `heading`.

    *@manuelpuyol*

* Removed `Blankslate` `large` variant.

    *@manuelpuyol*

* Renamed `Blankslate` `graphic` slot to `visual`.

    *@manuelpuyol*

## 0.0.60

### Updates

* Adding new Alpha component: BorderBox Header with optional `title` slot

    *@inkblotty*

* Add note about `Breadcrumbs` not being responsive.

    *@joelhawksley*

* Handling arguments that aren't system arguments or string arguments in primer_octicon.

    *@jonrohan, @manuelpuyol*

* Improvements to the Procfile so script/dev works as expected.

    *@camertron*

* Migrating grid classes to utilities.yml process

    *@jonrohan*

* Adding new system color arguments, and deprecating old arguments.

    *@jonrohan*

* Make `Spinner` more accessible by adding `sr-only` loading text.

    *@manuelpuyol*

* Make class name validation configurable instead of relying on the Rails env.

    *@camertron*

### Bug Fixes

* Removes unwanted bottom border from active tab of `Alpha::TabNav`.

    *@theinterned*

### Breaking changes

* Add size restriction to `Avatar`.

    *@khiga8*

* Remove `square` attribute from `Avatar` in favor of `shape`. This change also affects `TimelineItem` `avatar` slot.

    *@manuelpuyol*

## 0.0.59

### Updates

* Changed `ClipboardCopy` to use `copy` instead of `paste` icon.

    *@colebemis*

### Breaking changes

* `Breadcrumbs` no longer accepts padding and font size system arguments.

    *@joelhawksley*

## 0.0.58

### Updates

* Add accessibility section to `Breadcrumbs` page.

    *@khiga8*

* Improve performance of the Classify module, i.e. `Classify.call`.

    *@camertron*

* Background arguments are now pulled in through the utilities class.

    *@jonrohan*

* Border arguments are now pulled in through the utilities class.

    *@jonrohan*

### Breaking changes

* `bg:` system argument will no longer accept hex color strings, and deprecated color scale.

    *@jonrohan*

### Bug fixes

* Fix `ClipboardCopy` octicons not toggling correctly after first click.

    *@manuelpuyol, @koddsson*

## 0.0.57

### Bug fixes

* Don't suggest empty colors for Octicons when autocorrecting.

    *@manuelpuyol*

## 0.0.56

### Updates

* `Octicon` linter will autocorrect colors.

    *@manuelpuyol*

* `Button` linter will autocorrect when button uses `href`, `name`, `value` or `tabindex`.

    *@manuelpuyol*

* `Flash` linter won't autocorrect flashes with ERB in their content.

    *@manuelpuyol*

* Eager load components.

    *@camertron*

### Misc

* Refactor some of the rubocop valid_node? logic into BaseCop class.

    *@jonrohan*

* Fix validation checker to use Utilities for color-* classes.

    *@jonrohan*

## 0.0.55

### Breaking changes

* `Primer::Breadcrumbs` requires `href`s for all items and no longer accepts the `selected` argument.

    *@joelhawksley*

* Split `TabNav` into `TabNav` and `TabPanels`.

    *@khiga8*

### New

* Use the allocation_stats gem to count object allocations in our benchmarks.
* Improve performance of Octicon cache key construction.

    *@camertron*

* Update `@primer/css` to `17.7.0` which includes a new argument for `word_break`

    *@jonrohan*

### Misc

* Clean up extra constants in `UnderlineNav`.

    *@khiga8*

## 0.0.54

### Breaking changes

* Rename `BreadcrumbComponent` to `Beta::Breadcrumbs`.

    *@joelhawksley*

* Split `UnderlineNavComponent` into `Alpha::UnderlineNav` and `Alpha::UnderlinePanels`.

    *@khiga8*

## 0.0.53

### New

* Add autocorrection to `FlashComponent` linter when the context is basic text.

    *@manuelpuyol*

### Updates

* Linters won't mark offenses when the ignore count is correct unless explicitly configured to do so.

    *@manuelpuyol*

* Deprecating background and border color presentational arguments

    *@jonrohan*

* Map the `for` argument when autofixing `ClipboardCopy` migrations.

    *@koddsson*

* Add autocorrection for `CloseButton` linter.

    *@manuelpuyol*

* Moving text color variables to Utilities class

    *@jonrohan*

### Bug fixes

* Linters won't convert HTML special elements.

    *@manuelpuyol*

### Misc

* Only run CHANGELOG CI on pull requests.

    *@manuelpuyol*

* Run CI actions on pushes to main.

    *@camertron*

* Get to 100% code coverage.

    *@camertron*

## 0.0.52

### New

* Adding `Primer::Beta::Truncate` component to reflect changes in primer/css component [Truncate](https://primer.style/css/components/truncate).

    *@jonrohan*

* Add cop to look for deprecated system arguments and suggest replacements.

    *@jonrohan*

* Add cop to use `primer_octicon` in favor of `octicon`.

    *@manuelpuyol*

* Fix release script so it doesn't loop continuously.

    *@camertron*

### Updates

* Promote `ClipboardCopy` to beta.

    *@manuelpuyol*

* PrimerOcticon linter supports `aria-` and `data-` attributes.

    *@manuelpuyol*

* Linters can:
  * convert values with ERB interpolations.
  * autocorrect cases with custom classes.

    *@manuelpuyol*

* Add a `scheme` option to `BorderBoxComponent` rows.

    *@camertron*

* Upgrade rubocop and support Ruby 3.0.

    *@camertron*

* Linters will not autocorrect cases where a required argument is missing.

    *@manuelpuyol*

### Misc

* Update benchmarks to run in every supported Ruby version.

    *@manuelpuyol*

* Add a linter generator.

    *@manuelpuyol*

## 0.0.51

### Breaking changes

* Rename `width` and `height` System Arguments to `w` and `h`, resolving conflict with HTML attribute names.

    *@manuelpuyol*

### Updates

* `SystemArgumentInsteadOfClass` linter will check for arguments in ViewHelpers.

    *@manuelpuyol*

## 0.0.50

### Updates

* Fix incorrect slots syntax in docs.

    *@joelhawksley*, *@blakewilliams*

### New

* Add linter suggestions for `CloseButton` component.

    *@manuelpuyol*

### Breaking changes

* Update to `octicons` `v15`, removing open-ended dependency. See [https://github.com/primer/octicons/releases/tag/v15.0.0] for icon name changes in release.

    *@joelhawksley*

### Updates

* Don't require `title` for `Label`.

    *@manuelpuyol*

* Improve autocorrectable linters to convert known SystemArgument classes.

    *@manuelpuyol*

* Add support for `width: :full` and `height: :full` to System Arguments.

    *@joelhawksley*

### Bug fixes

* Update linters to not autocorrect attributes with ERB blocks.

    *@manuelpuyol*

* Fix `:height` and `:width` docs to pull from Utilities

    *@jonrohan*

## 0.0.49

### New

* Add linter suggestions for `Label` component.

    *@manuelpuyol*

* Add linter suggestions for `ClipboardCopy` component.

    *@manuelpuyol*

### Updates

* Update the `Truncate` component to accept `:strong` as a tag.

    *@artemisia-absinthium*

* Improve `Primer::Classify::Utilities.classes_to_hash` performance.

    *@manuelpuyol*

### Breaking changes

* Require tab with panels to have `panel_id` so `aria-controls` can be set.

    *@khiga8*

* Renames:
  * `Primer::AvatarStackComponent` to `Primer::Beta::AvatarStack`.

    *@manuelpuyol*

### Misc

* Extract example tag parsing into helper.

    *@khiga8*

* Generate a static constant JSON and use it when defining linters.

    *@manuelpuyol*

## 0.0.48

### Breaking changes

* Ensure panels in `Navigation::Tab` have a label.

    *@khiga8*

### Misc

* Expose custom cops and default config for erblint.

    *@manuelpuyol*

* Fix double constant assign.

    *@manuelpuyol*

## 0.0.47

### Breaking changes

* Restrict tag for `Popover` to `:div` and `Popover` heading slot to headings.

    *@khiga8*

* Renames:
  * `Primer::AutoComplete` to `Primer::Beta::AutoComplete`
  * `Primer::AutoComplete::Item` to `Primer::Beta::AutoComplete::Item`
  * `Primer::AvatarComponent` to `Primer::Beta::Avatar`

    *@manuelpuyol*

### Misc

* Update `doc_examples_axe_test` to exclude non-standalone components and fix `Markdown` example.

    *@khiga8*

* Update `DetailsComponent` examples.

    *@manuelpuyol*

* Add linter to suggest system arguments instead of classes.

    *@manuelpuyol*

* Update component generator to create components in the right status module.

    *@manuelpuyol*

* Add example for truncating HTML to `Truncate`.

    *@joelhawksley*

* Update docs generation to point to the correct file sources.

    *@manuelpuyol*

* Add ENV flag to dump linter data into a file.

    *@manuelpuyol*

## 0.0.46

### Updates

* Default to matching `name` and `id` of `input`.

    *@khiga8*

* Restrict usage of padding system arguments on BorderBox, recommending use of `padding` density instead.

    *@joelhawksley*

### Breaking changes

* Restrict `TabNav`and `Tab` tags.

    *@khiga8*

* Restrict `AvatarStack` body slot tag and `ImageCrop` spinner tag.

    *@khiga8*

* Restrict `Details` body slot tags and `UnderlineNav` body slot tags.

    *@khiga8*

* Move Primer::Classify from `app/lib/` to `lib/`. This requires an extra `require "primer/classify"` statement for anywhere Classify is needed.

    *@manuelpuyol, @jonrohan*

* Restrict `Menu` heading slot tags to heading tags and require `tag` argument.

    *@khiga8*

* Adding animation, vertical_align, word_break, display, visibility, & position arguments to the utilities class. `animation: :grow` is now `animation: :hover_grow` this was a change because we changed the class name in primer.

    *@jonrohan*

### Misc

* Update contributing guidelines with release instructions.

    *@khiga8*

* Prevent flexible tag syntax with rubocop rule.

    *@khiga8*

* Update linter autocorrection to use `""` instead of `true` for boolean attributes.

    *@manuelpuyol*

* Update Storybook version.

    *@manuelpuyol*

* Add a changelog authoring guide to `CHANGELOG.md`.

    *@artemisia-absinthium*

## 0.0.45

### Updates

* Allow copying from elements using `for` in `ClipboardCopy`.

    *@manuelpuyol*

### Breaking changes

* Remove `label` argument in favor of `aria-label` in `ClipboardCopy`.

    *@manuelpuyol*

### Misc

* Add autocorrect for button linters.

    *@manuelpuyol*

* Unify contributing guidelines.

    *@khiga8*

* Rerun flaky system tests.

    *@manuelpuyol*

* Check if selector is a classify class in Utilities.

   *@jonrohan*

## 0.0.44

### Updates

* Allow `Dropdown` menu items to be rendered outside a list.

    *@manuelpuyol*

### Breaking changes

* Require a label or `aria-label` to be provided for `AutoComplete` component.

    *@khiga8*

* Renames:
  * `DropdownComponent` to `Dropdown`.
  * `Dropdown::MenuComponent` to `Dropdown::Menu`.
  * `Primer::ButtonMarketingComponent` to `Primer::Alpha::ButtonMarketing`.
  * `Primer::TextComponent` to `Primer::Beta::Text`.

    *@manuelpuyol*

* Removes `summary_classes` attribute in favor of the `summary` slot in `Dropdown`.

    *@manuelpuyol*

### Misc

* Replace Classify::Spacing class with pre-generated mappings.

  *@jonrohan*

* Add linter suggestions for `Button` component.

    *@manuelpuyol*

* Sort documentation arguments.

    *@jonrohan*

* Add validations for docs generation.

    *@manuelpuyol, @khiga8*

* Change docs header order.

    *@manuelpuyol, @khiga8*

* Add preliminary criteria for new `alpha` components.

    *@joelhawksley*

## 0.0.43

### New

* Add `clearfix` and `container` system arguments.

    *@manuelpuyol*

### Updates

* Promote `TabNav` component to beta.

    *@manuelpuyol*

* Allow customizing `TabContainer` when using `TabNav` and `UnderlineNav` components.

    *@manuelpuyol*

### Breaking changes

* Restrict `col` system arguments to only accept values between 1 and 12.

    *@manuelpuyol*

### Misc

* Raise an error if `class` is used as a system argument.

    *@manuelpuyol*

* Don't commit auto-generated component previews.

    *@khiga8*

* Provide linters for component migrations.

    *@manuelpuyol*

* Update docs to accept multiline descriptions.

    *@manuelpuyol*

* Upgrade primer/css to 17.2.1

    *@jonrohan*

## 0.0.42

### New

* Add `font_family`, `font_style` and `text_transform` system arguments.

    *@manuelpuyol*

* Add more options for `font_size` and `font_weight`.

    *@manuelpuyol*

### Updates

* Add `align` option to the `TabNav` extra slot to allow HTML ordering.

    *@manuelpuyol*

### Misc

* Auto-generate component previews from doc examples and run integration test checks.

    *@khiga8, @joelhawksley*

* Configure previews controller to allow view helper usage in preview template.

    *@khiga8*

* Only include `ViewComponent::SlotableV2` if `ViewComponent::Base` does not already include it.

    *@manuelpuyol*

* Add `force_system_arguments` option to raise an error if a class is used instead of using System Arguments.

    *@manuelpuyol*

### Breaking changes

* Restrict allowed tags for `Truncate`, `Markdown`, and `HiddenTextExpander`.

    *@khiga8*

## 0.0.41

### New

* Create `LocalTime` component.

    *@koddsson*

* Create `Image` component.

    *@manuelpuyol*

* Add `extra` slot to `TabNav`.

    *@manuelpuyol*

* Do not raise error if Primer CSS class name is passed to component if `PRIMER_WARNINGS_DISABLED` is set.

    *@joelhawksley*

### Accessibility

* Accept `aria-current="true"` in tabbed components.

    *@manuelpuyol*

### Changes

* Promote `Tooltip` component to beta.

    *@manuelpuyol*

### Bug fixes

* Ensure that `ClipboardCopy` behaviors only target ViewComponents.

    *@manuelpuyol*

* Ensure that the `rounded` attribute for `<image-crop>` is represented as a boolean attribute.

    *@koddsson*

### Breaking changes

* Rename `TooltipComponent` to `Tooltip`.

    *@manuelpuyol*

* Don't allow `OcticonComponent` height/width values under 16px

   *@jonrohan*

* Remove `:large` size option from `OcticonComponent` and change `:medium` to 24px

    *@jonrohan*

* Restrict `Label` tag to `span`, `div`, `a`, `summary`.

    *@khiga8*

### Misc

* Add a CI check for changes to the CHANGELOG file.

    *@koddsson*

## 0.0.40

### New

* Create `ImageCrop` component.

    *@koddsson*

### Changes

* Promote `IconButton` to beta.

    *@manuelpuyol*

* Add `box` argument to `IconButton`.

    *@manuelpuyol*

* Promote `Markdown` to beta.

    *@manuelpuyol*

### Bug fixes

* Fix `IconButton` raising when `aria-label` was provided using an object.

    *@manuelpuyol*

* Fix disabling of default styles for `SpinnerComponent` via `nil` style parameter.

    *@mrchrisw*

### Deprecations

* Deprecate `Flex` in favor of `BoxComponent`.

    *@manuelpuyol*

### Breaking Changes

* Restrict `ButtonGroup` tag to `:div` and update docs for `Text` tag.

    *@khiga8*

* Remove non-functional `width` and `height` `:fill` option.

    *@jonrohan*, *@joelhawksley*

* Restrict `Subhead` `heading` slot tag to `div` and `h1`-`h6`.

    *@khiga8*

* Restrict `Blankslate` tag to `div`.

    *@khiga8*

* Explicitly limit tag for `AvatarStack` to `:div` and `:span`.

    *@khiga8*

* Rename `MarkdownComponent` to `Markdown`.

    *@manuelpuyol*

## 0.0.39

* Promote `CloseButton` to beta.

    *@manuelpuyol*

* Update `ClipboardCopy` to not toggle icons unless they both exist.

    *@koddsson*

* Add `icon` and `counter` slots to `ButtonComponent`.

    *@manuelpuyol*

* Create `IconButton` component.

    *@manuelpuyol*

* Removing trailing whitespace from output of `class=""` Classify generation.

    *@jonrohan*

* Deprecate `FlexItem` in favor of `BoxComponent`.

    *@manuelpuyol*

* Dropping requirement of `octicons_helper` and updating `OcticonComponent` to use `octicon` gem directly.

    *@jonrohan*

* **Breaking change:** Remove `:overlay` option from `border_color`.

    *@@simurai*

## 0.0.38

* Extract `BaseButton` component.

    *@manuelpuyol*

* Add default `aria-label` of "Close" to `CloseButton` component.

    *@khiga8*

* Set button variants in the `ButtonGroup` parent.

    *@manuelpuyol*

* Create `ClipboardCopy` component.

    *@koddsson*

* **Breaking change:** Rename `ButtonGroupComponent` to `ButtonGroup` and promote it to beta.

    *@manuelpuyol*

* **Breaking change:** Do not provide default for `Heading` and improve documentation.

    *@khiga8*

* **Breaking change:** Don't allow `StateComponent` to be a link.

    *@khiga8*

## 0.0.37

* Update NPM package to include subdirectory JS files.

    *@manuelpuyol*

## 0.0.36

* Add `block` flag to `ButtonComponent`.

    *@manuelpuyol*

* Add `link` and `invisible` schemes to `ButtonComponent`.

    *@manuelpuyol*

* Create `CloseButton` and `HiddenTextExpander` component.

    *@manuelpuyol*

* **Breaking change:** Rename `AutoCompleteComponent` to `AutoComplete` and `AutoCompleteItemComponent` to `AutoComplete::Item`.

    *@manuelpuyol*

* **Breaking change:** Rename `TruncateComponent` to `Truncate` and promote it to beta.

    *@manuelpuyol*

## 0.0.35

* Promote `AutoCompleteComponent`, `AutoCompleteItemComponent`, `AvatarStackComponent` and `ButtonComponent` to beta.

    *@manuelpuyol*

* Allow `UnderlineNav` tabs to be rendered as a `<ul><li>` list.

    *@manuelpuyol*

* _Accessibility:_ Don't add tab roles when `UnderlineNav` or `TabNav` use link redirects.

    *@manuelpuyol*

* **Breaking change:** Make `label` required for `UnderlineNav` and `TabNav`.

    *@manuelpuyol*

## 0.0.34

* Add `p: :responsive` and `m: :auto` system arguments.

    *@manuelpuyol*

* Remove `my: :auto` and negative `m:` system arguments.

    *@manuelpuyol*

* **Breaking change:** Rename `FlashComponent` `variant` argument to `scheme`.

    *@manuelpuyol*

* **Breaking change:** Rename `LinkComponent` `variant` argument to `scheme`.

    *@manuelpuyol*

* **Breaking change:** Rename `ButtonComponent` `button_type` argument to `scheme`.

    *@manuelpuyol*

* **Breaking change:** Rename `ButtonMarketing` `button_type` argument to `scheme`.

    *@manuelpuyol*

* **Breaking change:** Rename `StateComponent` `color` argument to `scheme`.

    *@manuelpuyol*

## 0.0.33

* Remove `TabbedComponent` validation requiring a tab to be selected.

    *@manuelpuyol*

## 0.0.32

* Allow passing the icon name as a positional argument to `OcticonComponent`.

    *@manuelpuyol*

* Promote `TimeAgoComponent` to beta.

    *@manuelpuyol*

* **Breaking change:** Update `TabNav#tab` API to accept the tab content as a block and panel content as a slot.

    *@manuelpuyol*

* **Breaking change:** Update `UnderlineNavComponent` API be more strict and support `TabContainer`.

    *@manuelpuyol*

## 0.0.31

* Fix `Popover` bug where body was only returning the last line of the HTML.

    *@manuelpuyol, @blakewilliams*

## 0.0.30

* Make `color:`, `bg:` and `border_color:` accept string values.

    *@manuelpuyol*

## 0.0.29

* Add `primer_time_ago` helper.

    *@srt32*

* Add `silence_deprecations` config to supress deprecation warnings.

    *@manuelpuyol*

## 0.0.28

* Update `CounterComponent` to accept functional schemes `primary` and `secondary`. Deprecate `gray` and `light_gray` schemes.

    *@manuelpuyol*

* Add `force_functional_colors` option to convert colors to functional. This change includes a deprecation warning in non-production environments that warns about non functional color usage.

    *@manuelpuyol*

* Promote `DetailsComponent`, `HeadingComponent`, `TextComponent`, `TimelineItemComponent`, and
  `PopoverComponent` to beta status.

    *@srt32*

* Update `LinkComponent`:
  * use `Link--muted` instead of `muted-link`.
  * accept `variant` and `underline` options.
  * accept `:span` as a tag.

    *@manuelpuyol*

* Add `AutoComplete` and `AutoCompleteItem` components.

    *@manuelpuyol*

* Publish types with npm package.

    *@keithamus, @smockle*

* Fix `AvatarComponent` to apply classes to the link wrapper if present.

    *@laserlemon*

* Fix `AvatarComponent` to apply the `avatar-small` class rather than `avatar--small`.

    *@laserlemon*

* **Breaking change:** Updates `PopoverComponent` to use Slots V2.

    *@manuelpuyol*

## 0.0.27

* Promote `BreadcrumbComponent` and `ProgressBarComponent` to beta status.

    *@srt32*

* Fix `OcticonComponent` not rendering `data-test-selector` correctly.

    *@manuelpuyol*

* Add `TimeAgo` component.

    *@keithamus, **Breaking change:** Updates `UnderlineNavComponent` to use Slots V2.

    *@srt32*

* **Breaking change:** Upgrade `LayoutComponent` to use Slots V2.

    *@srt32*

## 0.0.26

* Fix `DetailsComponent` summary always being rendered as a `btn`.

    *@manuelpuyol*

* Promote `BlankslateComponent` and `BaseComponent` to beta status.

    *@srt32*

## 0.0.25

* Promote `SubheadComponent` to beta.

    *@srt32*

* Add deprecated `orange` and `purple` schemes to `LabelComponent`.

    *@manuelpuyol*

## 0.0.24

* Fix zeitwerk autoload integration.

    *@manuelpuyol*

* **Breaking change:** Upgrade `ProgressBarComponent` to use Slots V2.

    *@srt32*

* **Breaking change:** Upgrade `BreadcrumbComponent` to use Slots V2.

    *@manuelpuyol*

## 0.0.23

* Remove node and yarn version requirements from `@primer/view-components`.

  *@manuelpuyol*

* **Breaking change:** Upgrade `SubheadComponent` to use Slots V2.

    *@srt32*

* **Breaking change:** Update `LabelComponent` to use only functional color
  supportive scheme keys. The component no longer accepts colors (`:gray`, for
  example) but only functional schemes (`primary`, for example).
  `LabelComponent` is promoted to beta status.

    *@srt32*

## 0.0.22

* Add view helpers to easily render Primer components.

    *@manuelpuyol*

* Add `TabContainer` and `TabNav` components.

    *@manuelpuyol*

* Promote `StateComponent` to beta.

    *@srt32*

* **Breaking change:** Upgrade `BorderBoxComponent` to use Slots V2.

    *@manuelpuyol*

* **Breaking change:** Upgrade `StateComponent` to support functional colors. This change requires using [@primer/css-next](https://www.npmjs.com/package/@primer/css-next). The required changes will be upstreamed to @primer/css at a later date.

    *@srt32*

* **Breaking change:** Upgrade `DetailsComponent` to use Slots V2.

    *@srt32*

## 0.0.21

* **Breaking change:** Upgrade `FlashComponent` to use Slots V2.

    *@joelhawksley, @srt32*

* **Breaking change:** Upgrade `BlankslateComponent` to use Slots V2.

    *@manuelpuyol*

* **Breaking change:** Upgrade `TimelineItemComponent` to use Slots V2.

    *@manuelpuyol*

## 0.0.20

* Fix bug when empty string was passed to Classify.

    *@manuelpuyol*

## 0.0.19

* Add support for functional colors to `color` system argument.

    *@jshorty*

* Add `AvatarStack`, `Dropdown`, `Markdown` and `Menu` components.

    *@manuelpuyol*

* Deprecate `DropdownMenuComponent`.

    *@manuelpuyol*

* Fix `Avatar` bug when used with links.

    *@manuelpuyol*

* Add cache for common Primer values.

    *@blakewilliams*

* Add support for `octicons_helper` v12.

    *@colebemis*

* Add support for `border: true` to apply the `border` class.

    *@srt32*

* Promote `Avatar`, `Link`, and `Counter` components to beta.

    *@srt32*

* **Breaking change:** Drop support for Ruby 2.4.

    *@srt32*

## 0.0.18

* Add `border_radius` system argument.

    *@ashygee*

* Add `animation` system argument.

    *@manuelpuyol*

* Add `Truncate`, `ButtonGroup` and `ButtonMarketing` components.

    *@manuelpuyol*

* Add `Tooltip` component.

    *@srt32*

## 0.0.17

* Ensure all components support inline styles.

    *@joelhawksley*

## 0.0.16

* Adding a `spinner` slot to the `BlankslateComponent` that uses the `SpinnerComponent` added in `0.0.10`.

    *@jonrohan*

* Bumping node engine to version `15.x`

    *@jonrohan*

## 0.0.15

* Add ability to disable `limit` on Counter.

    *@nuthinking*

* Rename `v` system argument to `visibility`.

    *@joelhawksley*

## 0.0.14

* Add functional colors to Label.

    *@joelhawksley*

## 0.0.13

* Add support for `xl` breakpoint.

    *@joelhawksley*

## 0.0.12

* Adds support for disabling inline box-sizing style for `SpinnerComponent` via style parameter `Primer::SpinnerComponent.new(style: nil)`.

    *@mrchrisw*

## 0.0.11

* Renames DetailsComponent::OVERLAY_DEFAULT to DetailsComponent::NO_OVERLAY to more correctly describe its value.

    *@kenyonj*

## 0.0.10

* Add SpinnerComponent

    *@colebemis*

## 0.0.9

* BREAKING CHANGE: OcticonComponent no longer accepts `class` parameter; use `classes` instead.

    *@heynan0*

## 0.0.8

* Add support for border margins, such as: `border_top: 0`.

    *@natashau*

* Add FlashComponent and OcticonComponent.

    *@joelhawksley*

* BREAKING CHANGE: BlankslateComponent accepts `icon_size` instead of `icon_height`.

    *@joelhawksley*

## 0.0.7

* Use `octicons_helper` v11.0.0.

    *@joelhawksley*

## 0.0.6

* Updated the invalid class name error message

    *@emplums*

* Updated README with testing instructions

    *@emplums*

* Add large and spacious option to BlankslateComponent

    *@simurai*

* Add option for `ButtonComponent` to render a `summary` tag

    *@manuelpuyol*

* BREAKING CHANGE: Changed `DetailsComponent` summary and body to be slots

    *@manuelpuyol*

## 0.0.5

* Add support for box_shadow
* Add components:
  * Popover

    *@cheshire137*

## 0.0.4

* Added support for mx: and my: :auto.

    *@nuthinking*

* Added support for custom layout sizes.

    *@manuelpuyol*

## 0.0.3

* Add support for responsive `float` system argument.

    *@joelhawksley*

* Add components:
  * Avatar
  * Blankslate

    *@manuelpuyol, @benemdon*

## 0.0.1

* Add initial gem configuration.

    *@manuelpuyol, @joelhawksley*

* Add demo app and storybook to test

    *@manuelpuyol*

* Add Classify, FetchOrFallback and ClassName helpers

    *@manuelpuyol*

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

    *@manuelpuyol*
