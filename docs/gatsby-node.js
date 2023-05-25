const fs = require('fs')
const {glob} = require('glob')
const path = require('path')
const yaml = require('js-yaml')

exports.createPages = async ({ _graphql, actions }) => {
  return

  const env = process.env.NODE_ENV
  if (env === 'development') {
    console.log(`NODE_ENV is ${env}, skipping redirects`)
    return
  } else {
    console.log(`NODE_ENV is ${env}, computing redirects`)
  }

  const { createRedirect } = actions
  const primerDesignRepoPath = process.env.PRIMER_DESIGN_REPO_PATH
  if (!primerDesignRepoPath) throw new Error('Missing PRIMER_DESIGN_REPO_PATH environment variable')

  const iaComponentPath = path.join(primerDesignRepoPath, 'content', 'components')
  console.log(`IA component path is: ${iaComponentPath}`)
  const mdxFiles = await glob(path.join(iaComponentPath, '*.mdx'))
  console.log(`Found mdx files:\n${mdxFiles.join("\n")}`)
  const infoArchFile = path.join(__dirname, '..', 'static', 'info_arch.json')
  console.log(`Info arch manifest: ${infoArchFile}`)
  const infoArch = JSON.parse(fs.readFileSync(infoArchFile), {encoding: 'utf8'})

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
    console.log(`Processing ${mdxFile}`)
    const content = fs.readFileSync(mdxFile, {encoding: 'utf8'})
    const frontMatterBeginIdx = content.indexOf('---')
    const frontMatterEndIdx = content.indexOf('---', frontMatterBeginIdx + 3)
    const frontMatter = yaml.load(content.substring(0, frontMatterEndIdx))
    const railsId = frontMatter['railsId']
    if (!railsId) return

    const mdxPath = path.parse(path.relative(path.join(primerDesignRepoPath, 'content'), mdxFile))
    const newDocsiteUrl = joinUrls('https://primer.style/design', mdxPath.dir, mdxPath.name)
    const component = findComponentInInfoArch(railsId)
    const legacyDocsiteUrl = joinUrls('/', component.legacy_docsite_path)

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
