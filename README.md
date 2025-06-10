<p align="center">
  <img width="300px" alt="Primer ViewComponents Logo" src="/static/assets/view-components.svg">
</p>

<h1 align="center">Primer ViewComponents</h1>

<p align="center">ViewComponents for the Primer Design System.</p>

_Note: This library is under active pre-1.0 development. Breaking changes are likely in patch releases._

## Installation

### Quick start for Rails with Vite

```bash
# Add the gem
bundle add primer_view_components

# Install npm packages
yarn add @primer/view-components @primer/css

# Import CSS (in app/assets/stylesheets/application.css)
echo '@import "@primer/css";' >> app/assets/stylesheets/application.css

# Import JavaScript (in app/javascript/application.js)  
echo "import '@primer/view-components'" >> app/javascript/application.js
```

Then use components in your views:

```erb
<%= render(Primer::Button.new) { "Hello Primer!" } %>
```

For detailed installation instructions, including setup for different Rails configurations, see [docs/installation.md](docs/installation.md).

## Documentation

Visit [https://primer.style/components/](https://primer.style/components/) to view documentation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
