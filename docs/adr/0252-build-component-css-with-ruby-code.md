# 252. Build component css with ruby code

Date: 2022-08-17

## Status

Accepted and Adopted

## Context

We've talked a few times about the overhead it takes to develop components twice for rails architecture. Once in [primer/css](https://github.com/primer/css/pull/2083) and again in [primer/view_components](https://github.com/primer/view_components/pull/1225). This disconnect can lead to multiple versions and iterations happening in primer/css before any component is actually ready. [^1] [^2] [^3] [^4] [^5] [^6].

## Decision

Any new View Components should include corresponding CSS in this repository instead of in Primer CSS.

### How

Because this is essentially a new build system, we want to be more forward thinking with the code written here and opt for using [PostCSS] with the [preset-env] plugin that allows us to write more CSS spec features like, nested selectors, match functions, container queries etc.

In our github.com production bundle we have a few options:

1. We could include the compiled css file in our main bundle by adding a `@import "@primer/view-components/app/assets/styles/primer_view_components.css"` import line. This is most likely what we'll start with.
2. We could use CSS modules to load specific bundles for each component dynamically when the component is included on the page. This is more work, but would be worth the reward.

[PostCSS]: https://postcss.org/
[preset-env]: https://preset-env.cssdb.org/
[^1]: https://github.com/primer/css/pull/2083
[^2]: https://github.com/primer/css/pull/2174
[^3]: https://github.com/primer/css/pull/2194
[^4]: https://github.com/primer/css/pull/2195
[^5]: https://github.com/primer/css/pull/2202
[^6]: https://github.com/primer/css/pull/2205

## Alternatives considered

### Keep component CSS separate in primer/css

Pros:

* Doesn't require us to change already established norms.
* Has storybook site

Cons:

* Requires extra releases in both libraries when iterating on component architecture.
* Cognitive disassociation between Primer::ViewComponent and .PrimerCssComponent
* Uses old SCSS technology

## Consequences

* This might make sharing CSS with Primer React more difficult, as it will now be located in a Rails-specific repository.
* The source of truth for CSS will be split across PVC and PCSS, at least in the short term.
