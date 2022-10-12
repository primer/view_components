import autoprefixer from 'autoprefixer';
import sass from '@koddsson/postcss-sass';
import scss from 'postcss-scss';
import scssImport from 'postcss-import';
import mixins from 'postcss-mixins';
import presetEnv from 'postcss-preset-env';
import cssNano from 'cssnano';
import {join} from 'path';

export default {
  map: {
    sourcesContent: false,
    annotation: true
  },
  customSyntax: scss,
  parser: scss,
  plugins: [
    scssImport,
    mixins({
      mixinsDir: 'lib/postcss_mixins/'
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
      includePaths: ['node_modules'],
      outputStyle: process.env.CSS_MINIFY === '0' ? 'expanded' : 'compressed'
    }),
    autoprefixer,
  ],
};
