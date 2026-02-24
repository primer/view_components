---
"@primer/view-components": patch
---

Defer `--dialog-scrollgutter` computation to avoid forced synchronous reflow on page load; the value is now computed lazily when the first dialog is opened
