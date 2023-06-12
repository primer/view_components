# Adding components

## Criteria for adding a component

New components can be added to Primer ViewComponents when they fulfill all these criteria:

- The Design Infrastructure team has approved the component for inclusion in Primer
- The CSS for the component has been added in a release of Primer CSS. CSS can also live next to the component in a .pcss file.
- The component is used in production, using all proposed APIs and their permutations
- The component is compatible with [System arguments](https://primer.style/design/foundations/system-arguments) as appropriate
- The API is consistent with existing components

### Component status

We classify our components into alpha, beta and stable statuses. You can read more about these milestones in the [Primer’s component lifecycle](https://primer.style/design/guides/component-lifecycle). In addition to the criteria listed there, to promote a Primer ViewComponent from alpha to beta it must not use any deprecated [view_component](https://viewcomponent.org/CHANGELOG.html) framework features, such as Slots v1.

### Experimental lifecycle

All components added to Primer ViewComponents must already be validated in a production environment. We recommend building components in an application that uses them first, but to speed up the upstreaming process it may be easier to use a hybrid approach:

1. Develop the component in a Primer ViewComponents draft pull request

    This sandbox is optimised for component development so it may be faster than your production application for initial explorations. You can write tests and documentation as you develop and it’s easier to achieve API consistency when you can see it next to other Primer ViewComponents.

2. Copy over to a production application

    Use the `Primer::Experimental` namespace to indicate that the component is a candidate for upstreaming. Integrate into a minimum of three places to validate your technical decisions and deploy. Without needing to wait for Primer release cycles you can iterate as needed here and copy any changes back to the Primer ViewComponents draft pull request.

3. Open your Primer ViewComponents pull request

    Once the component is validated in a production application and fulfills the other criteria it can be added to Primer ViewComponents and released. Instances of the experimental component in your production application can then be replaced by the Primer ViewComponent.

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
  - [Read about writing documents with YARD comments](./README.md#writing-documentation)
- `app/components/<status>/<component_name>.html.erb` is the component’s template file (omitted if the `inline` flag is passed to the generator)
- `test/components/primer/<status>/<component_name>.rb` contains the component’s unit tests
  - [Read about writing component tests](./README.md#system-tests)

If the `js` flag is passed in it will create some extra files:

- `app/components/<status>/<component_name>.ts` contains the imports for any specified npm dependencies
- `test/system/<status>/<component_name>.rb` contains the component’s system tests
- `test/components/preview/primer/<status>/<component_name>_preview.rb` contains the component’s previews

The script also edits some files:

- The component is added to the list of components in `lib/tasks/docs.rake` and `test/component/component_test.rb`, in the latter you need to add examples for all the required arguments of the component
- The component is added to `docs/src/@primer/gatsby-theme-doctocat/nav.yml` which defines the sidebar structure of the documentation website, you need to reorder the item or delete it if you don’t want the component to be visible on the website
