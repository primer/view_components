const options = require('@github/markdownlint-github').init({
  "line_length": false,
  "ol-prefix": false,
  "no-trailing-punctuation": false,
  "no-inline-html": false,
  "first-line-heading": false,
  "no-duplicate-heading": false
})
module.exports = {
    config: options,
    customRules: ["@github/markdownlint-github"],
}