import '@github/markdown-toolbar-element'

import MarkdownToolbarElement from '@github/markdown-toolbar-element'
import {dialog} from '../details-dialog'
import {on} from 'delegated-events'

const selectionEnds = new WeakMap()

function getTextarea(el: HTMLElement): HTMLTextAreaElement {
  return el.closest<MarkdownToolbarElement>('markdown-toolbar')!.field!
}

on('click', '.js-markdown-link-button', async function ({ currentTarget }: MouseEvent) {
  const template = document.querySelector<HTMLTemplateElement>('.js-markdown-link-dialog')!
  const content = template.content.cloneNode(true)
  if (!(content instanceof DocumentFragment)) return

  const dialogEl = await dialog({content})
  if (!(currentTarget instanceof HTMLElement)) return
  selectionEnds.set(dialogEl, getTextarea(currentTarget).selectionEnd)
})

on('click', '.js-markdown-link-insert', ({ currentTarget }: MouseEvent) => {
  if (!(currentTarget instanceof HTMLElement)) return;
  const container = currentTarget.closest<HTMLElement>('details-dialog')!
  const textarea = document.querySelector<HTMLTextAreaElement>(`#${currentTarget.getAttribute('data-for-textarea')!}`)!
  const selectionEnd = selectionEnds.get(container) || 0

  const href = container.querySelector<HTMLInputElement>('#js-dialog-link-href')!.value
  const text = container.querySelector<HTMLInputElement>('#js-dialog-link-text')!.value
  const link = `[${text}](${href}) `
  const before = textarea.value.slice(0, selectionEnd)
  const after = textarea.value.slice(selectionEnd)
  textarea.value = before + link + after
  textarea.focus()
  textarea.selectionStart = textarea.selectionEnd = selectionEnd + link.length
})
