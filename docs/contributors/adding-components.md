# Adding components

## Criteria for adding a component

New components can be added to Primer ViewComponents when they fulfill all these criteria:

- The Design Infrastructure team has approved the component for inclusion in Primer
- The component is compatible with [System arguments](https://primer.style/design/foundations/system-arguments) as appropriate
- The API is consistent with existing components

### Component status

Primer classifies their components into alpha, beta and stable statuses. You can read more about these milestones in the [Primer’s component lifecycle](https://primer.style/design/guides/component-lifecycle).

We have added an additional status open_project to collect all our components in a separate namespace and clearly distinguish them from the original Primer components.

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

- `status` can be `alpha`, `beta`, `stable` or `openproject` (defaults to `openproject`)
- `inline` creates a `#call` method instead of generating an ERB template
- `js` can be passed the name of an npm package dependency

### Generated files

Running the component generator script creates several files across the codebase:

- `app/components/<status>/<component_name>.rb` is where the component logic is defined, and where you’ll write the component’s [documentation] in the form of YARD comments
  - [Read about writing documents with YARD comments](./README.md#writing-documentation)
- `app/components/<status>/<component_name>.html.erb` is the component’s template file (omitted if the `inline` flag is passed to the generator)
- `app/components/<status>/<component_name>.pcss` is the component’s css logic
- `test/components/primer/<status>/<component_name>.rb` contains the component’s unit tests
  - [Read about writing component tests](./README.md#system-tests)
- `test/system/<status>/<component_name>.rb` contains the component’s system tests
- `test/components/preview/primer/<status>/<component_name>_preview.rb` contains the component’s previews

If the `js` flag is passed in it will create some extra files:

- `app/components/<status>/<component_name>.ts` contains the imports for any specified npm dependencies

The script also edits some files:

- The component is added to the list of components in `test/component/component_test.rb`, in that you need to add examples for all the required arguments of the component
- The pcss file is added to the list in `app/components/primer/primer.pcss`
- The js file is added to the list in `app/components/primer/primer.ts` if the `js` flag is passed

### Playwright testing

In order for the component to be part of the visual regression test suite, you need to extend the `static/previews.json` with the examples that shall be tested.

```json
{
    "name": "my_component",
    "component": "MyComponent",
    "status": "openproject",
    "lookup_path": "primer/open_project/my_component",
    "examples": [
      {
        "preview_path": "primer/open_project/my_component/playground",
        "name": "playground",
        "snapshot": "true",
        "skip_rules": {
          "wont_fix": [
            "region"
          ],
          "will_fix": [
            "color-contrast"
          ]
        }
      },
      {
        "preview_path": "primer/open_project/my_component/default",
        "name": "default",
        "snapshot": "true",
        "skip_rules": {
          "wont_fix": [
            "region"
          ],
          "will_fix": [
            "color-contrast"
          ]
        }
      },
      ...
    ]
  },
```

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
