# 252. Responsive Components

Date: 2022-09-01

The `ResponsiveComponent` class adds support for creating `viewport_range`-based responsive components, in a similar way that `Primer::Component` adds support for Primer CSS utility classes.

## Status

Proposed

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

To solve this problem, the arguments and style classes of a component are defined and handled independent from one another. This allows more control over each functionality and make them easier to enhance if necessary. This also allows components to fully rely on the logic to handle arguments, even if the arguments are not necessarily be used to derive classes to be applied to html elements.

The `ResponsiveComponent` adds helper functions and structure to remove the boilerplate out of the way.

## Design philosophy

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
- `responsive/html_attributes_helper.rb`: control `html_attributes` to be used in the component rendering, making it a completely independent logic from the utility classes that primer supports.

## Viewport range names

Deriving a consistent name for each viewport range defined in the base ADR is necessary to make the code obvious and easy to read and to write.

Initially, the names used were `narrow`, `regular`, and `wide`, as they're called in the ADR, however, since they don't have a prefix, it can be hard to scan the code while looking for the viewport names.

Initially, they were prefixed with `when_`: `when_narrow`, `when_regular`, `when_wide`. The problem is that `when` is a reserved word in ruby and many code editors are going to try to ident it properly by removing one tab level. This can be anoying and that's the reason this decision was desconsidered.

After a few discussions, the selected prefix was `v_`. It can mean both variant or viewport, and it's only 2 characters long, while making the ranges visually distinct while eye scanning the code: `v_narrow`, `v_regular`, `v_wide`.

Inside the `responsive_config.rb` file, it's the configuration for the viewport range names and their respective css class modifiers. It also holds the configuration for `optional` viewports, like `v_wide`, which will be used by the helpers to know when to add defaults/validation to that specific viewport range.


## Responsive arguments

Let's take a look at a simple `arguments_definition` declaring all possible arguments a custom component will support:

```rb
class CustomComponent < ::Primer::Alpha::ResponsiveComponent
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

The `arguments_definition` method not only creates the corresponding `ArgumentDefinition` object to represent each argument, but will also ensure that the definition is consistent and error free by raising error with helpful messages in a development environment. This plus the lookbook previews will make it easy for developers to learn how to define the arguments properly.

The method works by mapping each `argument_name`(Symbol) to its definition properties. To support arguments namespaces if necessary, the method `arg` must be used to wrap the argument definition hash. It simply wraps its arguments within a specific hash key to mark that part of the hash as being the container for a definition.

### Argument definition hash keys
- `responsive`: defines the responsive behavior of the argument.  
 possible values:(`:no(default) | :yes | :transitional`)
  - `:no` _(default)_: won't accept argument values set through the responsive variants.
  - `:yes`: will only accept values set through the responsive variants.
  - `:transitional`: supports values set directly or through the responsive variants. Should only be used to migrate non-responsive arguments into responsive arguments while keeping backward compatibility in the transition period (migration).
- `type`: defines the type of the argument and will be used to validate its value. Use the base class of the type. For ruby types, use their base class as well, for instance: `Numeric`, `Integer`, `String`, `Array`, `Hash`, etc.  
  > _note_: Ruby doesn't have a boolean type that encompasses both `true` and `false` values, since they're both instances of the `TrueClass` and `FalseClass` respectively. To support booleans, used `allowed_values` instead.
  
  ```rb
  # example of type definition
  language_name_argument: arg(
    type: String
  )

  # example of argument_values setting a valid argument value
  {
    language_name_argument: "Rust"
  }
  ```
  
- `allowed_values`: defines an array with all possible values that the argument can assume. The list of values could be called simply `values`, but since `.values` is a Hash method, `allowed_` is used as prefix to avoid any misconceptions when reading through the helpers code.

  ```rb
  # example of argument definition using allowed_values
  size: arg(
    allowed_values: [:small, :medium, :large]
  )

  # argument value in use
  {
    size: :medium
  } 
  ```

  To support boolean arguments, use the following approach for definition:

  ```rb
  boolean_argument: arg(
    allowed_values: [true, false]
  )
  ```

- `default`: specifies the default value of an argument. This value is used to fill the `argument_values` hash when the value is missing or invalid. If a `default` key is not present in an argument defintion, that argument is considered required.
- `deprecation`: can be used to generate deprecation warnings for the entire property, or especific values.
  - `argument`: boolean that defaults to `false`. If `true`, the entire argument is considered deprecated.
  - `deprecated_values`: array of values deprecated. They're used to validate an argument value, include the deprecated values, but generating warning messages.
  - `type`: used to deprecate a type when the argument has to change types.
  - `warn_message`: custom warn message to be added on top of the default deprecation message generated by the responsive helpers.

In case the component is responsive (has `:responsive` set to `:yes` or `:transitional`), a set of keys representing the responsive variants is available for the argument definition: `v_narrow`, `v_regular`, and `v_wide`. For each variant (viewport range), the following configuration keys are available:
- `additional_allowed_values`: works like the base `allowed_values`, but will add to the current `allowed_values` list if it's set in the base definition.
- `default`: defines a default per responsive variant. It has precedence over the base `default` value.
> _note_: responsive definitions cannot contain a `type`. If the base definition uses a `type`, that means that all responsive variants will be of the same type.

### Sharing arguments definition

Arguments definition can be shared by composition or by inheritance.

#### Composition
Since the entire argument definition is a simple Hash, it's possible to create modules holding a base definition that can be reused by many custom responsive components. The only method required to define the hash structure is `arg()`, which is conveniently declared as a `module_function` of the `ArgumentsDefinitionHelper` module.

```rb
module //TODO 
```

#### Inheritance
Another available option is to define arguments using the `add_arguments_definition()` method. It will merge the arguments defined in the parent class with the definition of the current class, however the definition has to exist in the parent class directly. This is only recommended if the parent definition is treated as an abstract class.
_TODO_

## Responsive class map
_TODO_

## HTML Tags and Attributes
_TODO_