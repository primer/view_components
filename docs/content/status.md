---
title: Component status
description: Check the current status of Primer ViewComponents
---

import {ComponentStatuses} from '../src/component-statuses'

See the [component lifecycle](https://primer.style/contribute/component-lifecycle) for more information about each status.

<ComponentStatuses />

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
