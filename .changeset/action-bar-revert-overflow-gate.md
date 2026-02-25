---
"@primer/view-components": patch
---

Revert two behavioral regressions in `ActionBarElement` introduced by a previous performance improvement:

1. Always set `overflow: visible` in `connectedCallback` (remove the popover feature-detection gate that was silently skipping this style in modern browsers).
2. Make the rAF coalescing scheduler private — `update()` is now the public coalescing entry point and `#performUpdate()` contains the actual layout work, removing the previously-public `scheduleUpdate()` method.
