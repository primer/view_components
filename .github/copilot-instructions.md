# Copilot Instructions for OpenProject Primer ViewComponents

## Repository Context

This repository is **a fork of GitHub's Primer ViewComponents** (`primer/view_components`), which we've extended to meet OpenProject's specific needs. We maintain compatibility with the upstream Primer Design System while adding our own OpenProject-specific components.

**Key Points:**
- We follow the Primer Design System's patterns and conventions
- We extend the system with OpenProject-specific components in the `open_project` namespace
- We periodically sync with upstream to get new features and improvements
- We use changesets for versioning and releases

**Related Repositories:**
- **Main Consumer**: [opf/openproject](https://github.com/opf/openproject) - The OpenProject application that consumes this library
- **Upstream**: [primer/view_components](https://github.com/primer/view_components) - GitHub's Primer ViewComponents that we fork from
- **Icons**: [opf/openproject-octicons](https://github.com/opf/openproject-octicons) - OpenProject's fork of GitHub Octicons

## Repository Structure

```
app/components/primer/
├── alpha/          # Alpha-status Primer components
├── beta/           # Beta-status Primer components
├── open_project/   # OpenProject-specific components (our extensions)
├── *.rb            # Stable Primer components
└── *.ts/.pcss      # Component JavaScript and styles

test/
├── components/     # Unit tests
├── system/         # System/integration tests
└── playwright/     # Visual regression tests

docs/contributors/  # Contributor documentation
```

## Component Status Levels

Components are classified by maturity:

1. **Alpha** (`app/components/primer/alpha/`) - Early development, API may change
2. **Beta** (`app/components/primer/beta/`) - Mostly stable, minor changes possible
3. **Stable** (`app/components/primer/`) - Production-ready, follows semantic versioning
4. **OpenProject** (`app/components/primer/open_project/`) - Our custom components

When suggesting components, prefer stable components unless specifically asked for alpha/beta features.

## Technology Stack

- **Ruby on Rails**: ViewComponent framework for server-side components
- **Ruby**: 3.2.0+
- **Rails**: 7.2.0+
- **ViewComponent**: 3.1+ to 5.0
- **JavaScript/TypeScript**: Component behaviors using Catalyst controllers
- **PostCSS**: Component styling
- **Lookbook**: Component development and documentation tool
- **Playwright**: Visual regression testing
- **Minitest**: Test framework

## Development Workflow

### Setup
```bash
./script/setup        # Install dependencies
./script/dev          # Start Lookbook on localhost:4000
```

### Creating New Components

**Use the generator:**
```bash
bundle exec thor component_generator my_component_name --status=openproject
```

Options:
- `--status`: `alpha`, `beta`, `stable`, or `openproject` (default: `openproject`)
- `--inline`: Creates `#call` method instead of ERB template
- `--js`: Adds JavaScript/TypeScript file (e.g., `--js=@github/catalyst`)

**The generator creates:**
- `app/components/<status>/<component_name>.rb` - Component class with YARD docs
- `app/components/<status>/<component_name>.html.erb` - Template (unless `--inline`)
- `app/components/<status>/<component_name>.pcss` - Styles
- `app/components/<status>/<component_name>.ts` - JavaScript (if `--js` flag)
- `test/components/<status>/<component_name>_test.rb` - Unit tests
- `test/system/<status>/<component_name>_test.rb` - System tests
- `previews/<status>/<component_name>_preview.rb` - Lookbook previews

### Component Development Guidelines

#### Ruby Component Class

```ruby
module Primer
  module OpenProject
    class MyComponent < Primer::Component
      status :open_project
      
      # Define slots if needed
      renders_one :header
      renders_many :items
      
      # System arguments for HTML attributes
      def initialize(title:, **system_arguments)
        @title = title
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
      end
      
      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
```

#### Tag Restrictions

Always restrict which HTML tags components can render:

```ruby
# Fixed tag
system_arguments[:tag] = :button

# Allowed list with fallback
TAG_OPTIONS = [:h1, :h2, :h3, :h4, :h5, :h6].freeze
DEFAULT_TAG = :h2
system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)
```

#### JavaScript Controllers (Catalyst)

Use Catalyst for component behaviors:

```typescript
import {controller, target} from '@github/catalyst';

@controller
class MyComponentElement extends HTMLElement {
  @target button: HTMLElement
  
  connectedCallback() {
    // Initialize
  }
}

if (!window.customElements.get('my-component')) {
  window.MyComponentElement = MyComponentElement
  window.customElements.define('my-component', MyComponentElement)
}
```

**Remember:** Catalyst controllers require a custom element in the component template.

#### Styling (PostCSS)

```css
/* app/components/primer/open_project/my_component.pcss */
.MyComponent {
  display: flex;
  
  &-header {
    font-weight: bold;
  }
}
```

Styles are automatically imported via `app/components/primer/primer.pcss`.

### Documentation

Write documentation as YARD comments in the component class:

```ruby
# @label MyComponent
#
# Use `MyComponent` for displaying...
#
# @param title [String] The component title
# @param size [Symbol] select [small, medium, large]
class MyComponent < Primer::Component
```

Generate documentation:
```bash
bundle exec rake docs:build
```

## Testing

### Unit Tests

```ruby
class Primer::OpenProject::MyComponentTest < Minitest::Test
  def test_renders_content
    render_inline(Primer::OpenProject::MyComponent.new(title: "Test"))
    assert_selector(".MyComponent")
  end
  
  def test_denies_invalid_tag
    assert_raises ArgumentError do
      Primer::OpenProject::MyComponent.new(title: "Test", tag: :invalid)
    end
  end
end
```

### System Tests

```ruby
class Primer::OpenProject::IntegrationMyComponentTest < ActionDispatch::IntegrationTest
  def test_component_functionality
    visit_preview(:default)
    assert_selector ".MyComponent"
  end
end
```

### Playwright Visual Regression Tests

Add component previews to `static/previews.json`:

```json
{
  "name": "my_component",
  "component": "MyComponent",
  "status": "openproject",
  "lookup_path": "primer/open_project/my_component",
  "examples": [
    {
      "preview_path": "primer/open_project/my_component/default",
      "name": "default",
      "snapshot": "true",
      "skip_rules": {
        "wont_fix": ["region"],
        "will_fix": ["color-contrast"]
      }
    }
  ]
}
```

Run tests:
```bash
./script/test           # All tests
npm test                # JavaScript tests
npm run test:playwright # Visual regression tests
```

## Code Quality

### Linting

```bash
npm run lint                  # Run all linters
npm run lint:eslint          # JavaScript/TypeScript
npm run lint:stylelint       # CSS/PostCSS
./script/rubocop             # Ruby
./script/erblint             # ERB templates
```

Auto-fix issues:
```bash
npm run lint:eslint:fix
npm run lint:stylelint:fix
```

### Building

```bash
npm run build          # Build all assets
npm run build:js       # Build JavaScript only
npm run build:css      # Build CSS only
```

## Changesets (Versioning)

We use changesets for versioning and release notes. **Always add a changeset for user-facing changes:**

```bash
npx changeset
```

Follow prompts to:
1. Select changed packages
2. Choose version bump type (major, minor, patch)
3. Write a user-facing description

**Don't add changesets for:**
- Documentation-only changes
- Internal refactoring
- Test-only changes

## Updating from Upstream

We periodically sync with GitHub's Primer repository. The process:

1. Find the last upstream release commit (before "Release Tracking" commit)
2. Run the merge script:
   ```bash
   ./script/merge-upstream <commit-sha> gsed
   ```
3. Resolve conflicts (usually repository name/version differences)
4. Update `.changeset/` files: replace `@primer/view-components` with `@openproject/primer-view-components`
5. Create PR and ensure CI passes

**Important:** Only update one version at a time to preserve changeset history.

## Code Style Guidelines

### Ruby
- Follow existing Primer patterns and conventions
- Use `status :open_project` for OpenProject components
- Document all public APIs with YARD
- Restrict HTML tags appropriately
- Use `system_arguments` for HTML attributes
- Follow ViewComponent best practices

### JavaScript/TypeScript
- Use Catalyst for interactive components
- Export custom elements properly
- Follow GitHub's JavaScript style guide
- Use TypeScript for type safety

### CSS
- Use BEM-like naming: `.ComponentName-element--modifier`
- Scope styles to component classes
- Use PostCSS features (nesting, mixins)
- Keep styles colocated with components

### ERB Templates
- Keep templates simple and readable
- Use slots for flexible composition
- Avoid complex logic in templates

## Pull Request Guidelines

1. **Run tests** before submitting: `./script/test`
2. **Add changeset** for user-facing changes: `npx changeset`
3. **Write YARD docs** for new components/public methods
4. **Add Lookbook previews** to demonstrate usage
5. **Update `static/previews.json`** for visual regression tests
6. **Ensure linters pass**: `npm run lint && ./script/rubocop`
7. **Keep changes focused** - one feature/fix per PR
8. **Update documentation** if API changes

## Common Tasks

### Add a new dependency

Ruby:
```bash
# Edit Gemfile
bundle install
```

JavaScript (check security first):
```bash
npm install <package>
```

### Regenerate documentation
```bash
bundle exec rake docs:build
```

### Run specific tests
```bash
bundle exec ruby test/components/primer/my_component_test.rb
```

### Debug in Lookbook
1. Start dev server: `./script/dev`
2. Visit http://localhost:4000
3. Navigate to your component preview
4. Make changes and refresh

## Important Conventions

### Naming
- Ruby classes: `PascalCase`
- Files: `snake_case`
- Custom elements: `kebab-case`
- CSS classes: `PascalCase-element--modifier`

### OpenProject Components
- Place in `app/components/primer/open_project/`
- Use `module Primer::OpenProject`
- Set `status :open_project`
- Document clearly that it's OpenProject-specific

### System Arguments
Always support system arguments for HTML attributes:
- `id:`, `class:`, `data:`, `aria:`
- `test_selector:` for testing
- Tag customization where appropriate

## Resources

- [Contributor Docs](./docs/contributors/README.md)
- [Setup Guide](./docs/contributors/setup.md)
- [Adding Components](./docs/contributors/adding-components.md)
- [Testing Guide](./docs/contributors/playwright-testing.md)
- [Updating Fork](./docs/contributors/updating-fork.md)
- [Primer Design System](https://primer.style/design/)
- [ViewComponent Docs](https://viewcomponent.org/)
- [Catalyst Docs](https://catalyst.rocks/)

## Quick Reference

| Task | Command |
|------|---------|
| Setup | `./script/setup` |
| Start dev | `./script/dev` |
| Run tests | `./script/test` |
| Lint | `npm run lint && ./script/rubocop` |
| Generate component | `bundle exec thor component_generator <name> --status=openproject` |
| Add changeset | `npx changeset` |
| Build assets | `npm run build` |
| View docs | Visit http://localhost:4000 |
