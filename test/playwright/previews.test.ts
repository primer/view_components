/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-unused-vars */
import {test, expect} from '@playwright/test'
import {componentPreviews} from './helpers'

test.beforeEach(async ({page}, testInfo) => {
  testInfo.snapshotSuffix = ''
})

for (const {componentName, previewURL} of componentPreviews()) {
  test(`renders ${componentName} preview`, async ({page}) => {
    await page.goto(`/lookbook/preview/${previewURL}/default`)
    const defaultScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(defaultScreenshot).toMatchSnapshot([previewURL, 'default.png'])

    // Focus state
    await page.keyboard.press('Tab')
    const focusedScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(focusedScreenshot).toMatchSnapshot([previewURL, 'focused.png'])
  })
}
