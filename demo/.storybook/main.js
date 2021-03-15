module.exports = {
  stories: ['../../**/*.stories.json'],
  addons: [
    '@storybook/addon-controls',
  ],
  webpackFinal: async (config) => {
    config.output.publicPath = '/view-components/stories/';

    return config;
  },
  managerWebpack: async (config) => {
    config.output.publicPath = "/view-components/stories/"

    return config;
  }
};
