import {test, expect} from '@playwright/test'

for (const theme of [
  'light',
  'dark',
  'dark_dimmed',
  'light_colorblind',
  'dark_colorblind',
  'light_high_contrast',
  'dark_high_contrast',
]) {
  // Lookbook encodes the display options twice in preview links.
  const display = encodeURIComponent(encodeURIComponent(JSON.stringify({theme})))

  test(`selected CheckBox keyboard focus keeps its gap in ${theme}`, async ({page}) => {
    await page.goto(`/lookbook/preview/primer/alpha/check_box/playground?_display=${display}`)
    await expect(page.locator('html')).toHaveAttribute(
      theme.startsWith('dark') ? 'data-dark-theme' : 'data-light-theme',
      theme,
    )

    const checkbox = page.getByRole('checkbox', {name: 'Jean-Luc Picard', exact: true})
    await page.keyboard.press('Tab')
    await expect(checkbox).toBeFocused()
    await page.keyboard.press('Space')
    await expect(checkbox).toBeChecked()

    const focus = await checkbox.evaluate(element => {
      const style = getComputedStyle(element)
      return {
        visible: element.matches(':focus-visible'),
        offset: Number.parseFloat(style.outlineOffset),
        width: Number.parseFloat(style.outlineWidth),
        style: style.outlineStyle,
      }
    })

    expect(focus.visible).toBe(true)
    expect(focus.style).toBe('solid')
    expect(focus.width).toBeGreaterThanOrEqual(2)
    expect(focus.offset).toBe(2)

    await page.keyboard.press('Space')
    await expect(checkbox).not.toBeChecked()
    await expect(checkbox).toBeFocused()
  })

  test(`CheckBox options have individual accessible labels in ${theme}`, async ({page}) => {
    await page.goto(`/lookbook/preview/primer/alpha/check_box/options?_display=${display}`)

    const checkboxes = page.locator('input.FormControl-checkbox')
    await expect(checkboxes).toHaveCount(4)
    for (const checkbox of await checkboxes.all()) {
      await expect(checkbox).toHaveAccessibleName('Jean-Luc Picard')
      expect(
        await checkbox.evaluate(element => {
          if (!(element instanceof HTMLInputElement)) throw new Error('Expected a checkbox input')
          return element.labels?.length
        }),
      ).toBe(1)
    }
  })
}
