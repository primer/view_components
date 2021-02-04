---
title: Flex
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use FlexComponent to make an element lay out its content using the flexbox model.
Before using these utilities, you should be familiar with CSS3 Flexible Box
spec. If you are not, check out MDN's guide  [Using CSS Flexible
Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox).

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `justify_content` | `Symbol` | `JUSTIFY_CONTENT_DEFAULT` | Use this param to distribute space between and around flex items along the main axis of the container One of `nil`, `:flex_start`, `:flex_end`, `:center`, `:space_between`, or `:space_around`. |
| `inline` | `Boolean` | `false` | Defaults to false. |
| `flex_wrap` | `Boolean` | `FLEX_WRAP_DEFAULT` | Defaults to nil |
| `align_items` | `Symbol` | `ALIGN_ITEMS_DEFAULT` | Use this param to align items on the cross axis One of `nil`, `:start`, `:end`, `:center`, `:baseline`, or `:stretch`. |
| `direction` | `Symbol` | `nil` | Use this param to define the orientation of the main axis (row or column). By default, flex items will display in a row. One of `nil`, `:column`, `:column_reverse`, `:row`, or `:row_reverse`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
