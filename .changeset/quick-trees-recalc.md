---
"@primer/view-components": patch
---

TreeView: cut style recalculation cost in large trees. Anchor and child-scope `:has()` selectors, stop the disabled `not-allowed` cursor from leaking onto parent and sibling rows, and drive the level-line focus state from a `data-focus-within` attribute so moving focus between items no longer restyles every level line in Safari
