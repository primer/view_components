/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable no-unused-vars */
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
    for (const example of preview.examples) {
      if (example.snapshot === 'true') {
        test(example.preview_path, async ({page}) => {
          await page.goto(`/rails/view_components/${example.preview_path}?theme=all`)
          const defaultScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
          expect(defaultScreenshot).toMatchSnapshot([example.preview_path, 'default.png'])

          // Focus state
          await page.keyboard.press('Tab')

          // Wait a bit for animations etc to resolve
          await new Promise(resolve => setTimeout(resolve, 100))

          const focusedScreenshot = await page.locator('#component-preview').screenshot({animations: 'disabled'})
          expect(focusedScreenshot).toMatchSnapshot([example.preview_path, 'focused.png'])
        })
      }
    }
  }
})
