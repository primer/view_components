---
'@openproject/primer-view-components': patch
---

Fix DangerDialog body scroll behaviour when containing a form: the dialog's confirm and cancel buttons should now always be visible in the viewport, never scrolling with the other dialog content.