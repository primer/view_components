const path = require('path')

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
        'nesting-rules': true
      }
    }),
    require('cssnano'),
  ],
};
