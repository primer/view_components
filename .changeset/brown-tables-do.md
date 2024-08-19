---
'@primer/view-components': patch
---

Fixes several SelectPanel bugs:

1. If multiple server-rendered items are checked, the panel will only show one item checked.
2. If no `data-value` attributes are provided, panels in single-select mode will allow multiple items to be checked.
