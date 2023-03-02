# Registering Deprecations

Components within PVC should be marked as deprecated by updating `lib/primer/deprecations.yml`.

## Custom Deprecation Registration

For integration with other apps and services, a developer may provide a custom yaml file or call the deprecations API directly, to register a custom deprecated component.

yaml file:

```rb
Primer::Deprecations.register("path/to/custom_deprecations.yml")
```

code:

```rb
Primer::Deprecations.register_deprecation("Some::Component::Name", {
  autocorrect: false,
  replacement: "Another::Component::Here",
  guide: "https://example.com/some/guide"
});
```

## Deprecation Configuration

Entries in `lib/primer/deprecations.yml` must use the following configuration
options.

### Schema

```yml
- component: [string]
  autocorrect: [boolean]
  replacement: [string]
  guide: [string]
```

### Field Descriptions

* component:
  * **Required**
  * Type: string
  * The full ruby class of the deprecated component

* autocorrect:
  * Optional
  * Type: boolean
  * Default: false
  * Whether or not this deprecations can be autocorrected with `erblint -a`

* replacement:
  * Optional
  * Type: string
  * Default: nil
  * The full ruby class of the new component, if any, that replaces the now deprecated component

* guide:
  * Optional
  * Type: string
  * Default: nil
  * A url that contains instructions on how to migrate from the deprecated component to the new component

### Examples

These are examples of valid configurations. Please note that invalid
configurations will cause a failure in the `test/lib/deprecations_test.rb`
tests, and will not pass CI. See the following section on valid and invalid
configurations for more information.

1. An autocorrectable deprecation without a migration guide

```yml
  - component: "Primer::DeprecatedComponent"
    autocorrect: true
    replacement: "Primer::Beta::Component
```

2. An autocorrectable deprecation with a migration guide to provide more information about the changes

```yml
  - component: "Primer::DeprecatedComponent"
    autocorrect: true
    replacement: "Primer::Beta::Component
    guide: "https://example.com/primer_component"
```

3. A non-autocorrectable deprecation, with a replacement component and migration guide

```yml
  - component: "Primer::ButtonComponent"
    autocorrect: false
    replacement: "Primer::Beta::Button"
    guide: "https://example.com/button_component"
```

4. A non-autocorrectable deprecation, without a replacement component, and with a guide to alternatives

```yml
  - component: "Primer::DeprecatedComponent"
    autocorrect: false
    guide: "https://example.com/dropdown_menu_alternatives"
```

### Valid and Invalid Deprecation Configurations

Not all configurations, based on the available settings, are allowed. Here is a
list of what combinations are and are not valid.

| HAS REPLACEMENT | CAN AUTOCORRECT | HAS GUIDE | VALID? |
|-----------------|-----------------|-----------|--------|
| true            | true            | true      | YES    |
| true            | true            | false     | YES    |
| true            | false           | true      | YES    |
| true            | false           | false     | NO     |
| false           | true            | true      | NO     |
| false           | true            | false     | NO     |
| false           | false           | true      | YES    |
| false           | false           | false     | NO     |

As noted previously, there are tests to ensure the configuration of every deprecated component is valid.
