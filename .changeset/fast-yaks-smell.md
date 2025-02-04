---
'@openproject/primer-view-components': minor
---

[#60588] Implementation of Danger Dialog, a generalised dialog for "potentially dangerous" actions such as item deletion.
There are two variants:

1. **the default (or "warning") variant**, requiring the user to click the dialog confirmation button to continue.
2. **the second confirmation variant**, which requires the user to check a check box AND click confirm to continue with the operation.

This is a BREAKING change, which renames `DangerConfirmationDialog` to `DangerDialog`. Callers will need to update the class name and consider which behaviour they wish to present to the end user. The confirmation variant behaviour is enabled by defining a `confirmation_check_box` slot.
