# Developing and publishing client-side behaviours

Date: 2021-02-19

## Status

| Stage    | State      |
| -------- | ----------- |
| Status | Accepted ✅ |
| Implementation | Adopted ✅ |

## Context

We want to ship client side behavioural elements with Primer View Components to increase the fidelity of our components.

Doing so requires us to align to a set of constraints for the Browser ecosystem, as well as the ecosystems that consumers of Primer View Components have:

* We need to produce a JavaScript based artefact, as this is the language browsers use for client side behaviours.
* The artefact should be easily consumable by existing tool chains of our consumers, which may or may not be the Rails Asset Pipeline.
* The setup process should be uncomplicated and familiar to consumers; by using existing Rails paradigms, or JavaScript ecosystem paradigms or tools such as npm.
* Client side behaviours should be well tested and offer the same level of quality the existing non-behavioural components do.

## Decision

### TypeScript

We will write behaviours in TypeScript, which is a compile-to-JavaScript language that offers stronger type guarantees leading to a higher quality level of code. TypeScript is already being used for [`primer/components`](https://github.com/primer/components) which is also a motivating factor.

Behaviours will live in TypeScript files in the `app/components` directory next to their respective `.rb` files. By convention files will be named with the same basename as the Ruby counterpart. An `app/components/primer.ts` file will also exist which must import all other `.ts` files, acting as an index file. A single `.js` file with no external dependencies, which will live in `app/assets/javascripts/primer.js`. This single file can then be loaded through the Rails Asset pipeline, allowing for consumers to call `javascript_include_tag("primer")`.

### Publishing to npm

Additionally, we will produce an [npm package](https://www.npmjs.com/) which contains all the compiled JavaScript both as individual files and as the single bundle in `app/assets/javascripts/primer.js`. This npm package will allow for consumption of the JS outside of using the traditional Rails Asset Pipeline. Developers will be able to call `import "@primer/view_components"` within their JS, which means their JS toolchain will be able to perform necessary transformations or optimisations. This will also allow for selective component imports, for example `import "@primer/view_components/time_ago_component"` could import just `TimeAgoComponent`.

Publishing a sidecar package like this moderately increases _complexity_ for this library, but drastically increases _flexibility_ and decreases the burden on the library to provide flexible paths for the variety of JavaScript compilers in use today. Good precedent exists for offering sidecar client side libraries, for example the [Turbo Framework offers a sidecar package](https://github.com/hotwired/turbo-rails#installation) if not using the built in Asset Pipeline.

### Testing

We will test our behaviours in the Browser environment (using Rails System tests), as this is where they will be consumed. This will require using Browser APIs to automate testing. We will use test automation libraries that automate browsers via the [Devtools Protocol](https://chromedevtools.github.io/devtools-protocol/) such as [Puppeteer](https://pptr.dev/), [Playwright](https://playwright.dev/) or [Ferrum](https://ferrum.rocks/). Using a Devtools Protocol based tool gives us the best level of flexibility in testing, while also being compatible with current browsers.

### Documentation

We will document which components are behavioural, so that consumers are aware they are required to load the client side bundle code for these components to work properly. We will offer a documentation page on how to use the `javascript_include_tag` helper to load the bundle using the Asset Pipeline, or otherwise import the npm package within their codebases.

## Consequences

This library will be able to provide behaviours for higher fidelity components, using consistent methods that lean to the strengths of the Rails & JS ecosystems.

Contributors of Primer View Components will need to have an understanding of TypeScript if they wish to author behavioural components.

There will be additional work for our consumers if they wish to use behavioural components. Consumers will need to use the `javascript_include_tag` helper, or otherwise import the npm bundle in order for these components to work in their projects.
