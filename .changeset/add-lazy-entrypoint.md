---
"@primer/view-components": minor
---

Add `@primer/view-components/lazy` entrypoint for opt-in lazy element registration.

Elements are registered on demand using `@github/catalyst`'s `lazyDefine` (batch object form): each custom element's chunk is dynamically imported only when its tag appears in the DOM (DOM-presence trigger via MutationObserver, not viewport intersection). This allows bundlers to code-split the Primer JS into per-element chunks so consumers pay only for elements used on a given page.

The existing default `@primer/view-components` entry remains fully eager and is unchanged — this is purely additive. Pure side-effect modules (`shared_events`, `utils`) and base dependencies (`@github/include-fragment-element`, `@github/remote-input-element`) are still imported eagerly within the lazy entry.

A test (`test/lib/js_entrypoints_test.rb`) asserts that `primer.ts` and `lazy.ts` always contain the same set of element modules. The component generator is updated to register new elements in both files automatically.
