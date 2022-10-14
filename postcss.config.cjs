const autoprefixer = require('autoprefixer');
const sass = require('@koddsson/postcss-sass');
const scss = require('postcss-scss');
const scssImport = require('postcss-import');
const mixins = require('postcss-mixins');
const presetEnv = require('postcss-preset-env');
const cssNano = require('cssnano');
const path = require('path')

module.export = {
  map: {
    sourcesContent: false,
    annotation: true
  },
  customSyntax: scss,
  parser: scss,
  plugins: [
    scssImport,
    mixins({
      mixinsDir: path.join(__dirname, './lib/postcss_mixins/')
    }),
    presetEnv({
      stage: 2,
      // https://preset-env.cssdb.org/features/#stage-2
      features: {
        'nesting-rules': true
      }
    }),
    cssNano,
    sass({
      includePaths: [path.join(__dirname, 'node_modules')],
      outputStyle: process.env.CSS_MINIFY === '0' ? 'expanded' : 'compressed'
    }),
    autoprefixer,
  ],
};
