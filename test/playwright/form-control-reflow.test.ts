import {test, expect} from '@playwright/test'

const exampleText = 'Primer::Alpha::FormControl.new(label_arguments: { for: "field-name-or-id" })'

test.use({viewport: {width: 320, height: 256}})

for (const theme of ['light', 'dark']) {
  test(`FormControl playground note reflows in ${theme}`, async ({page}) => {
    await page.goto(`/rails/view_components/primer/alpha/form_control/playground?theme=${theme}`)

    const preview = page.locator('#component-preview')
    const example = preview.getByText(exampleText, {exact: true})
    await expect(example).toBeVisible()
    await expect(example).toHaveText(exampleText)

    const note = example.locator('..')
    await expect(note).toContainText(exampleText)

    const horizontalOverflow = await page.evaluate(
      () =>
        Math.max(document.documentElement.scrollWidth, document.body.scrollWidth) -
        document.documentElement.clientWidth,
    )
    expect(horizontalOverflow).toBeLessThanOrEqual(0)

    // Text ranges also detect content that overflow: hidden conceals from scrollWidth.
    const readability = await note.evaluate(container => {
      const walker = document.createTreeWalker(container, NodeFilter.SHOW_TEXT)
      const unreadable: string[] = []
      let checkedTextNodes = 0

      while (walker.nextNode()) {
        const node = walker.currentNode
        const text = node.textContent?.trim()
        if (!text) continue
        checkedTextNodes++

        const range = document.createRange()
        range.selectNodeContents(node)
        const rects = range.getClientRects()
        if (!Array.from(rects).some(rect => rect.width > 0 && rect.height > 0)) {
          unreadable.push(text)
          continue
        }

        for (let ancestor = node.parentElement; ancestor; ancestor = ancestor.parentElement) {
          const style = window.getComputedStyle(ancestor)
          if (style.visibility !== 'visible' || Number(style.opacity) === 0) {
            unreadable.push(text)
            break
          }
        }

        for (let index = 0; index < rects.length; index++) {
          const beforeScroll = range.getClientRects()[index]
          if (beforeScroll.width === 0 || beforeScroll.height === 0) continue

          window.scrollTo({
            left: 0,
            top: beforeScroll.top + window.scrollY - (window.innerHeight - beforeScroll.height) / 2,
            behavior: 'instant',
          })

          const rect = range.getClientRects()[index]
          // Inline text ranges can include whitespace outside the element's hit area.
          const hit = document.elementFromPoint((rect.left + rect.right) / 2, (rect.top + rect.bottom) / 2)
          if (
            rect.left < -1 ||
            rect.right > window.innerWidth + 1 ||
            rect.top < -1 ||
            rect.bottom > window.innerHeight + 1 ||
            !node.parentElement?.contains(hit)
          ) {
            unreadable.push(text)
          }
        }
      }

      return {checkedTextNodes, unreadable}
    })

    expect(readability.checkedTextNodes).toBeGreaterThan(0)
    expect(readability.unreadable, 'Every note text fragment remains readable after vertical scrolling').toEqual([])
    await expect(example).toHaveText(exampleText)

    const input = preview.getByRole('textbox')
    await expect(input).toBeEditable()
    await preview.locator('label').click()
    await expect(input).toBeFocused()
  })
}
