const path = require('path')
const importedJSONFromPrimitives = require('./node_modules/@primer/primitives/tokens-next-private/fallbacks/color-fallbacks.json')

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
      importFrom: {
        customProperties: importedJSONFromPrimitives
      },
    }),
    require('postcss-preset-env')({
      stage: 2,
      // https://preset-env.cssdb.org/features/#stage-2
      features: {
        'nesting-rules': { noIsPseudoSelector: true },
        'focus-visible-pseudo-class': false,
        'logical-properties-and-values': false,
        'custom-media-queries':  {
          importFrom: [
            path.join(__dirname, './node_modules/@primer/primitives/tokens-next-private/css/functional/size/viewport.css')
          ]
        },
      }
    }),
    process.env.CI === 'true' ? require('cssnano') : null
  ],
};
