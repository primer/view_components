module.exports = {
  stories: ['../../**/*.stories.json'],
  addons: [
    '@storybook/addon-controls',
  ],
  managerWebpack: async (config) => {
    config.output.publicPath = "/view-components/stories/"

    return config;
  }
};
