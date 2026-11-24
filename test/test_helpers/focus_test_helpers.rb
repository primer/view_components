# frozen_string_literal: true

module Primer
  module FocusTestHelpers
    def with_dimmed_theme(mode, preference: nil)
      if preference
        skip "Color-scheme emulation requires the Chrome system-test driver" unless Primer::DriverTestHelpers.chrome?

        browser_page = page.driver.browser.page
        browser_page.command("Emulation.setEmulatedMedia", features: [{ name: "prefers-color-scheme", value: preference }])
      end

      if mode == :light
        execute_script(<<~JS)
          // Reuse the installed dimmed tokens for a consumer's fixed-light mapping.
          const theme = Array.from(document.styleSheets)
            .flatMap(sheet => Array.from(sheet.cssRules))
            .find(rule => rule.selectorText?.includes('[data-dark-theme="dark_dimmed"]') &&
              rule.style.getPropertyValue('--focus-outlineColor'))
          if (!theme) throw new Error('The dimmed Primitives theme is missing')
          const style = document.createElement('style')
          style.textContent = `[data-color-mode='light'][data-light-theme='dark_dimmed'] { ${theme.style.cssText} }`
          document.head.appendChild(style)
        JS
      end

      execute_script(<<~JS, mode.to_s)
        document.documentElement.setAttribute('data-color-mode', arguments[0])
        document.documentElement.setAttribute('data-light-theme', 'dark_dimmed')
        document.documentElement.setAttribute('data-dark-theme', 'dark_dimmed')
      JS
      assert_selector "html[data-color-mode='#{mode}']"
      assert evaluate_script("matchMedia('(prefers-color-scheme: #{preference})').matches") if preference
      yield
    ensure
      browser_page&.command("Emulation.setEmulatedMedia", features: [])
    end

    def focus_styles(selector)
      evaluate_multiline_script(<<~JS)
        const control = document.querySelector(#{selector.to_json})
        const style = getComputedStyle(control)
        const offset = Number.parseFloat(style.outlineOffset)
        let ancestor = control.parentElement

        while (ancestor) {
          const background = getComputedStyle(ancestor)
          if (background.backgroundImage !== 'none') {
            throw new Error('Expected the adjacent focus canvas to have no background image')
          }
          if (background.backgroundColor !== 'rgba(0, 0, 0, 0)') {
            return {
              offset,
              width: Number.parseFloat(style.outlineWidth),
              style: style.outlineStyle,
              color: style.outlineColor,
              outerColor: background.backgroundColor,
              // Without the gap, the selected border touches the outline.
              innerColor: offset > 0 ? background.backgroundColor : style.borderTopColor,
            }
          }
          ancestor = ancestor.parentElement
        }
        throw new Error('The preview has no opaque adjacent canvas')
      JS
    end

    def contrast_ratio(first, second)
      lower, higher = [luminance(first), luminance(second)].minmax
      (higher + 0.05) / (lower + 0.05)
    end

    def luminance(color)
      match = /\Argb\((\d+),\s*(\d+),\s*(\d+)\)\z/.match(color)
      raise ArgumentError, "Expected an opaque RGB color, received #{color}" unless match

      channels = match.captures.map do |channel|
        value = channel.to_f / 255
        value <= 0.04045 ? value / 12.92 : ((value + 0.055) / 1.055)**2.4
      end

      0.2126 * channels[0] + 0.7152 * channels[1] + 0.0722 * channels[2]
    end
  end
end
