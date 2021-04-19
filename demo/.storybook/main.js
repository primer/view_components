module.exports = {
  stories: ['../../**/*.stories.json'],
  addons: [
    '@storybook/addon-controls',
    '@storybook/addon-a11y'
  ],
  webpackFinal: async (config, { configType }) => {
    if(configType == 'PRODUCTION')
      config.output.publicPath = '/view-components/stories/';

    return config;
  },
  managerWebpack: async (config, { configType }) => {
    if(configType == 'PRODUCTION')
      config.output.publicPath = "/view-components/stories/"

    return config;
  }
};
