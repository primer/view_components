---
"@openproject/primer-view-components": patch
---

Updates 'inactive' state for buttons based on feedback from the a11y team:
- inactive buttons need to meet the color contrast ratio minimum
- inactive buttons shouldn't have aria-disabled since they can still accept interactions such as:
  - hover/focus to show a tooltip
  - click/activate to show a dialog with more detailed info on why it's inactive

<!-- Changed components: Button -->
