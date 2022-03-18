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

### New

- Check for the `gh` CLI tool in release scripts.

    _Cameron Dutro_

### Bug Fixes

- Ensure tooltip arrow position and tooltip width is correct.

  _Kate Higa_

## 0.0.69

### New

- Add ability to attach custom CSS classes to items added to `Truncate` components.

    _Cameron Dutro_

- Add `Primer::Alpha::Tooltip` component

    _Kate Higa_, _Kristján Oddsson_

### Breaking Changes

- Module for [script/update-statuses-project.rb](script/update-statuses-project.rb) changed to `GitHub`

    _Josh Soref_

### Misc

- Spelling fixes

    _Josh Soref_

- Bump view_component in Gemfile.lock files

    _Cameron Dutro_

- Remove markdown file mistakenly checked in.

  _Kate Higa_

- Upgrade octicons to >= 17.0.0

  _Jon Rohan_

### Bug Fixes

- Fix missing @primer/components dependency.

    _Hector Garcia_

## 0.0.68

### Updates

- Add accessible labels to Search AutoComplete when provided with an icon.

    _Andri Alexandrou_

- Restricts children for AutoComplete API to prevent accessibility violations and misuse

    _Lindsey Wild_

- Migrate from Heroku to Azure for the Rails storybook server.
- Build storybook static assets into Docker image.

    _Cameron Dutro_

- Remove CSS utilities from Blankslate

    _Hector Garcia_

- Improve last example on the PopoverComponent docs

    _Hector Garcia_

### Bug Fixes

- Fix live reloading during local docs development.

    _Cameron Dutro_

- Fix sequence of content in Subhead.

    _Hector Garcia_

### Deprecations

- Deprecate `Tooltip` component.

  _Kate Higa_

### Misc

- Updates README with missing `alt` attribute on image

  _Kate Higa_

- Updates contributing docs

  _Lindsey Wild_

- Fix link in system arguments docs

  _Lukas Spieß_

## 0.0.67

- Updating octicons to `> 16`

    _Jon Rohan_

## 0.0.66

- Revert optimization changes to utilities.

  _Josh Klina_

## 0.0.65

### Breaking Changes

- Revert accessibility changes to `Spinner` introduced since 0.0.60.

  _Charlotte Dann_

### Updates

- Optimize logic for converting class names into args

    *Josh Klina*

### Deprecations

- Deprecate `variant` in favor of `size` in `ButtonComponent` and `ButtonGroup`.

  _Manuel Puyol_

### Bug Fixes

- Call `image_path` on `Primer::Image#src`.

  _Manuel Puyol_

## 0.0.64

### New

- Add `raise_on_invalid_aria` config option to silence `aria-label` errors.

  _Manuel Puyol_

### Bug Fixes

- Add missing `border: 0`, `font_size: 0` and responsive `flex` system arguments.

  _Manuel Puyol_

## 0.0.63

### Breaking Changes

- Rename `caret` argument to `dropdown` in `ButtonComponent`.

  _Manuel Puyol_

- Remove `:large` variant from `ButtonComponent`.

  _Manuel Puyol_

- Update `Spinner` to add system arguments to outermost element

  _Charlotte Dann_

### Deprecations

- Deprecate `icon` and `counter` slots in `ButtonComponent` in favor of `leading_visual` and `trailing_visual`.

  _Manuel Puyol_

### Bug Fixes

- Fix `PopoverComponent`, allowing to reset `left` and `right` positioning.

  _Manuel Puyol_

## 0.0.62

### New

- Add linter for tracking deprecated `LayoutComponent` callsites

  _Josh Klina_

- Add functional `Label` schemes: `accent`, `attention`, `severe`, `done` and `sponsors`.

  _Manuel Puyol, Simon Luthi_

- Add linter to migrate from deprecated `Label` schemes to the new ones.

  _Manuel Puyol_

### Updates

- Update `Button` to add `8px` spacing between icon, text and counter.

  _Manuel Puyol_

- Update `BlankslateApiMigration` linter to support interpolations.

  _Manuel Puyol_

- Change spacing in `Blankslate`:

  - Between `description` and `primary_action` to `32px`.
  - Between `primary_action` and `secondary_action` to `16px`.

    _Manuel Puyol_

- Improve performance of `Classify#call`.

  _Cameron Dutro_

### Breaking Changes

- Add a warning to users if they try to use `tag:` parameters on a component where the tag is fixed.

  _Owen Niblock_

