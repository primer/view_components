---
title: Heading
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/heading_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-heading-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Heading` can be used to communicate page organization and hierarchy.

- Set tag to one of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, `:h6` based on what is
  appropriate for the page context.
- Use `Heading` as the title of a section or sub section.
- Do not use `Heading` for styling alone. To style text without conveying heading semantics,
  consider using [Text](/components/text) with relevant [Typography](/system-arguments#typography).
- Do not jump heading levels. For instance, do not follow a `<h1>` with an `<h3>`. Heading levels should
  increase by one in ascending order.

## Accessibility

Headings convey semantic meaning. Assistive technology users rely on headings to quickly navigate and scan information on a page.
Inappropriate use of headings can lead to a confusing experience.
[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## Examples

### Default

<Example src="<h1>H1 Text</h1><h2>H2 Text</h2><h3>H3 Text</h3><h4>H4 Text</h4><h5>H5 Text</h5><h6>H6 Text</h6>" />

```erb
<%= render(Primer::HeadingComponent.new(tag: :h1)) { "H1 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h2)) { "H2 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h3)) { "H3 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h4)) { "H4 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h5)) { "H5 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h6)) { "H6 Text" } %>
```

### With `font_size`

<Example src="<h1 class='f6'>h1 tag, font_size 6</h1><h2 class='f3'>h2 tag, font_size 3</h2><h3 class='f2'>h3 tag, font_size 2</h3><h4 class='f0'>h4 tag, font_size 0</h4><h5 class='f1'>h5 tag, font_size 1</h5><h6 class='f4'>h6 tag, font_size 4</h6>" />

```erb
<%= render(Primer::HeadingComponent.new(tag: :h1, font_size: 6)) { "h1 tag, font_size 6" } %>
<%= render(Primer::HeadingComponent.new(tag: :h2, font_size: 3)) { "h2 tag, font_size 3" } %>
<%= render(Primer::HeadingComponent.new(tag: :h3, font_size: 2)) { "h3 tag, font_size 2" } %>
<%= render(Primer::HeadingComponent.new(tag: :h4, font_size: 0)) { "h4 tag, font_size 0" } %>
<%= render(Primer::HeadingComponent.new(tag: :h5, font_size: 1)) { "h5 tag, font_size 1" } %>
<%= render(Primer::HeadingComponent.new(tag: :h6, font_size: 4)) { "h6 tag, font_size 4" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `String` | N/A | One of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, or `:h6`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
