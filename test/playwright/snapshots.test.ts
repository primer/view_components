/* eslint-disable @typescript-eslint/no-unused-vars */
import {test, expect} from '@playwright/test'
import {getPreviewURLs, getFormPreviewURLs} from './helpers'
import type {ComponentPreview, FormPreview} from './helpers'

const previewsJson: ComponentPreview[] = getPreviewURLs()
const formPreviewsJson: FormPreview[] = getFormPreviewURLs()

test.beforeEach(async ({page}, testInfo) => {
  testInfo.snapshotSuffix = ''
})

test('Preview Json exists', () => {
  expect(previewsJson).toBeDefined()
  expect(previewsJson.length).toBeGreaterThan(0)
})

test('Form Preview Json exists', () => {
  expect(formPreviewsJson).toBeDefined()
  expect(formPreviewsJson.length).toBeGreaterThan(0)
})

const themes = [
  'light',
  'light_colorblind',
  'light_high_contrast',
  'dark',
  'dark_dimmed',
  'dark_high_contrast',
  'dark_colorblind',
]

test.describe('generate snapshots', () => {
  for (const preview of [...previewsJson, ...formPreviewsJson] as Array<ComponentPreview | FormPreview>) {
    for (const example of preview.examples) {
      if (example.snapshot !== 'false') {
        if (example.snapshot === 'interactive') {
          for (const theme of themes) {
            test(`${example.preview_path}-${theme}`, async ({page}) => {
              await page.goto(`/rails/view_components/${example.preview_path}?theme=${theme}`)

              // Focus state
              await page.keyboard.press('Tab')

              await new Promise(resolve => setTimeout(resolve, 100))
              await page.keyboard.press('Enter')

              const subject = await page.evaluate(() => document.querySelector('[data-interaction-subject]'))
              if (subject) {
                await page.waitForSelector('[data-interaction-subject][data-ready=true]')
              }

              // Wait a bit for animations etc to resolve
              await new Promise(resolve => setTimeout(resolve, 100))

              const focusedScreenshot = await page.screenshot({animations: 'disabled'})
              expect(focusedScreenshot).toMatchSnapshot([example.preview_path, `${theme}.png`])
            })
          }
        }

        test(`${example.preview_path}-aria-snapshots`, async ({page}) => {
          await page.goto(`/rails/view_components/${example.preview_path}`)

          const defaultScreenshot = await page.locator('#component-preview').ariaSnapshot()
          expect(defaultScreenshot).toMatchSnapshot([example.preview_path, 'default.yml'])
        })

        if (example.snapshot === 'interactive') {
          test(`${example.preview_path}-aria-snapshots-interactive`, async ({page}) => {
            await page.goto(`/rails/view_components/${example.preview_path}`)

            // Focus state
            await page.keyboard.press('Tab')

            await new Promise(resolve => setTimeout(resolve, 100))
            await page.keyboard.press('Enter')

            const subject = await page.evaluate(() => document.querySelector('[data-interaction-subject]'))
            if (subject) {
              await page.waitForSelector('[data-interaction-subject][data-ready=true]')
            }

            // Wait a bit for animations etc to resolve
            await new Promise(resolve => setTimeout(resolve, 100))

            const focusedScreenshot = await page.screenshot({animations: 'disabled'})
            expect(focusedScreenshot).toMatchSnapshot([example.preview_path, `default-interacted.yml`])
          })
        }

        test(`${example.preview_path}-aria-snapshots`, async ({page}) => {
          await page.goto(`/rails/view_components/${example.preview_path}`)

          const defaultScreenshot = await page.locator('#component-preview').ariaSnapshot()
          expect(defaultScreenshot).toMatchSnapshot([example.preview_path, 'default.yml'])
        })

        test(example.preview_path, async ({page}) => {
          await page.goto(`/rails/view_components/${example.preview_path}`)
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
