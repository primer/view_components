import {test, expect} from '@playwright/test'
import {componentPreviews} from './helpers'

for (const {componentName, previewURL} of componentPreviews()) {
  test(`renders ${componentName} preview`, async ({page}) => {
    await page.goto(`/lookbook/preview/${previewURL}/default`)
    const screenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(screenshot).toMatchSnapshot(['previews', `${previewURL}.png`])
  })
}
