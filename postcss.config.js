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
    require('postcss-custom-properties-fallback')({
      importFrom: [
        '/workspaces/primitives/tokens-v2-private/json/tokens/base/typography/typography.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/base/size/size.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/border.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/breakpoints.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/size-coarse.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/size-fine.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/size.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/size/viewport.json',
        '/workspaces/primitives/tokens-v2-private/json/tokens/functional/typography/typography.json'
      ]
    }),
    require('postcss-preset-env')({
      stage: 2,
      // https://preset-env.cssdb.org/features/#stage-2
      features: {
        'nesting-rules': true,
        'custom-properties': false,
        'focus-visible-pseudo-class': false
      }
    }),
    require('cssnano'),
  ],
};
