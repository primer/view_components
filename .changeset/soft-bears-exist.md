---
'@openproject/primer-view-components': patch
---

`Primer::OpenProject::InputGroup` component text input group broke when provided with a caption.
Split out the caption into it's own flex container so it's isolated from the text input + trailing input action.
