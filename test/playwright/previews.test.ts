import {test, expect} from '@playwright/test'
import {glob} from 'glob'

const previews = glob.sync('previews/**/*_preview.rb')
const ignoredPreviews = ['primer/forms/forms']
for (const preview of previews) {
  const previewURL = preview.replace('previews/', '').replace('_preview.rb', '').replace('_component', '')
  if (ignoredPreviews.includes(previewURL)) {
    continue
  }
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
    await page.goto(`/lookbook/preview/${previewURL}/default`)
    expect(await page.locator('#component-preview').screenshot()).toMatchSnapshot(['previews', `${previewURL}.png`])
  })
}
