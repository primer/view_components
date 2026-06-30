---
"@primer/view-components": patch
---

Reject `javascript:` and `vbscript:` URI schemes in `href` (defense in depth). When a component (e.g. `Primer::Beta::Label`, `Primer::Beta::Button`, `Primer::Beta::Link`) is rendered as an anchor with an unsafe `href`, the value is now rejected — raising in non-production environments and silently dropped (rendered as an anchor with no `href`) in production.
