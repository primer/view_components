---
title: Deprecated
---

## Deprecated in v0.0.62

### LabelComponent

These `scheme` values are deprecated in favor of their functional counterpart:

| value | replacement |
| :- | :- |
| `:info` | `:accent` |
| `:warning` | `:attention` |
| `:orange` | `:severe` |
| `:purple` | `:done` |

## Deprecated in v0.0.60

### System Arguments

These color system arguments are deprecated in favor of a new system.

| argument | value | replacement |
| :- | :- | :- |
| `color:` | `:text_primary` | `:default` |
| `color:` | `:text_secondary` | `:muted` |
| `color:` | `:text_tertiary` | `:muted` |
| `color:` | `:text_link` | `:accent` |
| `color:` | `:text_success` | `:success` |
| `color:` | `:text_warning` | `:attention` |
| `color:` | `:text_danger` | `:danger` |
| `color:` | `:text_inverse` | `:on_emphasis` |
| `color:` | `:text_white` | `:on_emphasis` |
| `color:` | `:icon_primary` | `:default` |
| `color:` | `:icon_secondary` | `:muted` |
| `color:` | `:icon_tertiary` | `:muted` |
| `color:` | `:icon_info` | `:accent` |
| `color:` | `:icon_danger` | `:danger` |
| `color:` | `:icon_success` | `:success` |
| `color:` | `:icon_warning` | `:attention` |
| `bg:` | `:canvas` | `:default` |
| `bg:` | `:canvas_inverse` | `:emphasis` |
| `bg:` | `:canvas_inset` | `:inset` |
| `bg:` | `:primary` | `:default` |
| `bg:` | `:secondary` | `:subtle` |
| `bg:` | `:tertiary` | `:subtle` |
| `bg:` | `:info` | `:accent` |
| `bg:` | `:info_inverse` | `:accent_emphasis` |
| `bg:` | `:danger_inverse` | `:danger_emphasis` |
| `bg:` | `:success_inverse` | `:success_emphasis` |
| `bg:` | `:warning` | `:attention` |
| `bg:` | `:warning_inverse` | `:attention_emphasis` |
| `border_color:` | `:primary` | `:default` |
| `border_color:` | `:secondary` | `:muted` |
| `border_color:` | `:tertiary` | `:default` |
| `border_color:` | `:inverse` | `nil` |
| `border_color:` | `:info` | `:accent_emphasis` |
| `border_color:` | `:warning` | `:attention_emphasis` |

## Deprecated in v0.0.28

### System Arguments

These presentational system arguments were deprecated in favor of functional color names.

| argument | value | replacement |
| :- | :- | :- |
| `color:` | `:blue` | `:text_link` |
| `color:` | `:gray_dark` | `:text_primary` |
| `color:` | `:gray` | `:text_secondary` |
| `color:` | `:gray_light` | `:text_tertiary` |
| `color:` | `:green` | `:text_success` |
| `color:` | `:yellow` | `:text_warning` |
| `color:` | `:red` | `:text_danger` |
