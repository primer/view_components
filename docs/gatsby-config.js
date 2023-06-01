module.exports = {
  siteMetadata: {
    title: 'Primer ViewComponents',
    shortName: 'ViewComponents',
    description: 'ViewComponents for the Primer Design System',
    imageUrl: "https://user-images.githubusercontent.com/10384315/53922681-2f6d3100-402a-11e9-9719-5d1811c8110a.png"
  },
  plugins: [
    {
      resolve: '@primer/gatsby-theme-doctocat',
      options: {
        defaultBranch: 'main',
        repoRootPath: './docs',
      },
    }
  ],
  pathPrefix: '/view-components',
}
