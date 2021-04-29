---
title: ImageCrop
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/image_crop.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-image-crop-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

A client-side mechanism to crop images.

## Examples

### Simple cropper

<Example src="<image-crop src='https://github.com/koddsson.png' rounded='true'>    <svg data-loading-slot='true' style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='64' height='64' class='flex-1 anim-rotate'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg>  <input type='hidden' data-image-crop-input='x' name='cropped_x'>  <input type='hidden' data-image-crop-input='y' name='cropped_y'>  <input type='hidden' data-image-crop-input='width' name='cropped_width'>  <input type='hidden' data-image-crop-input='height' name='cropped_height'></image-crop>" />

```erb
<%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png")) %>
```

### Square cropper

<Example src="<image-crop src='https://github.com/koddsson.png' rounded='false'>    <svg data-loading-slot='true' style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='64' height='64' class='flex-1 anim-rotate'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg>  <input type='hidden' data-image-crop-input='x' name='cropped_x'>  <input type='hidden' data-image-crop-input='y' name='cropped_y'>  <input type='hidden' data-image-crop-input='width' name='cropped_width'>  <input type='hidden' data-image-crop-input='height' name='cropped_height'></image-crop>" />

```erb
<%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png", rounded: false)) %>
```

### Cropper with a custom loader

<Example src="<image-crop src='https://github.com/koddsson.png' rounded='false'>    <img style='width: 120px' src='spinner.gif' data-loading-slot='true'></img>  <input type='hidden' data-image-crop-input='x' name='cropped_x'>  <input type='hidden' data-image-crop-input='y' name='cropped_y'>  <input type='hidden' data-image-crop-input='width' name='cropped_width'>  <input type='hidden' data-image-crop-input='height' name='cropped_height'></image-crop>" />

```erb
<%= render(Primer::ImageCrop.new(src: "https://github.com/koddsson.png", rounded: false)) do |cropper| %>
  <% cropper.loading(style: "width: 120px", tag: :img, src: "spinner.gif") %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The path of the image to crop. |
| `rounded` | `Boolean` | `true` | If the crop mask should be a circle. Defaults to true. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Loading`

A loading indicator that is shown while the image is loading.
