import {test, expect} from '@playwright/test'

test.describe('Button', () => {
  test('With trailing counter', async ({page}) => {
    await page.goto(`/rails/view_components/beta/button/trailing_counter`)
    const component = await page.locator('#component-preview')

    expect(component.getByRole('button', {name: 'Star (15)'}))
  })
})
