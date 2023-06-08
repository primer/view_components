---
title: Linting
---

Primer ViewComponents offers a suite of linters to make writing UI more consistent. We provide custom linters for [erb-lint](https://github.com/Shopify/erb-lint) and cops for [rubocop](https://github.com/rubocop/rubocop).

## Setup

### rubocop

To use our custom cops, you have to inherit our gem configuration in `.rubocop.yml`:

```yml
inherit_gem:
  primer_view_components: lib/rubocop/config/default.yml
```

You can also modify that configuration enabling/disabling the cops you want:

```yml
Primer/SystemArgumentInsteadOfClass:
  Enabled: false
```

### erb-lint

To get access to our ERB linters, create a `.erb-linters/primer.rb` file with:

```rb
require "primer/view_components/linters"
```

Then, you can enable them in `.erb-lint.yml`. E.g.:

```yml
linters:
  ButtonComponentMigrationCounter:
    enabled: true
```

If you also want to add our cops when linting ERB, you can modify your `.erb-lint.yml` to have:

```yml
linters:
  Rubocop:
    enabled: true
    rubocop_config:
      inherit_gem:
        primer_view_components: lib/rubocop/config/default.yml
```

## Building linters

Linters have been extremely helpful tools to migrate code from old HTML to components. It keeps human errors like typos out of the migrations and can surface many cases at once.
We want to build linters for **all** of our components, so it's a good idea to explain how to do it.

### Linter structure

Before building a new linter, we need to understand their structure and how they work.

![diagram](https://user-images.githubusercontent.com/11280312/130091242-e47b1b51-9fde-4880-a885-e6cb3098ad74.png)

#### BaseLinter

This class holds the main linter logic, interpreting the AST and building a "tag tree", linking each tag with its closing tag. Knowing where each block starts and ends allows us to apply autocorrections using `do/end` blocks.

#### Autocorrectable

This module has the autocorrection logic, which will transform HTML attributes into component arguments. It will also build the replacement code for said HTML.

#### ArgumentMappers

These are classes that define which attributes and classes should be converted into arguments. They all should inherit `ERBLint::Linters::ArgumentMappers::Base`, which provides an interface to return the arguments as a hash or string.
The `Base` class will also make sure that all autocorrections take SystemArguments into consideration.

### Configuration

Since all the logic matching is extracted to `BaseLinter`, we need to set some parameters in our class to create a linter.

To help keep arguments in sync, we provide a `Primer::ViewComponents::Constants.get` helper, which can get constant values from our components. This will guarantee that when we update our components, it will also update the linters.

#### Basic configuration

If a linter does not provide autocorrection, you only need to inherit from `BaseLinter` and set the following constants:

##### TAGS (required)

The `TAGS` constant holds an array of all the valid HTML tags for this component. This will be used by `BaseLinter` to check if a node is a candidate for a component.

E.g.: `button, summary, a` for a `ButtonComponent`.

##### MESSAGE (required)

This is the message that will be displayed when there is an offense. Most of them follow the same template but can be customized.

##### CLASSES (optional)

The `CLASSES` constant will have a list of classes that may indicate that an HTML node corresponds to a component. This will only be checked if the node passed the `TAGS` check.

E.g.: `btn, btn-link` for a `ButtonComponent`.

##### REQUIRED_ARGUMENTS (optional)

A list of arguments that are required for a component. Each item in the list can be either a string or a regex.

E.g.: `/for|value/, "aria-label"` for `ClipboardCopy`.

#### Autocorrectable

To enable autocorrection in a linter, make sure to include the `Autocorrectable` module and set the following constants:

##### ARGUMENT_MAPPER (required)

The class responsible for transforming classes and attributes into arguments for the component. See [ArgumentMapper](#argumentmapper) section on how to create a mapper.

##### COMPONENT (required)

The component name for the linter. It will be used on autocorrection to set `COMPONENT.new(arguments)` as a suggestion.

### ArgumentMapper

All mappers follow the same interface provided by `ERBLint::Linters::ArgumentMappers::Base`.
The base logic will transform:

1. classes in the HTML node into SystemArguments
2. `aria-` attributes
3. `data-` attributes
4. `test_selector`
5. HTML tag into `tag:`

If the linter needs to transform more attributes or classes into specific values, you'll need to create a new class that inherits `Base`.

#### Custom mapper

Custom mappers have two methods:

##### attribute_to_args

If you need to transform attributes into arguments, you'll need to set a `ATTRIBUTES` constant with the list you want to convert and then implement the `attribute_to_args`.
That method will be called for each attribute in the constant and must return a hash with the arguments you want.

[Example](https://github.com/primer/view_components/blob/1f2ab39f7dbd21f55b2183607105249df1ccac97/lib/primer/view_components/linters/argument_mappers/button.rb#L35-L49)

##### classes_to_args

This method will receive a list of all the classes and must return a Hash with all the arguments. The hash must also have `classes` key with all the classes that couldn't be mapped (or an empty array).

[Example](https://github.com/primer/view_components/blob/1f2ab39f7dbd21f55b2183607105249df1ccac97/lib/primer/view_components/linters/argument_mappers/button.rb#L51-L66)
