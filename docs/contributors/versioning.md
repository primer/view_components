# Versioning

When deciding to version your pull request, consider the list. In addition to what is [typically considered](https://semver.org/#summary) for versioning by semver.org, below are a list of examples of what we consider a `Major, Minor, Patch` change. If you find that your change does not match the list, reach out to us for guidance.

## Major

- Removing/renaming component names, arguments, or slots.
- Removing dependencies from the `primer_view_components.gemspec` or the `package.json`.

## Minor

- Changing the html output of a component.
- Changing the CSS classnames of a component.

## Patch

- Updating dependency versions

## Skip Versioning

These are changes that we typically do not label.

- Changing previews/docs/tests or any other scaffolding type files in this repository.
