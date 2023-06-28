/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-unused-vars */
/* eslint-disable no-console */
import {test, expect, Page} from '@playwright/test'
import {getPreviewURLs} from './helpers'
import type {ComponentPreviews} from './helpers'

const previewsJson: ComponentPreviews[] = getPreviewURLs()

test.beforeEach(async ({page}, testInfo) => {
  testInfo.snapshotSuffix = ''
})

test('Preview Json exists', () => {
  expect(previewsJson).toBeDefined()
  expect(previewsJson.length).toBeGreaterThan(0)
})

test.describe('generate snapshots', () => {
  for (const preview of previewsJson) {
    // If any preview example contains a "default" key, we'll use that as the default screenshot
    const defaultExample = preview.examples.find(example => example.name === 'default')
    if (!defaultExample) {
      continue
    }

    test(preview.lookup_path, async ({page}) => {
      await page.goto(
        `/rails/view_components/${defaultExample.preview_path}?_display=%257b%2522theme%2522%253a%2522all%2522%257d`
      )
      const defaultScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
      expect(defaultScreenshot).toMatchSnapshot([preview.lookup_path, 'default.png'])

      // Focus state
      await page.keyboard.press('Tab')
      const focusedScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
      expect(focusedScreenshot).toMatchSnapshot([preview.lookup_path, 'focused.png'])
    })
  }
})
