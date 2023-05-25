const fs = require('fs')
const {glob} = require('glob')
const path = require('path')
const yaml = require('js-yaml')

exports.createPages = async ({ _graphql, actions }) => {
  const env = process.env.NODE_ENV
  if (env == 'development') return

  const { createRedirect } = actions
  const primerDesignRepoPath = process.env.PRIMER_DESIGN_REPO_PATH
  if (!primerDesignRepoPath) throw new Error('Missing PRIMER_DESIGN_REPO_PATH environment variable')

  const iaComponentPath = path.join(primerDesignRepoPath, 'content', 'components')
  const mdxFiles = await glob(path.join(iaComponentPath, '*.mdx'))
  const infoArch = JSON.parse(fs.readFileSync('../static/info_arch.json'), {encoding: 'utf8'})

  const findComponentInInfoArch = (railsId) => {
    for (const component of infoArch) {
      if (component.fully_qualified_name == railsId) {
        return component
      }
    }
  }

  const joinUrls = (...args) => {
    const joined = args.map((arg) => arg.replace(/^\//, '').replace(/\/$/, '')).join('/')
    if (args[0][0] == '/') return `/${joined}`
    return joined
  }

  mdxFiles.forEach((mdxFile) => {
    const content = fs.readFileSync(mdxFile, {encoding: 'utf8'})
    const frontMatterBeginIdx = content.indexOf('---')
    const frontMatterEndIdx = content.indexOf('---', frontMatterBeginIdx + 3)
    const frontMatter = yaml.load(content.substring(0, frontMatterEndIdx))
    const railsId = frontMatter['railsId']
    if (!railsId) return

    const mdxPath = path.parse(path.relative(path.join(primerDesignRepoPath, 'content'), mdxFile))
    const newDocsiteUrl = joinUrls('/design', mdxPath.dir, mdxPath.name)
    const component = findComponentInInfoArch(railsId)
    const legacyDocsiteUrl = joinUrls('/view-components', component.legacy_docsite_path)

    console.log(`Creating redirect from ${legacyDocsiteUrl} to ${newDocsiteUrl}`)

    createRedirect({
      fromPath: legacyDocsiteUrl,
      toPath: newDocsiteUrl,
      isPermanent: true,
      force: true,
      redirectInBrowser: true
    })
  })
}
