---
"@primer/view-components": patch
---

Add `tmp-` prefixed duplicate classes for margin and padding utilities. System arguments like `mb: 3` now output both `mb-3` and `tmp-mb-3` classes to support CSS namespace migration.
