const isProd = process.env.NODE_ENV == 'production';
const serverHost = isProd ? 'https://primer-view-components.herokuapp.com' : 'http://localhost:4000';

export const parameters = {
  server: {
    url: `${serverHost}/rails/stories`,
  }
};
