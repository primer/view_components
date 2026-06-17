---
"@primer/view-components": patch
---

Improve CSS style-recalc performance by removing selectors with universal subjects and expanding merged `:is()` selector lists so the browser can fast-reject them. Affects `autocomplete-item`, `Popover-message--*`, `breadcrumb-item`, and `FormControl-checkbox-wrap`/`FormControl-radio-wrap` styles.
