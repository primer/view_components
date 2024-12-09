/* eslint-disable import/no-nodejs-modules */
import fs from 'fs'
import path from 'path'

export interface ComponentPreview {
  name: string
  lookup_path: string
  examples: Array<{
    name: string
    snapshot: string
    inspect_path: string
    preview_path: string
  }>
}

export interface FormPreview {
  name: string
  lookup_path: string
  examples: Array<{
    name: string
    snapshot: string
    preview_path: string
  }>
}

export function getPreviewURLs(): ComponentPreview[] {
  const jsonString = fs.readFileSync(path.join(__dirname, '../../static/previews.json'), {encoding: 'utf8', flag: 'r'})

  // read file contents
  return JSON.parse(jsonString)
}

export function getFormPreviewURLs(): FormPreview[] {
  const jsonString = fs.readFileSync(path.join(__dirname, '../../static/form_previews.json'), {
    encoding: 'utf8',
    flag: 'r',
  })

  // read file contents
  return JSON.parse(jsonString)
}
