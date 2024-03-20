---
"@openproject/primer-view-components": minor
---

Changes `Primer::OpenProject::PageHeader`:

* Remove the `context_bar_actions` slot
* Remove the `parent_link` slot (will be derived automatically from the breadcrumb)
* Change the slot definition for `actions` to be type specific (allowed types are: icon_button, button, link, menu)
* On mobile, the actions collapse into a single action menu which is placed in the context_bar
