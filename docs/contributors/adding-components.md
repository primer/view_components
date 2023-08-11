# Adding components

## Criteria for adding a component

New components can be added to Primer ViewComponents when they fulfill all these criteria:

- The Design Infrastructure team has approved the component for inclusion in Primer
- The component is compatible with [System arguments](https://primer.style/design/foundations/system-arguments) as appropriate
- The API is consistent with existing components

### Component status

We classify our components into alpha, beta and stable statuses. You can read more about these milestones in the [Primer’s component lifecycle](https://primer.style/design/guides/component-lifecycle). In addition to the criteria listed there, to promote a Primer ViewComponent from alpha to beta it must not use any deprecated [view_component](https://viewcomponent.org/CHANGELOG.html) framework features, such as Slots v1.

## Process for adding a component

Use the provided generator to create a component:

```sh
bundle exec thor component_generator my_component_name
```

To declare a dependency on an `npm` package, pass `js` to the generator:

```sh
bundle exec thor component_generator my_component_name --js=some-npm-package-name
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

### Tag considerations

Components and slots should restrict which HTML tags they will render. For example, an `Image` component should never be rendered as an `<h1>`.

Consider which HTML tags make sense. Components typically fall under one of the following patterns:

1) Fixed tag that cannot be updated by the consumer:

```rb
system_arguments[:tag] = :h1
```

2) Allowed list of tags that are set with the `tag:` argument using the `fetch_or_fallback` helper.

```rb
system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
```
