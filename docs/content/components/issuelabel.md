---
title: IssueLabel
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/issue_label_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use IssueLabel to add labels for issues and pull requests.

## Examples

### Schemes

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span class='IssueLabel text-white bg-blue'>Primer</span><span class='IssueLabel text-white bg-red'>bug 🐛&lt;</span><span class='IssueLabel text-white bg-pink'>help wanted</span><span class='IssueLabel text-white bg-yellow'>🚂 deploy: train</span></body></html>"></iframe>

```erb
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue)) { "Primer" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red)) { "bug 🐛<" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink)) { "help wanted" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow)) { "🚂 deploy: train" } %>
```

### Big variant

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span class='IssueLabel IssueLabel--big text-white bg-blue'>Primer</span><span class='IssueLabel IssueLabel--big text-white bg-red'>bug 🐛&lt;</span><span class='IssueLabel IssueLabel--big text-white bg-pink'>help wanted</span><span class='IssueLabel IssueLabel--big text-white bg-yellow'>🚂 deploy: train</span></body></html>"></iframe>

```erb
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :blue, variant: :big)) { "Primer" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :red, variant: :big)) { "bug 🐛<" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :pink, variant: :big)) { "help wanted" } %>
<%= render(Primer::IssueLabelComponent.new(text: :white, bg: :yellow, variant: :big)) { "🚂 deploy: train" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `variant` | `Symbol` | `:default` | One of `:default` and `:big`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
