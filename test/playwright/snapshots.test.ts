/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-unused-vars */
/* eslint-disable no-console */
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
    // If any preview example contains a "default" key, we'll use that as the default screenshot
    const defaultExample = preview.examples.find(example => example.name === 'default')
    if (!defaultExample) {
      continue
    }

    const previewUrl = defaultExample.inspect_path.replace('/lookbook/inspect', '/lookbook/preview')
    const componentSlug = previewUrl.replace('/lookbook/preview/', '').replace('/default', '')

    console.log(`Generating snapshot ${preview.name}`, previewUrl)
    await page.goto(previewUrl)
    const defaultScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(defaultScreenshot).toMatchSnapshot([componentSlug, 'default.png'])

    // Focus state
    await page.keyboard.press('Tab')
    const focusedScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
    expect(focusedScreenshot).toMatchSnapshot([componentSlug, 'focused.png'])
  }
})
