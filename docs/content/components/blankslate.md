---
title: Blankslate
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/blankslate_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-blankslate-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.

## Accessibility

`BlankSlate` renders an `<h3>` element for the title by default. Update the heading level based on what is appropriate for your page hierarchy by setting `title_tag`.
[Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)

## Examples

### Basic

<Example src="<div class='blankslate'>    <h3 class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  title: "Title",
  description: "Description",
) %>
```

### Icon

Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.

<Example src="<div class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' height='32' width='32' class='octicon octicon-octoface blankslate-icon'>    <path d='M7.75 11c-.69 0-1.25.56-1.25 1.25v1.5a1.25 1.25 0 102.5 0v-1.5C9 11.56 8.44 11 7.75 11zm1.27 4.5a.469.469 0 01.48-.5h5a.47.47 0 01.48.5c-.116 1.316-.759 2.5-2.98 2.5s-2.864-1.184-2.98-2.5zm7.23-4.5c-.69 0-1.25.56-1.25 1.25v1.5a1.25 1.25 0 102.5 0v-1.5c0-.69-.56-1.25-1.25-1.25z'></path><path fill-rule='evenodd' d='M21.255 3.82a1.725 1.725 0 00-2.141-1.195c-.557.16-1.406.44-2.264.866-.78.386-1.647.93-2.293 1.677A18.442 18.442 0 0012 5c-.93 0-1.784.059-2.569.17-.645-.74-1.505-1.28-2.28-1.664a13.876 13.876 0 00-2.265-.866 1.725 1.725 0 00-2.141 1.196 23.645 23.645 0 00-.69 3.292c-.125.97-.191 2.07-.066 3.112C1.254 11.882 1 13.734 1 15.527 1 19.915 3.13 23 12 23c8.87 0 11-3.053 11-7.473 0-1.794-.255-3.647-.99-5.29.127-1.046.06-2.15-.066-3.125a23.652 23.652 0 00-.689-3.292zM20.5 14c.5 3.5-1.5 6.5-8.5 6.5s-9-3-8.5-6.5c.583-4 3-6 8.5-6s7.928 2 8.5 6z'></path></svg>    <h3 class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: "octoface",
  title: "Title",
  description: "Description",
) %>
```

### Loading

Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.

<Example src="<div class='blankslate'>    <svg style='box-sizing: content-box; color: var(--color-icon-primary);' viewBox='0 0 16 16' fill='none' width='64' height='64' class='mb-3 anim-rotate'>  <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />  <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg>    <h3 class='mb-1'>Title</h3>    <p>Description</p>  </div>" />

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

<Example src="<div class='blankslate'>    <h3 class='mb-1'>Title</h3>    <em>Your custom content here</em></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  title: "Title",
) do %>
  <em>Your custom content here</em>
<% end %>
```

### Action button

Provide a button to guide users to take action from the blankslate. The button appears below the description and custom content.

<Example src="<div class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' height='32' width='32' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>      <a class='btn btn-primary my-3' href='https://github.com/monalisa/mona/wiki/_new'>Create the first page</a></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: "book",
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",

  button_text: "Create the first page",
  button_url: "https://github.com/monalisa/mona/wiki/_new",
) %>
```

### Link

Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:

<Example src="<div class='blankslate'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' height='32' width='32' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>      <p>      <a href='https://docs.github.com/en/github/building-a-strong-community/about-wikis'>Learn more about wikis</a>    </p></div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: "book",
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  link_text: "Learn more about wikis",
  link_url: "https://docs.github.com/en/github/building-a-strong-community/about-wikis",
) %>
```

### Variations

There are a few variations of how the Blankslate appears: `narrow` adds a maximum width, `large` increases the font size, and `spacious` adds extra padding.

<Example src="<div class='blankslate blankslate-narrow blankslate-large blankslate-spacious'>    <svg aria-hidden='true' viewBox='0 0 24 24' version='1.1' height='32' width='32' class='octicon octicon-book blankslate-icon'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h3 class='mb-1'>Welcome to the mona wiki!</h3>    <p>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</p>  </div>" />

```erb
<%= render Primer::BlankslateComponent.new(
  icon: "book",
  title: "Welcome to the mona wiki!",
  description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  narrow: true,
  large: true,
  spacious: true,
) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `title` | `String` | `""` | Text that appears in a larger bold font. |
| `title_tag` | `Symbol` | `:h3` | HTML tag to use for title. |
| `icon` | `String` | `""` | Octicon icon to use at top of component. |
| `icon_size` | `Symbol` | `:medium` | One of `:small` (`16`), `:medium` (`32`), or `:large` (`64`). |
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

## Slots

### `Spinner`

Optional Spinner.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Spinner](/components/spinner). |

