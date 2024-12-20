---
"@openproject/primer-view-components": minor
---

[59468] Initial implementation of Danger Confirmation Dialog
This is an opinionated dialog that requires the user to confirm that they wish to perform a "potentially dangerous" action by clicking a checkbox. The submit button is disabled until the checkbox is clicked. A "potentially dangerous" action could be a destructive action that cannot be easily reverted, such as bulk delete.