- Updating to @primer/css@19.0.0 and @primer/primitives@7.1.0. Which removes support for deprecated system color arguments.

  _Jon Rohan_

- Prevent `aria-label` to be used with `:div, :span, :p` tags without an explicit `role`.

  _Manuel Puyol_

### Deprecations

- Deprecate `Label` schemes `info` and `warning` in favor of `accent` and `attention`.

  _Manuel Puyol, Simon Luthi_

## 0.0.61

### New

- Adding new Alpha component: `Layout` with `main` and `sidebar` slots

  _Cameron Dutro_

- Add a two-column layout linter.

  _Cameron Dutro_

- Add the `HellipButton` component

  _Amélia Chavot_, _Owen Niblock_

### Updates

- Bump Storybook version to include Skip to Content links for keyboard auditors.

  _Katie Foster @inkblotty_

- Update the `HiddenTextExpander` component to use the `HellipButton`.

  _Amélia Chavot_, _Owen Niblock_

### Misc

- Fix components not rendering in Storybook because of kebab case arguments.

  _Amélia Chavot_, _Manuel Puyol_, _Owen Niblock_

- Fix a typo on a command on the contribution page.

  _Amélia Chavot_, _Owen Niblock_

### Bug Fixes

- Fix issue where tags were not self-closing when they are void elements.

  _Owen Niblock_

### Deprecations

- Deprecate `Primer::BlankslateComponent` in favor of `Primer::Beta::Blankslate`.

  _Manuel Puyol_

### Breaking Changes

- Require an `aria-label` to be provided for the `HiddenTextExpander` component.

  _Amélia Chavot_, _Owen Niblock_

- Rename `force_system_arguments` to `raise_on_invalid_options` to better reflect its functionality

  _Owen Niblock_

- Renamed `Blankslate` `title` slot to `heading`.

  _Manuel Puyol_

- Removed `Blankslate` `large` variant.

  _Manuel Puyol_

- Renamed `Blankslate` `graphic` slot to `visual`.

  _Manuel Puyol_

## 0.0.60

### Updates

- Adding new Alpha component: BorderBox Header with optional `title` slot

  _Katie Foster @inkblotty_

- Add note about `Breadcrumbs` not being responsive.

  _Joel Hawksley_

- Handling arguments that aren't system arguments or string arguments in primer_octicon.

  _Jon Rohan, Manuel Puyol_

- Improvements to the Procfile so script/dev works as expected.

  _Cameron Dutro_

- Migrating grid classes to utilities.yml process

  _Jon Rohan_

- Adding new system color arguments, and deprecating old arguments.

  _Jon Rohan_

- Make `Spinner` more accessible by adding `sr-only` loading text.

  _Manuel Puyol_

- Make class name validation configurable instead of relying on the Rails env.

  _Cameron Dutro_

### Bug Fixes

- Removes unwanted bottom border from active tab of `Alpha::TabNav`.

  _Ned Schwartz_

### Breaking changes

- Add size restriction to `Avatar`.

  _Kate Higa_

- Remove `square` attribute from `Avatar` in favor of `shape`. This change also affects `TimelineItem` `avatar` slot.

  _Manuel Puyol_

## 0.0.59

### Updates

- Changed `ClipboardCopy` to use `copy` instead of `paste` icon.

  _Cole Bemis_

### Breaking changes

- `Breadcrumbs` no longer accepts padding and font size system arguments.

  _Joel Hawksley_

## 0.0.58

### Updates

- Add accessibility section to `Breadcrumbs` page.

  _Kate Higa_

- Improve performance of the Classify module, i.e. `Classify.call`.

  _Cameron Dutro_

- Background arguments are now pulled in through the utilities class.

  _Jon Rohan_

- Border arguments are now pulled in through the utilities class.

  _Jon Rohan_

### Breaking changes

- `bg:` system argument will no longer accept hex color strings, and deprecated color scale.

  _Jon Rohan_

### Bug fixes

- Fix `ClipboardCopy` octicons not toggling correctly after first click.

  _Manuel Puyol, Kristján Oddsson_

## 0.0.57

### Bug fixes

- Don't suggest empty colors for Octicons when autocorrecting.

  _Manuel Puyol_

## 0.0.56

### Updates

- `Octicon` linter will autocorrect colors.

  _Manuel Puyol_

