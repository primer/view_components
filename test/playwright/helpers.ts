import {Browser} from '@playwright/test'

export interface ComponentPreviews {
  name: string
  examples: Array<{
    name: string
    inspect_path: string
  }>
}

export async function getPreviewURLs(browser: Browser): Promise<ComponentPreviews[]> {
  const previewsPage = await browser.newPage()
  await previewsPage.goto('/lookbook/previews.json')
  const jsonString = await previewsPage.locator('pre').allInnerTexts()

  return JSON.parse(jsonString[0])
}
