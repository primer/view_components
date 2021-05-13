---
title: Image
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/image.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-image-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Image` to render images.

## Accessibility

Always provide a meaningful `alt` for your images.

## Examples

### Default

<Example src="<img src='https://github.com/github.png' alt='GitHub' loading='eager'></img>" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub")) %>
```

### Lazy loading

<Example src="<img src='https://github.com/github.png' alt='GitHub' loading='lazy'></img>" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", loading: :lazy)) %>
```

### Custom size

<Example src="<img src='https://github.com/github.png' alt='GitHub' loading='eager' height='100' width='100'></img>" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", height: 100, width: 100)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
