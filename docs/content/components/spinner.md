---
title: Primer::SpinnerComponent
---



## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 48px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><svg width='32' height='32' viewBox='0 0 16 16' color='var(--color-icon-primary)' fill='none'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke'>    <animateTransform      attributeName='transform'      type='rotate'      from='0 8 8'      to='360 8 8'      dur='1s'      repeatCount='indefinite'    />  </path></svg></body></html>"></iframe>

```erb
<%= render(Primer::SpinnerComponent.new()) %>
```

### Small

<iframe style="width: 100%; border: 0px; height: 32px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><svg width='16' height='16' viewBox='0 0 16 16' color='var(--color-icon-primary)' fill='none'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke'>    <animateTransform      attributeName='transform'      type='rotate'      from='0 8 8'      to='360 8 8'      dur='1s'      repeatCount='indefinite'    />  </path></svg></body></html>"></iframe>

```erb
<%= render(Primer::SpinnerComponent.new(size: 16)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :-: | :- |
| size | Integer | 32 | Sets the size of the spinner |
