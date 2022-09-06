module.exports = {
  stories: ['../../**/*.stories.json'],
  addons: [
    '@storybook/addon-a11y',
    '@storybook/addon-controls',
    './color-modes/preset',
    './html-panel/preset'
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
  },
  features: {
    postcss: false
  }
};
