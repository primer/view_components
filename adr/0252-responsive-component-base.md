# Responsive Components

The `ResponsiveComponent` class adds support for creating `viewport_range`-based responsive components, in a similar way that `Primer::Component` adds support for Primer CSS utility classes.

## Context

The [Primer Responsive ADR](https://github.com/github/primer/blob/main/adrs/2022-04-15-responsive-design-api-guidelines.md) explains the reason to move away from CSS utility classes into a component based CSS approach. This enables a higher level of decisions to the components, since now they can be used considering viewport ranges instead of breakpoints alone.

This makes it easier to define specific behaviors for each viewport range and support different kinds of affordances based on the user's device.

However, since now components will have its own set of CSS classes, handling conditional classes by matching the component's argument values can be really complex and increase the development time a lot.

The `ResponsiveComponent` base class and the `responsive` helpers aim to remove most of the boilerplate and create a consistent responsive structure, while preserving all current primer base classes and being completely opt-in.

## Current state

Inside Primer, the current responsive components are being created with a "style class map" per argument. Taking the new `PageLayout` as example, the way the classes are conditionally added is tied to the possible values an argument can assume.  For instance:

[page_layout.rb#L31-L37](https://github.com/github/github/blob/11382f7b2f89914863f64b85e7d880d5b6c1159f/app/components/primer/experimental/page_layout.rb#L31-L37)

```rb
  INNER_SPACING_DEFAULT = :none
    INNER_SPACING_DEFAULT =>   "",
    :normal => "PageLayout--innerSpacing-normal",
    :condensed => "PageLayout--innerSpacing-condensed"
  }.freeze
  INNER_SPACING_OPTIONS = INNER_SPACING_MAPPINGS.keys.freeze
```

Then, to derive the class in the component, the `fetch_or_fallback` requires biding the map, the argument value, and its default option:
```rb
  INNER_SPACING_MAPPINGS[fetch_or_fallback(INNER_SPACING_OPTIONS, inner_spacing INNER_SPACING_DEFAULT)],
```

This process can get really complicated when more arguments and classes are added, especially if the argument has to be responsive, meaning that it can have different values based on the viewport range. For instance, the `header_divider` of the `PageLayout`:

```rb
  # default or regular?
  HEADER_DIVIDER_DEFAULT = :none
  HEADER_DIVIDER_MAPPINGS = {
    HEADER_DIVIDER_DEFAULT => "",
    :none => "",
    :line => "PageLayout-header--hasDivider"
  }.freeze
  HEADER_DIVIDER_OPTIONS = HEADER_DIVIDER_MAPPINGS.keys.freeze

  # narrow
  HEADER_DIVIDER_NARROW_DEFAULT = :inherit
  HEADER_DIVIDER_NARROW_MAPPINGS = {
    HEADER_DIVIDER_NARROW_DEFAULT => "PageLayout-region--dividerNarrow-line-after",
    :none => "",
    :line => "PageLayout-region--dividerNarrow-line-after",
    :filled => "PageLayout-region--dividerNarrow-filled-after"
  }.freeze
  HEADER_DIVIDER_NARROW_OPTIONS = HEADER_DIVIDER_NARROW_MAPPINGS.keys.freeze
```

And to use the responsive classes for the `header_divider`, it still can be conditionally added like so:

```rb
# simplifying the class_names call:
class_names(
  { 
    HEADER_DIVIDER_NARROW_MAPPINGS[fetch_or_fallback(
      HEADER_DIVIDER_NARROW_OPTIONS, 
      divider_when_narrow,
      HEADER_DIVIDER_NARROW_DEFAULT
    )] => divider != :none 
  },
  HEADER_DIVIDER_MAPPINGS[fetch_or_fallback(HEADER_DIVIDER_OPTIONS, divider, HEADER_DIVIDER_DEFAULT)],
)
```

### Problems with the current approach

The current approach doesn't provide any support to handle responsive properties, making the process to develop responsive components really repetitive and resulting in a code quite complicated to parse at glance.

The other problem is that it ties together the style map and argument values space, even deriving the possible value space (`<argument_name>_OPTIONS`) from the style map. And defining the `<argument_name>_DEFAULT` and later using it as a key of the style map hash makes it harder to change default values without impacting directly the style map, forcing a refactor of it in order to keep the current `<argument_name>_OPTIONS` the same.

The `ResponsiveComponent` adds helper functions and structure to remove the boilerplate out of the way.

## Design philosphy

When designing the `ResponsiveComponent` base class, the main goal was to make its behavior explicit and the least intrusive as possible. All the main logic to handle each problem encountered is split into its own module and can be used by any component by extending the required helper, allowing the logic to be reused even if the component doesn't inherit from `ResponsiveComponent`.

That allows future components to opt-in to each helper functionality if necessary, making it easier to refactor current components incrementally, if necessary.

The main problems that have to be solved:
- Component arguments with a value space that is easy to work with, validate, and supports default values and fallback.
- Deprecation to values or entire arguments
- Component support for responsive variants based on the responsive viewport ranges defined in Primer Responsive ADR
- Validate values and values structure when working with multiple arguments using a single hash
- Use the current argument values of a component to calculate an "applied" class map
- Still support html attributes and tags defined by the consumer of the componente, if necessary

## Responsive support overview

As mentioned before, to keep things reusable and independent, inside `app/lib/primer` a `responsive` folder holds all helpers responsible to remove the boilerplate:

 - `responsive/responsive_config.rb`: defines the viewport ranges and its css class modifiers
 - `responsive/argument_definition.rb`: 
    contains classes to handle component's argument definitions. It adds support for responsive arguments, argument value validation, argument default values, and argument/values deprecation.
- `responsive/arguments_definition_helper.rb`: high level module that makes working with the `ArgumentDefinition` class a declarative based approach
- `responsive/style_class_map_helper.rb`: provides functionality to build responsive class maps based on a argument-value-class mapping automatically, and calculates classes based of the class map and the argument value provided
- `html_attributes_helper.rb`: control `html_attributes` to be used in the component rendering, making it a completely independent logic from the utility classes that primer supports.

## Viewport range names

Deriving a consistent name for each viewport range defined in the base ADR is necessary to make the code obvious and easy to read and to write.

Initially, the names used were `narrow`, `regular`, and `wide`, as they're called in the ADR, however, since they don't have a prefix, it can be hard to scan the code while looking for the viewport names.

Initially, they were prefixed with `when_`: `when_narrow`, `when_regular`, `when_wide`. The problem is that `when` is a reserved word in ruby and many code editors are going to try to ident it properly by removing one tab level. This can be anoying and that's the reason this decision was desconsidered.

After a few discussions, the selected prefix was `v_`. It can mean both variant or viewport, and it's only 2 characters long, while making the ranges visually distinct while eye scanning the code: `v_narrow`, `v_regular`, `v_wide`.

Inside `responsive_config.rb` file, it's the configuration for the viewport range names and their respective css class modifiers. It also holds the configuration for `optional` viewports, like `v_wide`, which will be used by the helpers to know when to add defaults/validation to that specific viewport range.


## Responsive arguments

Let's take a look at a simple `arguments_definition` declaring all possible arguments a custom component will support:

```rb
class CustomComponent < Primer::Alpha::ResponsiveComponent
  arguments_definition(
    id: arg(
      type: Numeric,
      default: 0
    ),
    # defines a responsive property
    position: arg(
      responsive: :yes
      allowed_values: [:top, :right, :bottom, :left],
      # defines details for the narrow viewport range (v stands for viewport)
      v_narrow: {
        # this adds more options to the base allowed values
        additional_allowed_values: [:center],
        default: :center
      },
      v_regular: {
        default: :top
      }
    )
  )

  def initialize(argument_values: {}, html_attributes: {})
    # initialize argument_values and html_attributes while adding test attrs
    super

    # normalizes the @argument_values, filling defaults and making invalid values fallback to default
    normalize_values!
  end
end
```

The `arguments_definition` method not only creates the corresponding `ArgumentDefinition` object to represent the argument, but will also ensure that the definition is consistent and error free by raising error with helpful messages in a development environment. This and the preview will make it easy for developers to learn how to define the arguments properly.



## Responsive class map

## How to use it