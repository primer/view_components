import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'
import '@primer/css/dist/primer.css'
import '@primer/css/dist/primitives.css'

// Reset PrimerCSS changing body font-size to 14px
const bodyStyle = `
  body {
    font-size: 16px;
  }
`

function Head(props) {
  const siteMetadata = useSiteMetadata()
  const title = props.title
    ? `${props.title} | ${siteMetadata.title}`
    : siteMetadata.title
  const description = props.description || siteMetadata.description

  let primerViewComponentsSrc

  if (process.env.NODE_ENV === 'development') {
    primerViewComponentsSrc =
      'http://localhost:4000/assets/primer_view_components.js'
  } else {
    primerViewComponentsSrc =
      'https://unpkg.com/@primer/view-components@latest/app/assets/javascripts/primer_view_components.js'
  }

  return (
    <Helmet>
      <title>{title}</title>
      <meta name="description" content={description} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:image" content={siteMetadata.imageUrl} />
      <meta property="twitter:card" content="summary_large_image" />
      <script src={primerViewComponentsSrc}></script>
      <style>{bodyStyle}</style>
    </Helmet>
  )
}

export default Head
