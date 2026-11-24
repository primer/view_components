# frozen_string_literal: true

require "system/test_case"

class IntegrationAlphaFormControlTest < System::TestCase
  include Primer::WindowTestHelpers

  # Firefox's outer-window resizing does not guarantee this exact viewport.
  if !Primer::DriverTestHelpers.firefox?
    def test_playground_note_reflows_in_light
      assert_playground_note_reflows("light")
    end

    def test_playground_note_reflows_in_dark
      assert_playground_note_reflows("dark")
    end
  end

  private

  def assert_playground_note_reflows(theme)
    window.resize(width: 320, height: 256)
    visit_preview(:playground, theme: theme)

    assert_equal [320, 256], page.evaluate_script("[window.innerWidth, window.innerHeight]")
    assert_selector "html[data-color-mode='#{theme}'][data-#{theme}-theme='#{theme}']"

    horizontal_overflow = page.evaluate_script(<<~JS)
      Math.max(document.documentElement.scrollWidth, document.body.scrollWidth) -
        document.documentElement.clientWidth
    JS
    assert_operator horizontal_overflow, :<=, 0, "The preview must not scroll horizontally"

    example_text = 'Primer::Alpha::FormControl.new(label_arguments: { for: "field-name-or-id" })'
    preview = find("#component-preview")
    example = preview.find("code", text: example_text, exact_text: true)
    note = example.find(:xpath, "..")

    note.assert_text(
      "NOTE: The FormControl component cannot automatically connect the label to the provided input. " \
      "Please take care to pass the for: attribute to FormControl, eg: #{example_text}. " \
      "- Your friendly neighborhood accessibility team.",
      exact: true, normalize_ws: true
    )

    readability = note.evaluate_script(<<~JS)
      (() => {
        const walker = document.createTreeWalker(this, NodeFilter.SHOW_TEXT)
        const unreadable = []
        let checkedTextNodes = 0

        while (walker.nextNode()) {
          const node = walker.currentNode
          const text = node.textContent.trim()
          if (!text) continue
          checkedTextNodes++

          const range = document.createRange()
          range.selectNodeContents(node)
          const rects = range.getClientRects()
          if (!Array.from(rects).some(rect => rect.width > 0 && rect.height > 0)) {
            unreadable.push(text)
            continue
          }

          for (let index = 0; index < rects.length; index++) {
            const beforeScroll = range.getClientRects()[index]
            if (beforeScroll.width === 0 || beforeScroll.height === 0) continue

            window.scrollTo({
              left: 0,
              top: beforeScroll.top + window.scrollY - (window.innerHeight - beforeScroll.height) / 2,
              behavior: 'instant'
            })

            const rect = range.getClientRects()[index]
            // Text ranges catch content that overflow: hidden conceals from scrollWidth.
            for (let ancestor = node.parentElement; ancestor; ancestor = ancestor.parentElement) {
              const style = window.getComputedStyle(ancestor)
              const bounds = ancestor.getBoundingClientRect()
              if (
                style.visibility !== 'visible' || Number(style.opacity) === 0 ||
                (style.overflowX !== 'visible' && (rect.left < bounds.left - 1 || rect.right > bounds.right + 1)) ||
                (style.overflowY !== 'visible' && (rect.top < bounds.top - 1 || rect.bottom > bounds.bottom + 1))
              ) {
                unreadable.push(text)
                break
              }
            }

            const hit = document.elementFromPoint((rect.left + rect.right) / 2, (rect.top + rect.bottom) / 2)
            if (
              rect.left < -1 || rect.right > window.innerWidth + 1 ||
              rect.top < -1 || rect.bottom > window.innerHeight + 1 ||
              !node.parentElement.contains(hit)
            ) {
              unreadable.push(text)
            }
          }
        }

        return {checkedTextNodes, unreadable}
      })()
    JS
    assert_operator readability["checkedTextNodes"], :>, 0
    assert_empty readability["unreadable"], "Every note text fragment must remain readable after vertical scrolling"
    example.assert_text(example_text, exact: true)

    preview.find("label", text: "Best character").click
    assert_selector "#component-preview input[type=text]:focus"
    assert_accessible
  end
end
