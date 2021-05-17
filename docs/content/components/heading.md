---
title: Heading
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/heading_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-heading-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Heading` should be used to communicate page organization and hierarchy.

- Set tag to one of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, `:h6` based on what is appropriate for the page context.
- Use `Heading` as the title of a section or sub section.
- Do not use `Heading` for styling alone. For simply styling text, consider using [Text](/components/text) with relevant [Typography](/system-arguments#typography)
  such as `font_size` and `font_weight`.
- Do not jump heading levels. For instance, do not follow a `<h1>` with an `<h3>`. Heading levels should increase by one in ascending order.

## Accessibility

While sighted users rely on visual cues such as font size changes to determine what the heading is, assistive technology users rely on programatic cues that can be read out.
When text on a page is visually implied to be a heading, ensure that it is coded as a heading. Additionally, visually implied heading level and coded heading level should be
consistent. [See WCAG success criteria: 1.3.1: Info and Relationships](https://www.w3.org/WAI/WCAG21/Understanding/info-and-relationships.html)

Headings allow assistive technology users to quickly navigate around a page. Navigation to text that is not meant to be a heading can be a confusing experience.
[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## Examples

### Default

<Example src="<h1 data-view-component='true'>H1 Text</h1><h2 data-view-component='true'>H2 Text</h2><h3 data-view-component='true'>H3 Text</h3><h4 data-view-component='true'>H4 Text</h4><h5 data-view-component='true'>H5 Text</h5><h6 data-view-component='true'>H6 Text</h6>" />

```erb
<%= render(Primer::HeadingComponent.new(tag: :h1)) { "H1 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h2)) { "H2 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h3)) { "H3 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h4)) { "H4 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h5)) { "H5 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h6)) { "H6 Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `String` | N/A | One of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, or `:h6`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
