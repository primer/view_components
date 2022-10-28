#!/usr/bin/env node

import compiler from './primer-css-compiler.js'
import fsextra from 'fs-extra'
import {dirname, join} from 'path'
import {globby} from 'globby'

const {mkdirp, readFile, writeFile} = fsextra
const inDir = 'app/lib/primer/css'
const outDir = 'app/assets/styles'

const bundleNames = {
  'index.css': 'primer'
}

const files = await globby([`${inDir}/**/index.css`])
await mkdirp(outDir)
const inPattern = new RegExp(`^${inDir}/`)
const tasks = files.map(async from => {
  const path = from.replace(inPattern, '')
  const name = bundleNames[path] || dirname(path).replace(/\//g, '-')

  const to = join(outDir, `${name}.css`)

  const result = await compiler(await readFile(from, 'utf8'), {from, to})

  await Promise.all([
    writeFile(to, result.css, 'utf8'),
  ])
})

await Promise.all(tasks)
