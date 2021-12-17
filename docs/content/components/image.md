---
title: Image
componentId: image
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/image.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-image
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Image` to render images.

## Accessibility

Always provide a meaningful `alt`.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The source url of the image. |
| `alt` | `String` | N/A | Specifies an alternate text for the image. |
| `lazy` | `Boolean` | `false` | Whether or not to lazily load the image. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<img src='https://github.com/github.png' alt='GitHub' data-view-component='true' />" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub")) %>
```

### Helper

<Example src="<img src='https://github.com/github.png' alt='GitHub' data-view-component='true' />" />

```erb

<%= primer_image(src: "https://github.com/github.png", alt: "GitHub") %>
```

### Lazy loading

<Example src="<img src='https://github.com/github.png' alt='GitHub' loading='lazy' decoding='async' data-view-component='true' />" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", lazy: true)) %>
```

### Custom size

<Example src="<img src='https://github.com/github.png' height='100' width='100' alt='GitHub' data-view-component='true' />" />

```erb

<%= render(Primer::Image.new(src: "https://github.com/github.png", alt: "GitHub", height: 100, width: 100)) %>
```
