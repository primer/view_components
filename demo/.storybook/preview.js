const isProd = process.env.NODE_ENV == 'production';
const serverHost = isProd ? 'https://primer-view-components.herokuapp' : 'http://localhost:4000';

console.log("serverHost", serverHost)

export const parameters = {
  server: {
    url: `${serverHost}/rails/stories`,
  }
};
