# Playwright MCP Testing Skill

This skill provides guidance on using the Playwright MCP server for testing UI components in primer/view_components.

## When to Use Playwright MCP

Use Playwright MCP when:
- Making changes to component rendering (`.rb` files in `app/components/` or `html.erb` files)
- Modifying component styles (`.pcss` files)
- Updating component JavaScript/TypeScript behavior
- Adding new components or component variants
- Fixing visual bugs or accessibility issues

## Repository Setup

### Demo Application
The demo app runs at `http://127.0.0.1:4000` and provides component previews.

### Preview URLs
Component previews follow this pattern:
```
http://127.0.0.1:4000/rails/view_components/{component_path}
```

For example:
- Button: `/rails/view_components/primer/beta/button/default`
- ActionMenu: `/rails/view_components/primer/alpha/action_menu/default`

### Theme Testing
Add `?theme={theme_name}` to test different themes:
- `light`, `dark`, `dark_dimmed`
- `light_colorblind`, `dark_colorblind`
- `light_high_contrast`, `dark_high_contrast`
- `all` - Shows all themes at once

## Using Playwright MCP

### Starting the Demo Server
Before using Playwright MCP, ensure the demo server is running:
```bash
script/dev
```

### Common Playwright MCP Actions

#### 1. Test Interactions
```
Click the interactive element(s) and take a screenshot of the result
```

#### 2. Check Accessibility
```
Get the accessibility tree/ARIA snapshot of the component
```

#### 3. Test Focus States
```
Press Tab to focus interactive elements, then take a screenshot
```

## Existing Test Structure

### Test Files
- `test/playwright/snapshots.test.ts` - Main snapshot tests
- `test/playwright/helpers.ts` - Test utilities

### Snapshot Storage
- Visual snapshots: `.playwright/screenshots/`
- ARIA snapshots: `.playwright/screenshots/*/aria-snapshot.yml`

## Running Existing Tests

```bash
# Run all Playwright tests
npx playwright test

# Run specific test file
npx playwright test test/playwright/snapshots.test.ts

# Update snapshots
npx playwright test --update-snapshots
```

## Tips for PR Authors

1. **Before submitting**: Use Playwright MCP to visually verify your component changes
1. **Test interactions**: For interactive components, verify hover, focus, and active states
1. **Accessibility**: Ensure ARIA snapshots remain valid after your changes
1. **Screenshots**: If visual changes are intentional, the PR should include updated snapshots