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

We expect many components to move from alpha to beta and from beta to stable soon. Feel free to watch for releases in the [repo](https://github.com/primer/view_components).

You can also see component status at a glance on [this project board](https://github.com/primer/view_components/projects/3).

## Criteria for changing component status

### Promote from alpha to beta

- The component does not use any deprecated `view_component` framework features, such as Slots v1.
- Documentation and storybook stories are complete.
- The API is expected to be stable.
