module.exports = {
  map: {
    annotation: false
  },
  plugins: [
    require('postcss-import'),
    // require('autoprefixer'),
    // require('postcss-mixins'),
    require('postcss-preset-env')({
      stage: 3,
      features: {
        'nesting-rules': true
      }
    }),
    // require('cssnano'),
  ],
};
