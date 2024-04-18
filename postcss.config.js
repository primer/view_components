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
