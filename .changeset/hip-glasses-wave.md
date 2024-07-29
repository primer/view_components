---
"@openproject/primer-view-components": minor
---

Add `turbo: true` as an parameter for the `ToggleSwitch` component and treat the respoonse (when it has the correct MIME type) as a [Turbo Stream](https://turbo.hotwired.dev/handbook/streams). The new `turbo` paramater defaults to false
and with that the HTTP response is simply ignored as is the current behavior.
