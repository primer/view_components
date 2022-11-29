# Registering Deprecations

Components within PVC should be marked as deprecated by updating `lib/primer/deprecations.yml`. For testing purposes, and for integration with other apps and services, though, a developer may provide a custom yaml file or call the deprecations API directly, to register a custom deprecated component.

yaml file:
```rb
# see lib/primer/deprecations.yml for documentation on yml file format
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

### Valid and Invalid Deprecation Configurations

Deprecations are configured with these three settings:

* auto-correctable
* replacement component
* upgrade/migration guide

Not all configurations, based on these settings, are valid. 

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

This information is available in the comments at the top of the `lib/primer/deprecations.yml` file. Only the valid configurations have tests written for them. None of the invalid configurations have tests. As noted previously, there are tests to ensure the configuration of every deprecated component is valid.
