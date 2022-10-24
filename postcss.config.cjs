const autoprefixer = require('autoprefixer');
const cssImport = require('postcss-import');
const mixins = require('postcss-mixins');
const presetEnv = require('postcss-preset-env');
const cssNano = require('cssnano');
const path = require('path');
const comments = require('postcss-comment');

module.exports = {
  map: {
    sourcesContent: false,
    annotation: true
  },
  parser: comments,
  syntax: comments,
  plugins: [
    cssImport,
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
    autoprefixer,
  ],
};