- `Button` linter will autocorrect when button uses `href`, `name`, `value` or `tabindex`.

  _Manuel Puyol_

- `Flash` linter won't autocorrect flashes with ERB in their content.

  _Manuel Puyol_

- Eager load components.

  _Cameron Dutro_

### Misc

- Refactor some of the rubocop valid_node? logic into BaseCop class.

  _Jon Rohan_

- Fix validation checker to use Utilities for color-\* classes.

  _Jon Rohan_

## 0.0.55

### Breaking changes

- `Primer::Breadcrumbs` requires `href`s for all items and no longer accepts the `selected` argument.

  _Joel Hawksley_

- Split `TabNav` into `TabNav` and `TabPanels`.

  _Kate Higa_

### New

- Use the allocation_stats gem to count object allocations in our benchmarks.
- Improve performance of Octicon cache key construction.

  _Cameron Dutro_

- Update `@primer/css` to `17.7.0` which includes a new argument for `word_break`

  _Jon Rohan_

### Misc

- Clean up extra constants in `UnderlineNav`.

  _Kate Higa_

## 0.0.54

### Breaking changes

- Rename `BreadcrumbComponent` to `Beta::Breadcrumbs`.

  _Joel Hawksley_

- Split `UnderlineNavComponent` into `Alpha::UnderlineNav` and `Alpha::UnderlinePanels`.

  _Kate Higa_

## 0.0.53

### New

- Add autocorrection to `FlashComponent` linter when the context is basic text.

  _Manuel Puyol_

### Updates

- Linters won't mark offenses when the ignore count is correct unless explicitly configured to do so.

  _Manuel Puyol_

- Deprecating background and border color presentational arguments

  _Jon Rohan_

- Map the `for` argument when autofixing `ClipboardCopy` migrations.

  _Kristján Oddsson_

- Add autocorrection for `CloseButton` linter.

  _Manuel Puyol_

- Moving text color variables to Utilities class

  _Jon Rohan_

### Bug fixes

- Linters won't convert HTML special elements.

  _Manuel Puyol_

### Misc

- Only run CHANGELOG CI on pull requests.

  _Manuel Puyol_

- Run CI actions on pushes to main.

  _Cameron Dutro_

- Get to 100% code coverage.

  _Cameron Dutro_

## 0.0.52

### New

