---
'@openproject/primer-view-components': patch
---

Fixes Alpha::SelectPanel remote loading bug where items from the server were overriding the users selections. Additionally, update the #removeSelectedItem function to grab the data-value from the correct element.
