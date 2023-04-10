const { defineConfig } = require('cypress')

module.exports = defineConfig({
  screenshotsFolder: 'tmp/cypress_screenshots',
  videosFolder: 'tmp/cypress_videos',
  trashAssetsBeforeRuns: false,
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
  },
})