- Adding `Primer::Beta::Truncate` component to reflect changes in primer/css component [Truncate](https://primer.style/css/components/truncate).

  _Jon Rohan_

- Add cop to look for deprecated system arguments and suggest replacements.

  _Jon Rohan_

- Add cop to use `primer_octicon` in favor of `octicon`.

  _Manuel Puyol_

- Fix release script so it doesn't loop continuously.

  _Cameron Dutro_

### Updates

- Promote `ClipboardCopy` to beta.

  _Manuel Puyol_

- PrimerOcticon linter supports `aria-` and `data-` attributes.

  _Manuel Puyol_

- Linters can:

  - convert values with ERB interpolations.
  - autocorrect cases with custom classes.

    _Manuel Puyol_

- Add a `scheme` option to `BorderBoxComponent` rows.

  _Cameron Dutro_

- Upgrade rubocop and support Ruby 3.0.

  _Cameron Dutro_

- Linters will not autocorrect cases where a required argument is missing.

  _Manuel Puyol_

### Misc

- Update benchmarks to run in every supported Ruby version.

  _Manuel Puyol_

- Add a linter generator.

  _Manuel Puyol_

## 0.0.51

### Breaking changes

- Rename `width` and `height` System Arguments to `w` and `h`, resolving conflict with HTML attribute names.

  _Manuel Puyol_

### Updates

- `SystemArgumentInsteadOfClass` linter will check for arguments in ViewHelpers.

  _Manuel Puyol_

## 0.0.50

### Updates

- Fix incorrect slots syntax in docs.

  _Joel Hawksley_, _Blake Williams_

### New

- Add linter suggestions for `CloseButton` component.

  _Manuel Puyol_

### Breaking changes

- Update to `octicons` `v15`, removing open-ended dependency. See [https://github.com/primer/octicons/releases/tag/v15.0.0] for icon name changes in release.

  _Joel Hawksley_

### Updates

- Don't require `title` for `Label`.

  _Manuel Puyol_

- Improve autocorrectable linters to convert known SystemArgument classes.

  _Manuel Puyol_

- Add support for `width: :full` and `height: :full` to System Arguments.

  _Joel Hawksley_

### Bug fixes

- Update linters to not autocorrect attributes with ERB blocks.

  _Manuel Puyol_

- Fix `:height` and `:width` docs to pull from Utilities

  _Jon Rohan_

## 0.0.49

### New

- Add linter suggestions for `Label` component.

  _Manuel Puyol_

- Add linter suggestions for `ClipboardCopy` component.

  _Manuel Puyol_

### Updates

- Update the `Truncate` component to accept `:strong` as a tag.

  _Amélia Chavot_

- Improve `Primer::Classify::Utilities.classes_to_hash` performance.

  _Manuel Puyol_

### Breaking changes

- Require tab with panels to have `panel_id` so `aria-controls` can be set.

  _Kate Higa_

- Renames:

  - `Primer::AvatarStackComponent` to `Primer::Beta::AvatarStack`.

    _Manuel Puyol_

### Misc

- Extract example tag parsing into helper.

  _Kate Higa_

- Generate a static constant JSON and use it when defining linters.

  _Manuel Puyol_

## 0.0.48

### Breaking changes

- Ensure panels in `Navigation::Tab` have a label.

  _Kate Higa_

### Misc

- Expose custom cops and default config for erblint.

  _Manuel Puyol_

- Fix double constant assign.

  _Manuel Puyol_

## 0.0.47

### Breaking changes

- Restrict tag for `Popover` to `:div` and `Popover` heading slot to headings.

  _Kate Higa_

- Renames:

  - `Primer::AutoComplete` to `Primer::Beta::AutoComplete`
  - `Primer::AutoComplete::Item` to `Primer::Beta::AutoComplete::Item`
  - `Primer::AvatarComponent` to `Primer::Beta::Avatar`

    _Manuel Puyol_

### Misc

- Update `doc_examples_axe_test` to exclude non-standalone components and fix `Markdown` example.

  _Kate Higa_

- Update `DetailsComponent` examples.

  _Manuel Puyol_

- Add linter to suggest system arguments instead of classes.

  _Manuel Puyol_

- Update component generator to create components in the right status module.

  _Manuel Puyol_

- Add example for truncating HTML to `Truncate`.

  _Joel Hawksley_

- Update docs generation to point to the correct file sources.

  _Manuel Puyol_

- Add ENV flag to dump linter data into a file.

  _Manuel Puyol_

## 0.0.46

### Updates

- Default to matching `name` and `id` of `input`.

  _Kate Higa_

- Restrict usage of padding system arguments on BorderBox, recommending use of `padding` density instead.

  _Joel Hawksley_

### Breaking changes

- Restrict `TabNav`and `Tab` tags.

  _Kate Higa_

- Restrict `AvatarStack` body slot tag and `ImageCrop` spinner tag.

  _Kate Higa_

- Restrict `Details` body slot tags and `UnderlineNav` body slot tags.

  _Kate Higa_

- Move Primer::Classify from `app/lib/` to `lib/`. This requires an extra `require "primer/classify"` statement for anywhere Classify is needed.

  _Manuel Puyol, Jon Rohan_

- Restrict `Menu` heading slot tags to heading tags and require `tag` argument.

  _Kate Higa_

- Adding animation, vertical_align, word_break, display, visibility, & position arguments to the utilities class. `animation: :grow` is now `animation: :hover_grow` this was a change because we changed the class name in primer.

  _Jon Rohan_

### Misc

- Update contributing guidelines with release instructions.

  _Kate Higa_

- Prevent flexible tag syntax with rubocop rule.

  _Kate Higa_

- Update linter autocorrection to use `""` instead of `true` for boolean attributes.

  _Manuel Puyol_

- Update Storybook version.

  _Manuel Puyol_

- Add a changelog authoring guide to `CHANGELOG.md`.

  _Amélia Chavot_

## 0.0.45

### Updates

- Allow copying from elements using `for` in `ClipboardCopy`.

  _Manuel Puyol_

### Breaking changes

- Remove `label` argument in favor of `aria-label` in `ClipboardCopy`.

  _Manuel Puyol_

### Misc

- Add autocorrect for button linters.

  _Manuel Puyol_

- Unify contributing guidelines.

  _Kate Higa_

- Rerun flaky system tests.

  _Manuel Puyol_

- Check if selector is a classify class in Utilities.

  _Jon Rohan_

## 0.0.44

### Updates

- Allow `Dropdown` menu items to be rendered outside a list.

  _Manuel Puyol_

### Breaking changes

- Require a label or `aria-label` to be provided for `AutoComplete` component.

  _Kate Higa_

- Renames:

  - `DropdownComponent` to `Dropdown`.
  - `Dropdown::MenuComponent` to `Dropdown::Menu`.
  - `Primer::ButtonMarketingComponent` to `Primer::Alpha::ButtonMarketing`.
  - `Primer::TextComponent` to `Primer::Beta::Text`.

    _Manuel Puyol_

- Removes `summary_classes` attribute in favor of the `summary` slot in `Dropdown`.

  _Manuel Puyol_

### Misc

- Replace Classify::Spacing class with pre-generated mappings.

  _Jon Rohan_

- Add linter suggestions for `Button` component.

  _Manuel Puyol_

- Sort documentation arguments.

  _Jon Rohan_

- Add validations for docs generation.

  _Manuel Puyol, Kate Higa_

- Change docs header order.

  _Manuel Puyol, Kate Higa_

- Add preliminary criteria for new `alpha` components.

  _Joel Hawksley_

## 0.0.43

### New

- Add `clearfix` and `container` system arguments.

  _Manuel Puyol_

### Updates

- Promote `TabNav` component to beta.

  _Manuel Puyol_

- Allow customizing `TabContainer` when using `TabNav` and `UnderlineNav` components.

  _Manuel Puyol_

### Breaking changes

- Restrict `col` system arguments to only accept values between 1 and 12.

  _Manuel Puyol_

### Misc

- Raise an error if `class` is used as a system argument.

  _Manuel Puyol_

- Don't commit auto-generated component previews.

  _Kate Higa_

- Provide linters for component migrations.

  _Manuel Puyol_

- Update docs to accept multiline descriptions.

  _Manuel Puyol_

- Upgrade primer/css to 17.2.1

  _Jon Rohan_

## 0.0.42

### New

- Add `font_family`, `font_style` and `text_transform` system arguments.

  _Manuel Puyol_

- Add more options for `font_size` and `font_weight`.

  _Manuel Puyol_

### Updates

- Add `align` option to the `TabNav` extra slot to allow HTML ordering.

  _Manuel Puyol_

### Misc

- Auto-generate component previews from doc examples and run integration test checks.

  _Kate Higa, Joel Hawksley_

- Configure previews controller to allow view helper usage in preview template.

  _Kate Higa_

- Only include `ViewComponent::SlotableV2` if `ViewComponent::Base` does not already include it.

  _Manuel Puyol_

- Add `force_system_arguments` option to raise an error if a class is used instead of using System Arguments.

  _Manuel Puyol_

### Breaking changes

- Restrict allowed tags for `Truncate`, `Markdown`, and `HiddenTextExpander`.

  _Kate Higa_

## 0.0.41

### New

- Create `LocalTime` component.

  _Kristján Oddsson_

- Create `Image` component.

  _Manuel Puyol_

- Add `extra` slot to `TabNav`.

  _Manuel Puyol_

- Do not raise error if Primer CSS class name is passed to component if `PRIMER_WARNINGS_DISABLED` is set.

  _Joel Hawksley_

### Accessibility

- Accept `aria-current="true"` in tabbed components.

  _Manuel Puyol_

### Changes

- Promote `Tooltip` component to beta.

  _Manuel Puyol_

### Bug fixes

- Ensure that `ClipboardCopy` behaviors only target ViewComponents.

  _Manuel Puyol_

- Ensure that the `rounded` attribute for `<image-crop>` is represented as a boolean attribute.

  _Kristján Oddsson_

### Breaking changes

- Rename `TooltipComponent` to `Tooltip`.

  _Manuel Puyol_

- Don't allow `OcticonComponent` height/width values under 16px

  _Jon Rohan_

- Remove `:large` size option from `OcticonComponent` and change `:medium` to 24px

  _Jon Rohan_

- Restrict `Label` tag to `span`, `div`, `a`, `summary`.

  _Kate Higa_

### Misc

- Add a CI check for changes to the CHANGELOG file.

  _Kristján Oddsson_

## 0.0.40

### New

- Create `ImageCrop` component.

  _Kristján Oddsson_

### Changes

- Promote `IconButton` to beta.

  _Manuel Puyol_

- Add `box` argument to `IconButton`.

  _Manuel Puyol_

- Promote `Markdown` to beta.

  _Manuel Puyol_

### Bug fixes

- Fix `IconButton` raising when `aria-label` was provided using an object.

  _Manuel Puyol_

- Fix disabling of default styles for `SpinnerComponent` via `nil` style parameter.

  _Chris Wilson_

### Deprecations

- Deprecate `Flex` in favor of `BoxComponent`.

  _Manuel Puyol_

### Breaking Changes

- Restrict `ButtonGroup` tag to `:div` and update docs for `Text` tag.

  _Kate Higa_

- Remove non-functional `width` and `height` `:fill` option.

  _Jon Rohan_, _Joel Hawksley_

- Restrict `Subhead` `heading` slot tag to `div` and `h1`-`h6`.

  _Kate Higa_

- Restrict `Blankslate` tag to `div`.

  _Kate Higa_

- Explicitly limit tag for `AvatarStack` to `:div` and `:span`.

  _Kate Higa_

- Rename `MarkdownComponent` to `Markdown`.

  _Manuel Puyol_

## 0.0.39

- Promote `CloseButton` to beta.

  _Manuel Puyol_

- Update `ClipboardCopy` to not toggle icons unless they both exist.

  _Kristján Oddsson_

- Add `icon` and `counter` slots to `ButtonComponent`.

  _Manuel Puyol_

- Create `IconButton` component.

  _Manuel Puyol_

- Removing trailing whitespace from output of `class=""` Classify generation.

  _Jon Rohan_

- Deprecate `FlexItem` in favor of `BoxComponent`.

  _Manuel Puyol_

- Dropping requirement of `octicons_helper` and updating `OcticonComponent` to use `octicon` gem directly.

  _Jon Rohan_

- **Breaking change:** Remove `:overlay` option from `border_color`.

  _Simon Luthi_

## 0.0.38

- Extract `BaseButton` component.

  _Manuel Puyol_

- Add default `aria-label` of "Close" to `CloseButton` component.

  _Kate Higa_

- Set button variants in the `ButtonGroup` parent.

  _Manuel Puyol_

- Create `ClipboardCopy` component.

  _Kristján Oddsson_

- **Breaking change:** Rename `ButtonGroupComponent` to `ButtonGroup` and promote it to beta.

  _Manuel Puyol_

- **Breaking change:** Do not provide default for `Heading` and improve documentation.

  _Kate Higa_

- **Breaking change:** Don't allow `StateComponent` to be a link.

  _Kate Higa_

## 0.0.37

- Update NPM package to include subdirectory JS files.

  _Manuel Puyol_

## 0.0.36

- Add `block` flag to `ButtonComponent`.

  _Manuel Puyol_

- Add `link` and `invisible` schemes to `ButtonComponent`.

  _Manuel Puyol_

- Create `CloseButton` and `HiddenTextExpander` component.

  _Manuel Puyol_

- **Breaking change:** Rename `AutoCompleteComponent` to `AutoComplete` and `AutoCompleteItemComponent` to `AutoComplete::Item`.

  _Manuel Puyol_

- **Breaking change:** Rename `TruncateComponent` to `Truncate` and promote it to beta.

  _Manuel Puyol_

## 0.0.35

- Promote `AutoCompleteComponent`, `AutoCompleteItemComponent`, `AvatarStackComponent` and `ButtonComponent` to beta.

  _Manuel Puyol_

- Allow `UnderlineNav` tabs to be rendered as a `<ul><li>` list.

  _Manuel Puyol_

- _Accessibility:_ Don't add tab roles when `UnderlineNav` or `TabNav` use link redirects.

  _Manuel Puyol_

- **Breaking change:** Make `label` required for `UnderlineNav` and `TabNav`.

  _Manuel Puyol_

## 0.0.34

- Add `p: :responsive` and `m: :auto` system arguments.

  _Manuel Puyol_

- Remove `my: :auto` and negative `m:` system arguments.

  _Manuel Puyol_

- **Breaking change:** Rename `FlashComponent` `variant` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `LinkComponent` `variant` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `ButtonComponent` `button_type` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `ButtonMarketing` `button_type` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `StateComponent` `color` argument to `scheme`.

  _Manuel Puyol_

## 0.0.33

- Remove `TabbedComponent` validation requiring a tab to be selected.

  _Manuel Puyol_

## 0.0.32

- Allow passing the icon name as a positional argument to `OcticonComponent`.

  _Manuel Puyol_

- Promote `TimeAgoComponent` to beta.

  _Manuel Puyol_

- **Breaking change:** Update `TabNav#tab` API to accept the tab content as a block and panel content as a slot.

  _Manuel Puyol_

- **Breaking change:** Update `UnderlineNavComponent` API be more strict and support `TabContainer`.

  _Manuel Puyol_

## 0.0.31

- Fix `Popover` bug where body was only returning the last line of the HTML.

  _Manuel Puyol, Blake Williams_

## 0.0.30

- Make `color:`, `bg:` and `border_color:` accept string values.

  _Manuel Puyol_

## 0.0.29

- Add `primer_time_ago` helper.

  _Simon Taranto_

- Add `silence_deprecations` config to suppress deprecation warnings.

  _Manuel Puyol_

## 0.0.28

- Update `CounterComponent` to accept functional schemes `primary` and `secondary`. Deprecate `gray` and `light_gray` schemes.

  _Manuel Puyol_

- Add `force_functional_colors` option to convert colors to functional. This change includes a deprecation warning in non-production environments that warns about non functional color usage.

  _Manuel Puyol_

- Promote `DetailsComponent`, `HeadingComponent`, `TextComponent`, `TimelineItemComponent`, and
  `PopoverComponent` to beta status.

  _Simon Taranto_

- Update `LinkComponent`:

  - use `Link--muted` instead of `muted-link`.
  - accept `variant` and `underline` options.
  - accept `:span` as a tag.

    _Manuel Puyol_

- Add `AutoComplete` and `AutoCompleteItem` components.

  _Manuel Puyol_

- Publish types with npm package.

  _Keith Cirkel_ & _Clay Miller_

- Fix `AvatarComponent` to apply classes to the link wrapper if present.

  _Steve Richert_

- Fix `AvatarComponent` to apply the `avatar-small` class rather than `avatar--small`.

  _Steve Richert_

- **Breaking change:** Updates `PopoverComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.27

- Promote `BreadcrumbComponent` and `ProgressBarComponent` to beta status.

  _Simon Taranto_

- Fix `OcticonComponent` not rendering `data-test-selector` correctly.

  _Manuel Puyol_

- Add `TimeAgo` component.

  _Keith Cirkel_

- **Breaking change:** Updates `UnderlineNavComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Upgrade `LayoutComponent` to use Slots V2.

  _Simon Taranto_

## 0.0.26

- Fix `DetailsComponent` summary always being rendered as a `btn`.

  _Manuel Puyol_

- Promote `BlankslateComponent` and `BaseComponent` to beta status.

  _Simon Taranto_

## 0.0.25

- Promote `SubheadComponent` to beta.

  _Simon Taranto_

- Add deprecated `orange` and `purple` schemes to `LabelComponent`.

  _Manuel Puyol_

## 0.0.24

- Fix zeitwerk autoload integration.

  _Manuel Puyol_

- **Breaking change:** Upgrade `ProgressBarComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Upgrade `BreadcrumbComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.23

- Remove node and yarn version requirements from `@primer/view-components`.

  _Manuel Puyol_

- **Breaking change:** Upgrade `SubheadComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Update `LabelComponent` to use only functional color
  supportive scheme keys. The component no longer accepts colors (`:gray`, for
  example) but only functional schemes (`primary`, for example).
  `LabelComponent` is promoted to beta status.

  _Simon Taranto_

## 0.0.22

- Add view helpers to easily render Primer components.

  _Manuel Puyol_

- Add `TabContainer` and `TabNav` components.

  _Manuel Puyol_

- Promote `StateComponent` to beta.

  _Simon Taranto_

- **Breaking change:** Upgrade `BorderBoxComponent` to use Slots V2.

  _Manuel Puyol_

- **Breaking change:** Upgrade `StateComponent` to support functional colors. This change requires using [@primer/css-next](https://www.npmjs.com/package/@primer/css-next). The required changes will be upstreamed to @primer/css at a later date.

  _Simon Taranto_

- **Breaking change:** Upgrade `DetailsComponent` to use Slots V2.

  _Simon Taranto_

## 0.0.21

- **Breaking change:** Upgrade `FlashComponent` to use Slots V2.

  _Joel Hawksley, Simon Taranto_

- **Breaking change:** Upgrade `BlankslateComponent` to use Slots V2.

  _Manuel Puyol_

- **Breaking change:** Upgrade `TimelineItemComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.20

- Fix bug when empty string was passed to Classify.

  _Manuel Puyol_

## 0.0.19

- Add support for functional colors to `color` system argument.

  _Jake Shorty_

- Add `AvatarStack`, `Dropdown`, `Markdown` and `Menu` components.

  _Manuel Puyol_

- Deprecate `DropdownMenuComponent`.

  _Manuel Puyol_

- Fix `Avatar` bug when used with links.

  _Manuel Puyol_

- Add cache for common Primer values.

  _Blake Williams_

- Add support for `octicons_helper` v12.

  _Cole Bemis_

- Add support for `border: true` to apply the `border` class.

  _Simon Taranto_

- Promote `Avatar`, `Link`, and `Counter` components to beta.

  _Simon Taranto_

- **Breaking change:** Drop support for Ruby 2.4.

  _Simon Taranto_

## 0.0.18

- Add `border_radius` system argument.

  _Ash Guillaume_

- Add `animation` system argument.

  _Manuel Puyol_

- Add `Truncate`, `ButtonGroup` and `ButtonMarketing` components.

  _Manuel Puyol_

- Add `Tooltip` component.

  _Simon Taranto_

## 0.0.17

- Ensure all components support inline styles.

  _Joel Hawksley_

## 0.0.16

- Adding a `spinner` slot to the `BlankslateComponent` that uses the `SpinnerComponent` added in `0.0.10`.

  _Jon Rohan_

- Bumping node engine to version `15.x`

  _Jon Rohan_

## 0.0.15

- Add ability to disable `limit` on Counter.

  _Christian Giordano_

- Rename `v` system argument to `visibility`.

  _Joel Hawksley_

## 0.0.14

- Add functional colors to Label.

  _Joel Hawksley_

## 0.0.13

- Add support for `xl` breakpoint.

  _Joel Hawksley_

## 0.0.12

- Adds support for disabling inline box-sizing style for `SpinnerComponent` via style parameter `Primer::SpinnerComponent.new(style: nil)`.

  _Chris Wilson_

## 0.0.11

- Renames DetailsComponent::OVERLAY_DEFAULT to DetailsComponent::NO_OVERLAY to more correctly describe its value.

  _Justin Kenyon_

## 0.0.10

- Add SpinnerComponent

  _Cole Bemis_

## 0.0.9

- BREAKING CHANGE: OcticonComponent no longer accepts `class` parameter; use `classes` instead.

  _heynan0_

## 0.0.8

- Add support for border margins, such as: `border_top: 0`.

  _Natasha Umer_

- Add FlashComponent and OcticonComponent.

  _Joel Hawksley_

- BREAKING CHANGE: BlankslateComponent accepts `icon_size` instead of `icon_height`.

  _Joel Hawksley_

## 0.0.7

- Use `octicons_helper` v11.0.0.

  _Joel Hawksley_

## 0.0.6

- Updated the invalid class name error message

  _emplums_

- Updated README with testing instructions

  _emplums_

- Add large and spacious option to BlankslateComponent

  _simurai_

- Add option for `ButtonComponent` to render a `summary` tag

  _Manuel Puyol_

- BREAKING CHANGE: Changed `DetailsComponent` summary and body to be slots

  _Manuel Puyol_

## 0.0.5

- Add support for box_shadow
- Add components:

  - Popover

    _Sarah Vessels_

## 0.0.4

- Added support for mx: and my: :auto.

  _Christian Giordano_

- Added support for custom layout sizes.

  _Manuel Puyol_

## 0.0.3

- Add support for responsive `float` system argument.

  _Joel Hawksley_

- Add components:

  - Avatar
  - Blankslate

    _Manuel Puyol, Ben Emdon_

## 0.0.1

- Add initial gem configuration.

  _Manuel Puyol, Joel Hawksley_

- Add demo app and storybook to test

  _Manuel Puyol_

- Add Classify, FetchOrFallback and ClassName helpers

  _Manuel Puyol_

- Add components:

  - BorderBox
  - Box
  - Breadcrumb
  - Button
  - Counter
  - Details
  - Dropdown
  - Flex
  - FlexItem
  - Heading
  - Label
  - Layout
  - Link
  - ProgressBar
  - State
  - Subhead
  - Text
  - TimelineItem
  - UnderlineNav

    _Manuel Puyol_
