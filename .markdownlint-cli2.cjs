const options = require('@github/markdownlint-github').init({
  "line-length": false,
  "ol-prefix": false,
  "no-trailing-punctuation": false,
  "no-inline-html": false,
  "first-line-heading": false,
  "no-generic-link-text": { "exceptions": ["link"] },
  // Rules that we want to enable
  "no-duplicate-heading": false,
})
module.exports = {
    config: options,
    customRules: ["@github/markdownlint-github"],
}
