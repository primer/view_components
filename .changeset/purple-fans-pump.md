---
"@openproject/primer-view-components": patch
---

Bug fix: Respect autofocus attributes inside of a Dialog when opening a modal-dialog. When the dialog was opening before it was always focusing the first focusable element which was always the close button.
