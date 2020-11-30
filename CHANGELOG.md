# CHANGELOG

## main

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
