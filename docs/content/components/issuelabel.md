---
title: IssueLabel
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/issue_label_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use IssueLabel to add labels for issues and pull requests.

## Examples

### Schemes

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span class='IssueLabel text-white bg-blue'>Primer</span><span scheme='gray' class='IssueLabel text-white bg-red'>bug 🐛&lt;</span><span scheme='dark_gray' class='IssueLabel text-white bg-pink'>help wanted</span><span scheme='yellow' class='IssueLabel text-white bg-yellow'>🚂 deploy: train</span></body></html>"></iframe>

```erb
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue)) { "Primer" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red, scheme: :gray)) { "bug 🐛<" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink, scheme: :dark_gray)) { "help wanted" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow, scheme: :yellow)) { "🚂 deploy: train" } %>
```

### Variants

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span class='IssueLabel text-white bg-blue'>Primer</span><span scheme='gray' class='IssueLabel text-white bg-red'>bug 🐛&lt;</span><span scheme='dark_gray' class='IssueLabel text-white bg-pink'>help wanted</span><span scheme='yellow' class='IssueLabel text-white bg-yellow'>🚂 deploy: train</span></body></html>"></iframe>

```erb
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue)) { "Primer" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red, scheme: :gray)) { "bug 🐛<" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink, scheme: :dark_gray)) { "help wanted" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow, scheme: :yellow)) { "🚂 deploy: train" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `variant` | `Symbol` | `:default` | One of `:default` and `:big`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
