# Adding components

## Criteria for adding a component

We recommend building new Primer ViewComponents in an application that uses them first, upstreaming them when:

- The Design Infrastructure team has approved the component for inclusion in Primer
- The CSS for the component has been added in a release of Primer CSS
- The component is used in production, using all proposed APIs and their permutations
- The component is compatible with [System arguments](https://primer.style/view-components/system-arguments) as appropriate
- The API is consistent with existing components

### Component status

We classify our components into alpha, beta and stable statuses. You can read more about these milestones in the [Primer’s component lifecycle](https://primer.style/contribute/component-lifecycle). In addition to the criteria listed there, to promote a Primer ViewComponent from alpha to beta it must not use any deprecated [view_component](https://viewcomponent.org/CHANGELOG.html) framework features, such as Slots v1.

## Process for adding a component

Use the following generator script to scaffold a new component:

```bash
bundle exec thor component_generator <component_name>
```

The generator script has several flags:

- `status` can be `alpha`, `beta` or `stable` (defaults to `alpha`)
- `inline` creates a `#call` method instead of generating an ERB template
- `js` can be passed the name of an npm package dependency

### Generated files

Running the component generator script creates several files across the codebase:

- `app/components/<status>/<component_name>.rb` is where the component logic is defined, and where you’ll write the component’s [documentation] in the form of YARD comments
  - [Read about writing documents with YARD comments](./documentation.md#yard-setup)
- `app/components/<status>/<component_name>.html.erb` is the component’s template file (omitted if the `inline` flag is passed to the generator)
- `stories/primer/<status>/<component_name>.rb` defines the Storybook stories for the component
  - [Read about writing stories](./documentation.md#writing-storybook-stories)
- `test/components/primer/<status>/<component_name>.rb` contains the component’s unit tests
  - [Read about writing component tests](./component-tests.md)

If the `js` flag is passed in it will create some extra files:

- `app/components/<status>/<component_name>.ts` contains the imports for any specified npm dependencies
- `test/system/<status>/<component_name>.rb` contains the component’s system tests
- `demo/test/components/preview/primer/<status>/<component_name>_preview.rb` contains the component’s preview tests

The script also edits some files:

- The component is added to the list of components in `lib/tasks/docs.rake` and `test/component/component_test.rb`, in the latter you need to add examples for all the required arguments of the component
- The component is added to `docs/src/@primer/gatsby-theme-doctocat/nav.yml` which defines the sidebar structure of the documentation website, you need to reorder the item or delete it if you don’t want the component to be visible on the website
