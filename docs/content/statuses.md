---
title: Statuses
---

Each component is assigned a status for its maturity level:

| Status         | Meaning                                                                |
| -------------- |------------------------------------------------------------------------|
| `Alpha`        | Experimental. Breaking changes are likely.                             |
| `Beta`         | Usage encouraged, but not required.                                    |
| `Stable`       | Usage expected.                                                        |
| `Deprecated`   | Usage not allowed. May be removed at any time.                         |

We expect many components to move from alpha to beta and from beta to stable soon. Watch for releases in the [repo](https://github.com/primer/view_components).

You can also see the status of all Primer ViewComponents at once on [this project board](https://github.com/primer/view_components/projects/3).

## Criteria for changing component status

### Promote from internal application to alpha

We recommend building new Primer ViewComponents in an application that uses them first, upstreaming them when:

- The Design Systems team has approved the component for inclusion in Primer.
- The CSS for the component has been added in a release of Primer CSS.
- The component is used in production, using all proposed APIs and their permutations.
- The component is compatible with [System arguments](/system-arguments) as appropriate.
- The API is consistent with existing components.

### Promote from alpha to beta

- The component does not use any deprecated `view_component` framework features, such as Slots v1.
- Documentation and storybook stories are complete.
- The API is approaching a point of stability.
- The component is used in production at least 3 times.
