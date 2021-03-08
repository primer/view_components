# CHANGELOG

## main

* Add `force_functional_colors` option to convert colors to functional.

    *Manuel Puyol*

## 0.0.27

* Promote `BreadcrumbComponent` and `ProgressBarComponent` to beta status.

    *Simon Taranto*

* Fix `OcticonComponent` not rendering `data-test-selector` correctly.

    *Manuel Puyol*

* Add `TimeAgo` component.

    *Keith Cirkel*

* **Breaking change**: Updates `UnderlineNavComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change**: Upgrade `LayoutComponent` to use Slots V2.

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

* **Breaking change**: Upgrade `ProgressBarComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change**: Upgrade `BreadcrumbComponent` to use Slots V2.

    *Manuel Puyol*

## 0.0.23

* Remove node and yarn version requirements from `@primer/view-components`.

  *Manuel Puyol*

* **Breaking change**: Upgrade `SubheadComponent` to use Slots V2.

    *Simon Taranto*

* **Breaking change**: Update `LabelComponent` to use only functional color
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

* **Breaking change**: Upgrade `BorderBoxComponent` to use Slots V2.

    *Manuel Puyol*

* **Breaking change**: Upgrade `StateComponent` to support functional colors. This change requires using [@primer/css-next](https://www.npmjs.com/package/@primer/css-next). The required changes will be upstreamed to @primer/css at a later date.

    *Simon Taranto*

* **Breaking change**: Upgrade `DetailsComponent` to use Slots V2.

    *Simon Taranto*

## 0.0.21

* **Breaking change**: Upgrade `FlashComponent` to use Slots V2.

    *Joel Hawksley, Simon Taranto*

* **Breaking change**: Upgrade `BlankslateComponent` to use Slots V2.

    *Manuel Puyol*

* **Breaking change**: Upgrade `TimelineItemComponent` to use Slots V2.

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

* **Breaking change**: Drop support for Ruby 2.4.

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
