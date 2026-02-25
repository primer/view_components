---
"@primer/view-components": patch
---

Performance improvements to `ActionBarElement`:

- Replaced the `#eachItem` / `ItemType` abstraction with a two-pass read-then-write loop that snapshots all element geometry before mutating the DOM, eliminating forced synchronous reflow.
- Cached the `#menuItems` `NodeListOf` query across each update pass instead of re-querying per item.
- Simplified `#firstItem` to a one-liner using `Array.find`.
- Coalesces rapid resize/intersection events via `requestAnimationFrame` so at most one layout pass runs per frame.
- `update()` remains the public entry point (coalescing scheduler); actual layout work is in the private `#performUpdate()`.
- `overflow: visible` is always applied in `connectedCallback` (no popover feature-detection gate), preserving the original behavior for CSS/tooltip positioning.
