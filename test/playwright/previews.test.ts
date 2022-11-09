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
    const screenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(screenshot).toMatchSnapshot([previewURL, 'default.png'])
  })
}
