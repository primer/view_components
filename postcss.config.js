const path = require('path')
const fs = require('fs')

module.exports = {
  map: {
    annotation: false
  },
  plugins: [
    require('postcss-import'),
    require('postcss-mixins')({
      mixinsDir: path.join(__dirname, './lib/postcss_mixins/')
    }),
    require('postcss-custom-properties-fallback')({
      importFrom: [
        () => {
          const primitiveFallbacks = [
            'color-fallbacks.json',
            'base/size/size.json',
            'base/typography/typography.json',
            'functional/size/border.json',
            'functional/size/breakpoints.json',
            'functional/size/size-coarse.json',
            'functional/size/size-fine.json',
            'functional/size/size.json',
            'functional/size/viewport.json',
            'functional/typography/typography.json',
          ]
          let customProperties = {}
          for (const filePath of primitiveFallbacks) {
            const fileData = fs.readFileSync(path.join(__dirname, './node_modules/@primer/primitives/tokens-next-private/fallbacks/', filePath), 'utf8')
            customProperties = {...customProperties, ...JSON.parse(fileData)}
          }

          return { customProperties: customProperties };
        }
      ]
    }),
    require('postcss-preset-env')({
      stage: 2,
      // https://preset-env.cssdb.org/features/#stage-2
      features: {
        'nesting-rules': {noIsPseudoSelector: true},
        'focus-visible-pseudo-class': false,
        'logical-properties-and-values': false
      }
    }),
    process.env.CI === 'true' ? require('cssnano') : null
  ]
}
