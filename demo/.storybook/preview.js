const isProd = process.env.NODE_ENV == 'production';
const herokuAppName = process.env.HEROKU_APP_NAME;

console.log("======== TEST ==========");
console.log(process.env);

const serverHost = isProd ? `https://${herokuAppName}.herokuapp.com` : 'http://localhost:4000';

export const parameters = {
  server: {
    url: `${serverHost}/rails/stories`,
  }
};
