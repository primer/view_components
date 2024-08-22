---
"@openproject/primer-view-components": patch
---

Fix a bug where all requests from the `ToggleSwitch` view component are being made with a Turbo Accept header.
This started happening after the change in #2964 because `data-turbo=false` gets interpreted as a truthy value.
