---
'@openproject/primer-view-components': patch
---

Make FeedbackDialog title param required: Axe will raise accessibility violations in the absence of a title. We want to ensure best a11y practice, so this change makes it a required param and documents it.

This is a BREAKING change.
