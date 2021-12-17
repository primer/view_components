---
title: Blankslate
componentId: blankslate
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/blankslate.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-blankslate
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.

## Accessibility

- Set the `heading` level based on what is appropriate for your page hierarchy. [Learn more about best heading practices (WAI Headings)](https://www.w3.org/WAI/tutorials/page-structure/headings/)
- `secondary_action` can be set to provide more information that is relevant in the context of the `Blankslate`.
- `secondary_action` text should be meaningful out of context and clearly describe the destination. Avoid using vague text like, "Learn more" or "Click here".

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `narrow` | `Boolean` | `false` | Adds a maximum width of `485px` to the Blankslate. |
| `spacious` | `Boolean` | `false` | Increases the padding from `32px` to `80px 40px`. |
| `border` | `Boolean` | `false` | Adds a border around the Blankslate. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Visual`

Optional visual.

Use:

- `visual_icon` for an [Octicon](/components/octicon).
- `visual_image` for an [Image](/components/image).
- `visual_spinner` for a [Spinner](/components/spinner).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Heading`

Required heading.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `String` | N/A | One of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, or `:h6`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Description`

Optional description.

- The description should always be informative and actionable.
- Don't use phrases like "You can".

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Primary_action`

Optional primary action

The `primary_action` slot renders an anchor link which is visually styled as a button to provide more emphasis to the
Blankslate's primary action.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | URL to be used for the primary action. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Secondary_action`

Optional secondary action

The `secondary_action` slot renders a normal anchor link, which can be used to redirect the user to additional information
(e.g. Help documentation).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | URL to be used for the secondary action. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Basic

<Example src="  <div data-view-component='true' class='blankslate'>        <h2 data-view-component='true' class='h2 mb-1'>Title</h2>    <div data-view-component='true'>Description</div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.heading(tag: :h2).with_content("Title") %>
  <% c.description { "Description"} %>
<% end %>
```

### Icon

Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.

<Example src="  <div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-globe blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M12 1C5.925 1 1 5.925 1 12s4.925 11 11 11 11-4.925 11-11S18.075 1 12 1zM2.513 11.5h4.745c.1-3.037 1.1-5.49 2.093-7.204.39-.672.78-1.233 1.119-1.673C6.11 3.329 2.746 7 2.513 11.5zm4.77 1.5H2.552a9.505 9.505 0 007.918 8.377 15.698 15.698 0 01-1.119-1.673C8.413 18.085 7.47 15.807 7.283 13zm1.504 0h6.426c-.183 2.48-1.02 4.5-1.862 5.951-.476.82-.95 1.455-1.304 1.88L12 20.89l-.047-.057a13.888 13.888 0 01-1.304-1.88C9.807 17.5 8.969 15.478 8.787 13zm6.454-1.5H8.759c.1-2.708.992-4.904 1.89-6.451.476-.82.95-1.455 1.304-1.88L12 3.11l.047.057c.353.426.828 1.06 1.304 1.88.898 1.548 1.79 3.744 1.89 6.452zm1.476 1.5c-.186 2.807-1.13 5.085-2.068 6.704-.39.672-.78 1.233-1.118 1.673A9.505 9.505 0 0021.447 13h-4.731zm4.77-1.5h-4.745c-.1-3.037-1.1-5.49-2.093-7.204-.39-.672-.78-1.233-1.119-1.673 4.36.706 7.724 4.377 7.957 8.877z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Title</h2>    <div data-view-component='true'>Description</div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_icon(icon: :globe) %>
  <% c.heading(tag: :h2).with_content("Title") %>
  <% c.description { "Description"} %>
<% end %>
```

### Loading

Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.

<Example src="  <div data-view-component='true' class='blankslate'>    <span role='status'>  <span class='sr-only'>Loading</span>  <svg style='box-sizing: content-box; color: var(--color-icon-primary);' width='64' height='64' viewBox='0 0 16 16' fill='none' data-view-component='true' class='mb-3 anim-rotate'>    <circle cx='8' cy='8' r='7' stroke='currentColor' stroke-opacity='0.25' stroke-width='2' vector-effect='non-scaling-stroke' />    <path d='M15 8a7.002 7.002 0 00-7-7' stroke='currentColor' stroke-width='2' stroke-linecap='round' vector-effect='non-scaling-stroke' /></svg></span>    <h2 data-view-component='true' class='h2 mb-1'>Title</h2>    <div data-view-component='true'>Description</div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_spinner(size: :large) %>
  <% c.heading(tag: :h2).with_content("Title") %>
  <% c.description { "Description"} %>
<% end %>
```

### Using an image

Add an `image` to give context that an Octicon couldn't.

<Example src="  <div data-view-component='true' class='blankslate'>    <img src='https://github.githubassets.com/images/modules/site/features/security-icon.svg' size='56x56' alt='Security - secure vault' data-view-component='true' class='mb-3' />    <h2 data-view-component='true' class='h2 mb-1'>Title</h2>    <div data-view-component='true'>Description</div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault") %>
  <% c.heading(tag: :h2).with_content("Title") %>
  <% c.description { "Description"} %>
<% end %>
```

### Custom content

Pass custom content to `description`.

<Example src="  <div data-view-component='true' class='blankslate'>        <h2 data-view-component='true' class='h2 mb-1'>Title</h2>    <div data-view-component='true'>    <em>Your custom content here</em></div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.heading(tag: :h2).with_content("Title") %>
  <% c.description do %>
    <em>Your custom content here</em>
  <% end %>
<% end %>
```

### Primary action

Provide a `primary_action` to guide users to take action from the blankslate. The `primary_action` appears below the description and custom content.

<Example src="  <div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-book blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Welcome to the mona wiki!</h2>    <div data-view-component='true'>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</div>    <a href='https://github.com/monalisa/mona/wiki/_new' data-view-component='true' class='btn-primary btn mt-5'>  Create the first page</a></div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_icon(icon: :book) %>
  <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
  <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
  <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
<% end %>
```

### Secondary action

Add an additional `secondary_action` to help users learn more about a feature. See [Accessibility](#accessibility). `secondary_action` will be shown at the very bottom:

<Example src="  <div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-book blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Welcome to the mona wiki!</h2>    <div data-view-component='true'>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</div>          <div class='mt-3'>        <a href='https://docs.github.com/en/github/building-a-strong-community/about-wikis' data-view-component='true' class='p-3'>Learn more about wikis</a>      </div></div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_icon(icon: :book) %>
  <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
  <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
  <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
<% end %>
```

### Primary and secondary actions

`primary_action` and `secondary_action` can also be used together. The `primary_action` will always be rendered before the `secondary_action`:

<Example src="  <div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-book blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Welcome to the mona wiki!</h2>    <div data-view-component='true'>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</div>    <a href='https://github.com/monalisa/mona/wiki/_new' data-view-component='true' class='btn-primary btn mt-5'>  Create the first page</a>      <div class='mt-3'>        <a href='https://docs.github.com/en/github/building-a-strong-community/about-wikis' data-view-component='true' class='p-3'>Learn more about wikis</a>      </div></div>" />

```erb
<%= render Primer::Beta::Blankslate.new do |c| %>
  <% c.visual_icon(icon: :book) %>
  <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
  <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
  <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
  <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
<% end %>
```

### Variations

There are a few variations of how the Blankslate appears: `narrow` adds a maximum width of `485px`, and `spacious` increases the padding from `32px` to `80px 40px`.

<Example src="  <div data-view-component='true' class='blankslate blankslate-narrow blankslate-spacious'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-book blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Welcome to the mona wiki!</h2>    <div data-view-component='true'>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</div>    </div>" />

```erb
<%= render Primer::Beta::Blankslate.new(
  narrow: true,
  spacious: true,
) do |c| %>
  <% c.visual_icon(icon: :book) %>
  <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
  <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
<% end %>
```

### With border

It's possible to add a border around the Blankslate. This will wrap the Blankslate in a BorderBox.

<Example src="<div class='Box'>  <div data-view-component='true' class='blankslate'>    <svg aria-hidden='true' height='24' viewBox='0 0 24 24' version='1.1' width='24' data-view-component='true' class='octicon octicon-book blankslate-icon mb-3'>    <path fill-rule='evenodd' d='M0 3.75A.75.75 0 01.75 3h7.497c1.566 0 2.945.8 3.751 2.014A4.496 4.496 0 0115.75 3h7.5a.75.75 0 01.75.75v15.063a.75.75 0 01-.755.75l-7.682-.052a3 3 0 00-2.142.878l-.89.891a.75.75 0 01-1.061 0l-.902-.901a3 3 0 00-2.121-.879H.75a.75.75 0 01-.75-.75v-15zm11.247 3.747a3 3 0 00-3-2.997H1.5V18h6.947a4.5 4.5 0 012.803.98l-.003-11.483zm1.503 11.485V7.5a3 3 0 013-3h6.75v13.558l-6.927-.047a4.5 4.5 0 00-2.823.971z'></path></svg>    <h2 data-view-component='true' class='h2 mb-1'>Welcome to the mona wiki!</h2>    <div data-view-component='true'>Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.</div>    </div></div>" />

```erb
<%= render Primer::Beta::Blankslate.new(border: true) do |c| %>
  <% c.visual_icon(icon: :book) %>
  <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
  <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
<% end %>
```
