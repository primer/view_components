---
title: Spinner
componentId: spinner
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/spinner_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-spinner-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Spinner` to let users know that content is being loaded.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `size` | `Symbol` | `:medium` | One of `[:large, 64]`, `[:medium, 32]`, or `[:small, 16]`. |
| `style` | `String` | `box-sizing: content-box; color: var(--color-icon-primary);` | Custom element styles. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<span role='status' style='box-sizing: content-box; color: var(--color-icon-primary);' data-view-component='true'>  <span class='sr-only'>Loading</span>  <svg viewBox='0 0 16 16' fill='none' width='32' height='32' data-view-component='true' class='anim-rotate v-align-bottom'>    <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />    <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg></span>" />

```erb
<%= render(Primer::SpinnerComponent.new) %>
```

### Small

<Example src="<span role='status' style='box-sizing: content-box; color: var(--color-icon-primary);' data-view-component='true'>  <span class='sr-only'>Loading</span>  <svg viewBox='0 0 16 16' fill='none' width='16' height='16' data-view-component='true' class='anim-rotate v-align-bottom'>    <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />    <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg></span>" />

```erb
<%= render(Primer::SpinnerComponent.new(size: :small)) %>
```

### Large

<Example src="<span role='status' style='box-sizing: content-box; color: var(--color-icon-primary);' data-view-component='true'>  <span class='sr-only'>Loading</span>  <svg viewBox='0 0 16 16' fill='none' width='64' height='64' data-view-component='true' class='anim-rotate v-align-bottom'>    <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />    <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg></span>" />

```erb
<%= render(Primer::SpinnerComponent.new(size: :large)) %>
```
