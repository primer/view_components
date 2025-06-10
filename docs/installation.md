# Installation

This guide covers how to install and configure Primer ViewComponents in different Ruby on Rails environments.

## Rails with Asset Pipeline

For traditional Rails applications using the Asset Pipeline:

### 1. Add the gem

Add the gem to your `Gemfile`:

```ruby
gem "primer_view_components"
```

Then run:

```bash
bundle install
```

### 2. Add JavaScript (if using components with behavior)

Some components require JavaScript for full functionality. Add this to your `app/assets/javascripts/application.js`:

```javascript
//= require primer_view_components
```

### 3. Add CSS

Component styles are included automatically when using the gem with the Asset Pipeline.

## Rails with Vite

For Rails applications using Vite (via vite-ruby or similar):

### 1. Add the gem

Add the gem to your `Gemfile`:

```ruby
gem "primer_view_components"
```

Then run:

```bash
bundle install
```

### 2. Install npm packages

You'll need to install the npm packages for JavaScript behaviors and CSS:

```bash
# Using npm
npm install @primer/view-components

# Using yarn
yarn add @primer/view-components
```

For styling, you have two options:

#### Option A: Use Primer CSS (recommended)

Install the full Primer CSS framework:

```bash
# Using npm
npm install @primer/css @primer/primitives

# Using yarn  
yarn add @primer/css @primer/primitives
```

Then import in your main CSS file (e.g., `app/assets/stylesheets/application.css`):

```css
@import "@primer/css";
```

#### Option B: Use only ViewComponents CSS

If you only want the CSS for the ViewComponents without the full Primer CSS framework:

```css
@import "@primer/view-components/app/assets/styles/primer_view_components.css";
```

**Note:** This option requires CSS custom properties to be defined. You may need to also import CSS custom properties from `@primer/primitives`:

```bash
# Install primitives for CSS custom properties
npm install @primer/primitives
```

```css
/* Import CSS custom properties */
@import "@primer/primitives/dist/css/base/typography/typography.css";
@import "@primer/primitives/dist/css/functional/themes/light.css";
/* Add other primitive imports as needed */

/* Then import ViewComponents styles */
@import "@primer/view-components/app/assets/styles/primer_view_components.css";
```

### 3. Add JavaScript

Import the JavaScript behaviors in your main JavaScript file (e.g., `app/javascript/application.js`):

```javascript
import '@primer/view-components'
```

For selective imports of specific components:

```javascript
// Import only specific components
import '@primer/view-components/ActionListElement'
import '@primer/view-components/ToggleSwitchElement'
```

## Rails with other bundlers (Webpack, ESBuild, etc.)

The setup is similar to the Vite configuration:

1. Add the gem to your `Gemfile`
2. Install the npm package: `@primer/view-components`
3. Import CSS in your stylesheets
4. Import JavaScript in your main JS file

## Verifying installation

After installation, you can verify everything is working by using a simple component in your views:

```erb
<%= render(Primer::Button.new) { "Hello Primer!" } %>
```

If styles are applied correctly, you should see a styled button. If JavaScript behaviors are working, interactive components like toggles and dialogs should function properly.

## Troubleshooting

### Styles not showing

1. **Missing CSS import**: Ensure you've imported either `@primer/css` or the ViewComponents CSS file
2. **Missing CSS custom properties**: If using only ViewComponents CSS, ensure you have the required CSS custom properties from `@primer/primitives`
3. **CSS not compiling**: Check your bundler configuration and ensure CSS processing is set up correctly

### JavaScript behaviors not working

1. **Missing JavaScript import**: Ensure you've imported `@primer/view-components` in your JavaScript
2. **Import order**: Make sure the JavaScript is imported after the DOM is ready
3. **Check browser console**: Look for JavaScript errors that might indicate missing dependencies

### CSS custom properties errors

If you see CSS errors about undefined custom properties (CSS variables starting with `--`), you need to import the CSS custom properties:

```css
/* Import required CSS custom properties */
@import "@primer/primitives/dist/css/base/typography/typography.css";
@import "@primer/primitives/dist/css/functional/themes/light.css";
@import "@primer/primitives/dist/css/functional/themes/dark.css"; /* if supporting dark mode */
```

For a complete list of available CSS imports from primitives, check the [@primer/primitives documentation](https://www.npmjs.com/package/@primer/primitives).

## Next steps

* Browse available components in the [Lookbook](https://primer.style/components/)
* Read the [component documentation](https://primer.style/components/)
* Check out [component examples and usage patterns](https://primer.style/components/)
