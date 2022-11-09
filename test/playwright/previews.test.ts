import {test, expect} from '@playwright/test'
import {glob} from 'glob'

const previews = glob.sync('previews/**/*_preview.rb')
for (const preview of previews) {
  const previewURL = preview.replace('previews/', '').replace('_preview.rb', '')
  const componentName = previewURL
    .split('/')
    .map(module => {
      return module
        .split('_')
        .map(word => {
          return word[0].toUpperCase() + word.substring(1)
        })
        .join('')
    })
    .join('::')

  test(`renders ${componentName} preview`, async ({page}) => {
    await page.goto(`http://127.0.0.1:4000/lookbook/preview/${previewURL}/default`)
    const component = await page.locator('#component-preview')
    await expect(component).toHaveScreenshot({maxDiffPixels: 100})
  })
}
