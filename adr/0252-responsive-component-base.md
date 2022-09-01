# Responsive Components

The `ResponsiveComponent` adds support for creating viewport range-based responsive component, in a similar way `Primer::Component` adds support for Primer CSS utility classes.

## Context

The [Primer Responsive ADR](https://github.com/github/primer/blob/main/adrs/2022-04-15-responsive-design-api-guidelines.md) explains the reason to move away from CSS utility classes into a component based CSS approach. This adds a higher level of decisions to the components, since now they can be used considering viewport ranges instead of breakpoints.

This makes it easier to define specific behaviors for each viewport range and support different kinds of affordances based on the user's devince.

However, since now components will have its own set of CSS classes, handling conditional classes by the component's properties can be really complex and increase the development time a lot.

## Current state

Inside Primer, the current responsive components are being created with a "class map" per property. Taking the new `PageLayout` as example, the way the classes are conditionally added is tied to the possible values a property can assume.  For instance:

https://github.com/github/github/blob/11382f7b2f89914863f64b85e7d880d5b6c1159f/app/components/primer/experimental/page_layout.rb#L31-L37

```rb
  INNER_SPACING_DEFAULT = :none
    INNER_SPACING_DEFAULT =>   "",
    :normal => "PageLayout--innerSpacing-normal",
    :condensed => "PageLayout--innerSpacing-condensed"
  }.freeze
  INNER_SPACING_OPTIONS = INNER_SPACING_MAPPINGS.keys.freeze
```

Then, to use the class in the component, the `fetch_or_fallback` requires biding, the map, the property value, and its default option:
```rb
  INNER_SPACING_MAPPINGS[fetch_or_fallback(INNER_SPACING_OPTIONS, inner_spacing INNER_SPACING_DEFAULT)],
```

This process can get really complicated when more properties and classes are added, especially if the property has to be responsive, meaning that it can have different values based on the viewport range. For instance, the header divider of the `PageLayout`:

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

And to use the responsive classes for the header divider, it still can be conditionally added like so:

```rb
# simplifying the class_names call:
class_names(
  { HEADER_DIVIDER_NARROW_MAPPINGS[fetch_or_fallback(HEADER_DIVIDER_NARROW_OPTIONS, divider_when_narrow, HEADER_DIVIDER_NARROW_DEFAULT)] => divider != :none },
  HEADER_DIVIDER_MAPPINGS[fetch_or_fallback(HEADER_DIVIDER_OPTIONS, divider, HEADER_DIVIDER_DEFAULT)],
)
```

### Problems with the current approach

The current approach doesn't provide any support to handle responsive properties, making the process to develop responsive components really tedious and results in a code quite complicated to parse at first glance.

The `ResponsiveComponent` adds helper functions and structure to remove the boilerplate out of the way.

## Design philosphy

When designing the `ResponsiveComponent` base class, the main goal was to make its usage explicit the least intrusive possible. All the main logic to handle each problem encountered is split into its own module and can be used by any component, even if it doesn't inherit directly from `ResponsiveComponent`.

The main problems that have to be solved:
- Component properties with a value space that is easy to work with, validate, and supports default values and fallback.
- Deprecation to values or entire properties
- Component support for responsive variants based on the responsive viewport ranges defined in Primer Responsive ADR
- Validate values and values structure when working with multiple properties
- Use the current property values of a component to derive an "applied" class map
- Still support html attributes and tags defined by the consumer of the component if necessary

## Responsive support overview

To keep things reusable, inside `app/lib/primer` a `responsive` folder holds all helpers responsible to remove the boilerplate:

 - `responsive/property_definition.rb`: 
    contains classes to handle component's property definitions. It adds support for responsive properties, property value validation, property default values, and property deprecation.
- `responsive/properties_definition_helper.rb`:
- `responsive/style_class_map_helper.rb`:
- `html_attributes_helper.rb`:



## Responsive properties

```rb
class CustomComponent < Primer::Alpha::ResponsiveComponent
  arguments_definition(
    id: prop(
      type: Numeric,
      default: 0
    ),
    # defines a responsive property
    position: prop(
      responsive: :yes
      allowed_values: [:top, :right, :bottom, :left],
      # defines details for the narrow viewport range (v stands for viewport)
      v_narrow: {
        # this adds more options to the base allowed values
        allowed_values: [:center],
        default: :center
      },
      v_regular: {
        default: :top
      }
    )
  )

  def initialize(property_values: {}, html_attributes: {})
    # initialize property_values and html_attributes while adding test attrs
    super

    # normalizes the @property_values, filling defaults and making invalid values set to default
    normalize_values!
  end
end
```



## Responsive class map

## How to use it