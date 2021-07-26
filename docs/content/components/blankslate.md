---
title: Blankslate
componentId: blankslate
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/blankslate_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-blankslate-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.

## Accessibility

`Blankslate` renders an `<h3>` element for the title by default. Update the heading level based on what is appropriate for your page hierarchy by setting `title_tag`.
[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | `""` | Text that appears in a larger bold font. |
| `title_tag` | `Symbol` | `:h3` | HTML tag to use for title. |
| `icon` | `Symbol` | `""` | Octicon icon to use at top of component. |
| `icon_size` | `Symbol` | `:medium` | One of `:small` (`16`) and `:medium` (`24`). |
| `image_src` | `String` | `""` | Image to display. |
| `image_alt` | `String` | `" "` | Alt text for image. |
| `description` | `String` | `""` | Text that appears below the title. Typically a whole sentence. |
| `button_text` | `String` | `""` | The text of the button. |
| `button_url` | `String` | `""` | The URL where the user will be taken after clicking the button. |
| `button_classes` | `String` | `"btn-primary my-3"` | Classes to apply to action button |
| `link_text` | `String` | `""` | The text of the link. |
| `link_url` | `String` | `""` | The URL where the user will be taken after clicking the link. |
| `narrow` | `Boolean` | `false` | Adds a maximum width. |
| `large` | `Boolean` | `false` | Increases the font size. |
| `spacious` | `Boolean` | `false` | Adds extra padding. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Spinner`

Optional Spinner.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Spinner](/components/spinner). |

## Examples

### Basic

<Example src="<div data-view-component='true' class='blankslate'>    <h3 data-view-component='true' class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  title: "Title",
  description: "Description",
) %>
```

### Icon

Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.

<Example src="<div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' data-view-component='true' height='24' width='24' class='octicon octicon-globe blankslate-icon'>    <path fill-rule='evenodd' d='M12 1C5.925 1 1 5.925 1 12s4.925 11 11 11 11-4.925 11-11S18.075 1 12 1zM2.513 11.5h4.745c.1-3.037 1.1-5.49 2.093-7.204.39-.672.78-1.233 1.119-1.673C6.11 3.329 2.746 7 2.513 11.5zm4.77 1.5H2.552a9.505 9.505 0 007.918 8.377 15.698 15.698 0 01-1.119-1.673C8.413 18.085 7.47 15.807 7.283 13zm1.504 0h6.426c-.183 2.48-1.02 4.5-1.862 5.951-.476.82-.95 1.455-1.304 1.88L12 20.89l-.047-.057a13.888 13.888 0 01-1.304-1.88C9.807 17.5 8.969 15.478 8.787 13zm6.454-1.5H8.759c.1-2.708.992-4.904 1.89-6.451.476-.82.95-1.455 1.304-1.88L12 3.11l.047.057c.353.426.828 1.06 1.304 1.88.898 1.548 1.79 3.744 1.89 6.452zm1.476 1.5c-.186 2.807-1.13 5.085-2.068 6.704-.39.672-.78 1.233-1.118 1.673A9.505 9.505 0 0021.447 13h-4.731zm4.77-1.5h-4.745c-.1-3.037-1.1-5.49-2.093-7.204-.39-.672-.78-1.233-1.119-1.673 4.36.706 7.724 4.377 7.957 8.877z'></path></svg>    <h3 data-view-component='true' class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: :globe,
  title: "Title",
  description: "Description",
) %>
```

### Loading

Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.

<Example src="<div data-view-component='true' class='blankslate'>    <svg style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' data-view-component='true' width='64' height='64' class='mb-3 anim-rotate'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg>    <h3 data-view-component='true' class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  title: "Title",
  description: "Description",
) do |component| %>
  <% component.spinner(size: :large) %>
<% end %>
```

### Custom content

Pass custom content as a block in place of `description`.

<Example src="<div data-view-component='true' class='blankslate'>    <h3 data-view-component='true' class='mb-1'>Title</h3>    <em>Your custom content here</em></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  title: "Title",
) do %>
  <em>Your custom content here</em>
<% end %>
```

### Action button

Provide a button to guide users to take action from the blankslate. The button appears below the description and custom content.

<Example src="<div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' data-view-component='true' height='24' width='24' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 data-view-component='true' class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>      <a class='btn btn-primary my-3' href='https://github.com/monalisa/mona/wiki/_new'>Create the first page</a></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: :book,
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",

  button_text: "Create the first page",
  button_url: "https://github.com/monalisa/mona/wiki/_new",
) %>
```

### Link

Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:

<Example src="<div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' data-view-component='true' height='24' width='24' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 data-view-component='true' class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>      <p>      <a href='https://docs.github.com/en/github/building-a-strong-community/about-wikis'>Learn more about wikis</a>    </p></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: :book,
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  link_text: "Learn more about wikis",
  link_url: "https://docs.github.com/en/github/building-a-strong-community/about-wikis",
) %>
```

### Variations

There are a few variations of how the Blankslate appears: `narrow` adds a maximum width, `large` increases the font size, and `spacious` adds extra padding.

<Example src="<div data-view-component='true' class='blankslate blankslate-narrow blankslate-large blankslate-spacious'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' data-view-component='true' height='24' width='24' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 data-view-component='true' class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: :book,
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  narrow: true,
  large: true,
  spacious: true,
) %>
```
