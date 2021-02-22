---
title: Spinner
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/spinner_component.rb
storybook: https://primer-view-components.herokuapp.com/?path=/story/primer-spinner-component
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Primer::SpinnerComponent to let users know that content is being loaded.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><svg style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='32' height='32'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke'>    <animateTransform attributeName='transform' type='rotate' from='0 8 8' to='360 8 8' dur='1s' repeatCount='indefinite' />  </path></svg></body></html>"></iframe>

```erb
<%= render(Primer::SpinnerComponent.new) %>
```

### Small

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><svg style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='16' height='16'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke'>    <animateTransform attributeName='transform' type='rotate' from='0 8 8' to='360 8 8' dur='1s' repeatCount='indefinite' />  </path></svg></body></html>"></iframe>

```erb
<%= render(Primer::SpinnerComponent.new(size: :small)) %>
```

### Large

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><svg style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='64' height='64'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke'>    <animateTransform attributeName='transform' type='rotate' from='0 8 8' to='360 8 8' dur='1s' repeatCount='indefinite' />  </path></svg></body></html>"></iframe>

```erb
<%= render(Primer::SpinnerComponent.new(size: :large)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `size` | `Symbol` | `:medium` | One of `:small` (`16`), `:medium` (`32`), or `:large` (`64`). |
