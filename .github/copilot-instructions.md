# Copilot Instructions for primer/view_components

This repository contains ViewComponents for the Primer Design System used by GitHub.

## Key Context

- **Framework**: Ruby on Rails ViewComponents with TypeScript/JavaScript
- **Testing**: Uses Playwright for visual regression and accessibility testing
- **Demo App**: Runs on port 4000 via `script/dev`

## When Making UI Changes

If your changes affect the visual appearance or behavior of a component:

1. Consider running Playwright tests to verify visual snapshots
2. Check ARIA snapshots for accessibility compliance
3. Test across all supported themes (light, dark, high contrast, colorblind variants)

## Playwright MCP Available

This repository has Playwright MCP configured. When working on UI-facing changes, you can use the Playwright MCP to:

- Navigate to component previews at `/rails/view_components/{component_path}`
- Take screenshots for visual verification
- Interact with components to test behavior
- Verify accessibility through ARIA snapshots

See `.github/agents/playwright-testing.md` for detailed guidance.