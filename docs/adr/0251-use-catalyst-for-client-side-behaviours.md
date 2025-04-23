# Use Catalyst for client-side behaviours

Date: 2022-04-12

## Status

Status: Accepted ✅\
Implementation: Adopted ✅

## Context

<!-- The issue motivating this decision, and any context that influences or constrains the decision. -->

Existing Primer ViewComponents behaviours don't use [Catalyst](https://github.github.io/catalyst) or any other dependency, while GitHub developers often start writing a component using Catalyst.

Removing the Catalyst dependency from the Web Component is an extra burden on Web Developers with few benefits. The library is ~1kb of JavaScript, and github.com already includes the library as part of its client-side bundle. Adding the library to Primer ViewComponents does not affect github.com and has a minimal effect on other applications using Primer ViewComponents.

## Decision

<!-- The change that we're proposing or have agreed to implement. -->

Any new Primer ViewComponent behaviours should be authored using Catalyst.

## Considered Options

* Don't use Catalyst in PVC.
  * Pros:
    Developers who don't have Catalyst experience don't need to learn how the library works.
    * The bundle size doesn't need to increase by 1kb.
  * Cons:
    * Migrating components from the github.com codebase would need to be converted to Web Components without Catalyst.
* Use another JavaScript behaviour library or strategy than Catalyst.
  * Pros:
    * The bundle size doesn't need to increase by 1kb.
  * Cons:
    * Migrating components from the github.com codebase would need to be converted to Web Components without Catalyst.
    * PVC JavaScript behaviours would differ from how GitHub engineers write JavaScript behaviours today.

## Consequences

<!-- What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.-->

* The Primer ViewComponents JS bundle gets larger.
* Developers unfamiliar with Catalyst need to get familiar with the library.
