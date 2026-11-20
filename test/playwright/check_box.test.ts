import {test, expect} from '@playwright/test'

function contrastRatio(first: string, second: string): number {
  const luminance = (color: string) => {
    const channels = color.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
    if (!channels) throw new Error(`Expected an opaque RGB color, received ${color}`)

    const linear = (channel: number) => {
      const value = channel / 255
      return value <= 0.04045 ? value / 12.92 : ((value + 0.055) / 1.055) ** 2.4
    }

    return (
      0.2126 * linear(Number(channels[1])) + 0.7152 * linear(Number(channels[2])) + 0.0722 * linear(Number(channels[3]))
    )
  }

  const firstLuminance = luminance(first)
  const secondLuminance = luminance(second)
  return (Math.max(firstLuminance, secondLuminance) + 0.05) / (Math.min(firstLuminance, secondLuminance) + 0.05)
}

for (const theme of ['light', 'dark']) {
  // Lookbook encodes the display options twice in preview links.
  const display = encodeURIComponent(encodeURIComponent(JSON.stringify({theme})))

  test(`selected CheckBox keyboard focus has adjacent contrast in ${theme}`, async ({page}) => {
    await page.goto(`/lookbook/preview/primer/alpha/check_box/playground?_display=${display}`)

    const checkbox = page.getByRole('checkbox', {name: 'Jean-Luc Picard', exact: true})
    await page.keyboard.press('Tab')
    await expect(checkbox).toBeFocused()
    await page.keyboard.press('Space')
    await expect(checkbox).toBeChecked()

    const focus = await checkbox.evaluate(element => {
      const style = getComputedStyle(element)
      let ancestor = element.parentElement
      while (ancestor) {
        const backgroundColor = getComputedStyle(ancestor).backgroundColor
        if (backgroundColor.startsWith('rgb(')) {
          return {
            visible: element.matches(':focus-visible'),
            offset: Number.parseFloat(style.outlineOffset),
            width: Number.parseFloat(style.outlineWidth),
            style: style.outlineStyle,
            color: style.outlineColor,
            adjacentColor: backgroundColor,
          }
        }
        ancestor = ancestor.parentElement
      }
      throw new Error('The CheckBox preview has no opaque adjacent background')
    })

    expect(focus.visible).toBe(true)
    expect(focus.style).toBe('solid')
    expect(focus.width).toBeGreaterThanOrEqual(2)
    expect(focus.offset).toBeGreaterThan(0)
    expect(contrastRatio(focus.color, focus.adjacentColor)).toBeGreaterThanOrEqual(3)
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
