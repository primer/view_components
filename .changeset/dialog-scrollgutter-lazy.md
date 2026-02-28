---
"@primer/view-components": patch
---

Defer `--dialog-scrollgutter` computation in `DialogHelperElement` to the moment a dialog is first opened, avoiding a forced synchronous layout reflow during page load.
