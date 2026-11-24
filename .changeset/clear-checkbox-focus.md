---
"@primer/view-components": patch
---

The checkbox focus outline keeps a visible gap. With Primitives 11.7.0 or later, it meets 3:1 contrast against the canvas in the supported themes.

The dimmed theme uses a higher-contrast shared focus default. This also changes radio buttons, marketing buttons, and other controls that use the shared focus token. The correction covers fixed-light, fixed-dark, and automatic color modes. Consumer `--focus-outlineColor` overrides remain active.

Primitives versions before 11.7.0 retain their previous dimmed focus color because they do not have the modern focus-token alias.

The options preview uses unique checkbox IDs to preserve the label associations.
