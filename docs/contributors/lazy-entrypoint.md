# Lazy entrypoint (`@primer/view-components/lazy`)

## Two entrypoints

`@primer/view-components` exposes two JavaScript entrypoints:

### Default (eager)

```js
import '@primer/view-components'
```

Every custom element is registered **synchronously on import**. This is the original behavior and remains the default. All ~30 elements are upgraded immediately, so there is no pre-upgrade window.

### Opt-in (lazy)

```js
import '@primer/view-components/lazy'
```

Elements are registered **on demand** using [`@github/catalyst`'s `lazyDefine`](https://github.github.io/catalyst/guide/lazy-define.html). A `MutationObserver` watches the document for added nodes; when an element's tag appears in the DOM (after `DOMContentLoaded`), its module chunk is dynamically imported and the element upgrades. This allows bundlers to code-split each element into its own chunk, so consumers only pay for the elements actually used on a given page.

## Trade-offs

| | Default (eager) | Lazy |
|---|---|---|
| Elements upgrade | Synchronously on import | When their tag appears in the DOM |
| Pre-upgrade window | None | Brief (until the dynamic import resolves) |
| Bundle size | Everything upfront | Code-split; only used elements are fetched |
| Opt-in required | No | Yes – import `@primer/view-components/lazy` |

Because of the pre-upgrade window, elements that do meaningful work in `connectedCallback` (e.g. ARIA state, event wiring) may be momentarily non-functional after insertion. This is an inherent trade-off of lazy loading and is why the lazy entrypoint is opt-in rather than the default.

### Side-effect modules

A few modules have no custom-element tag (they augment types or provide utilities). These are always imported **eagerly** within the lazy entry so their behavior is available regardless of which elements appear in the DOM:

- `shared_events` – global event type augmentations
- `utils` – shared utility functions
- `@github/include-fragment-element` – base dependency for `tree-view-include-fragment`
- `@github/remote-input-element` – external dependency

## Trigger behavior

The default trigger for `lazyDefine` is **DOM presence after document load** (not viewport intersection). Elements upgrade as soon as their tag appears anywhere in the document, not just when they scroll into view. You can override this per-element with the `data-load-on` attribute on the element itself (values: `ready` [default], `firstInteraction`, `visible`).

## Keeping eager and lazy in sync

The set of elements registered by the eager entry (`primer.ts`) and the lazy entry (`lazy.ts`) is verified by a test (`test/lib/js_entrypoints_test.rb`) that fails if they diverge. The component generator (`component_generator.thor`) also updates both files automatically when a new element is scaffolded.

## Build output

Running `npm run build:js` produces:

- `app/assets/javascripts/primer_view_components.js` — existing IIFE bundle (eager entry)
- `app/assets/javascripts/primer_view_components_lazy/` — ESM code-split chunks (lazy entry), one file per element
