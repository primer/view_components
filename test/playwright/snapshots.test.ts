/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-unused-vars */
import {test, expect, Page} from '@playwright/test'
import {getPreviewURLs} from './helpers'
import type {ComponentPreviews} from './helpers'

let previewsJson: ComponentPreviews[]

test.beforeAll(async ({browser}) => {
  previewsJson = await getPreviewURLs(browser)
})

test.beforeEach(async ({page}, testInfo) => {
  testInfo.snapshotSuffix = ''
})

test('default snapshots', async ({page}) => {
  for (const preview of previewsJson) {
    // eslint-disable-next-line no-console
    console.log(`Testing ${preview.name}`)
    // If any preview example contains a "default" key, we'll use that as the default screenshot
    const defaultExample = preview.examples.find(example => example.name === 'default')!
    await page.goto(defaultExample.inspect_path)
    const defaultScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(defaultScreenshot).toMatchSnapshot([preview.name, 'default.png'])
  }

    // // Focus state
    // await page.keyboard.press('Tab')
    // const focusedScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    // expect(focusedScreenshot).toMatchSnapshot([previewURL, 'focused.png'])
})
