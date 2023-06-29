/* eslint-disable import/no-nodejs-modules */
import fs from 'fs'
import path from 'path'

export interface ComponentPreviews {
  name: string
  lookup_path: string
  examples: Array<{
    name: string
    snapshot: boolean
    inspect_path: string
    preview_path: string
  }>
}

export function getPreviewURLs(): ComponentPreviews[] {
  const jsonString = fs.readFileSync(path.join(__dirname, '../../static/previews.json'), {encoding: 'utf8', flag: 'r'})

  // read file contents
  return JSON.parse(jsonString)
}
