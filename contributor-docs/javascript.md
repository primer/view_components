# Working with JavaScript

Some Primer ViewComponents rely on JavaScript for client-side behaviors. [Read more about the introduction of behavioral components in this ADR](https://github.com/primer/view_components/blob/main/adr/0250-developing-and-publishing-clientside-behaviours.md).

## JavaScript strategy

Alongside the `primer_view_components` gem we release a `@primer/view-components` npm package which bundles all the JavaScript needed for components with client-side behaviors.

We write JavaScript in the Primer ViewComponents repository alongside its Ruby functionality, but some components import their behaviors from other npm packages:

### GitHub Elements

GitHub’s [open-source web components](https://github.com/github/github-elements) are accessible unstyled elements that are released as separate npm packages and are owned by the Web Systems team.

Initially all our client-side behaviors came from using these web components but we found a lot of friction when trying to update their functionality and we decided we don’t want to create new web components in GitHub’s collection solely for Primer use. Only use GitHub Elements when there’s already an element that matches your use case without needing changes.

### Primer Behaviors

[Primer Behaviors](https://github.com/primer/behaviors) was created to share interactive behaviors between different Primer implementations. It contains vanilla JavaScript functions for accessible generic UX patterns such as focus trapping.

We recommend importing functionality from Primer Behaviors where useful. If you create a behavior that could be used in multiple components or implementations it should be upstreamed to Primer Behaviors.

## Developing interactive components

### Creating a new interactive component

You can scaffold a new interactive component by using the `--js` flag with the component generator script. [Read more about adding components](./adding-components.md#process-for-adding-a-component).

### Adding interaction to an existing component

To add JavaScript to an existing component create a TypeScript file at the same level as your component’s Ruby file. For example if your component was in `app/components/alpha/example.rb` your JavaScript would live in `app/components/alpha/example.ts`.

To add package dependencies run `yarn add package-name` in the root directory.
