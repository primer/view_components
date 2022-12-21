import { withPrefix } from "gatsby"
import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'
import '@primer/css/dist/primitives.css'
import '@primer/css/dist/color-modes.css'
import '@primer/css/dist/base.css'
import '@primer/css/dist/utilities.css'
import '@primer/css/dist/markdown.css'
import '../../../../static/primer_view_components.css'

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

  const primerViewComponentsSrc = "/primer_view_components.js"

  return (
    <Helmet>
      <title>{title}</title>
      <meta name="description" content={description} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:image" content={siteMetadata.imageUrl} />
      <meta property="twitter:card" content="summary_large_image" />
      <script src={withPrefix(primerViewComponentsSrc)} type="text/javascript"></script>
      <style>{bodyStyle}</style>
    </Helmet>
  )
}

export default Head
