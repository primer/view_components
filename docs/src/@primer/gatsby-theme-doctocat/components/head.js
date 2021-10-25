import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'

// Reset PrimerCSS changing body font-size to 14px
const bodyStyle = `
  body {
    font-size: 16px;
  }
  tooltip-container {
    position:relative;
    display:inline-block
  }
  .alpha-tooltipped {
    z-index: 100000001;
    position:absolute;
    top:100%;
    left:50%;
    transform:
    translateX(-50%);
    padding:.5em 1em;
    font:normal normal 11px/1.5 -apple-system,
    BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji";
    -webkit-font-smoothing:subpixel-antialiased;
    color:var(--color-fg-on-emphasis);
    text-align:center;
    text-decoration:none;
    text-shadow:none;
    text-transform:none;
    letter-spacing:normal;
    word-wrap:break-word;
    white-space:pre;
    background:var(--color-neutral-emphasis-plus);
    border-radius:6px
  }
    
    .alpha-tooltipped::before{
       position:absolute;
       bottom:100%;
       left:50%;
       transform:translateX(-50%);
       content:"";
       border: 0.5em solid transparent;
       border-bottom-color:var(--color-neutral-emphasis-plus)}
    
    .alpha-tooltipped::after{
      position:absolute;
      right:0;bottom:100%;left:0;
      display:block;
      height: 1em;
      content:""}
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
      <link
        href="https://unpkg.com/@primer/css/dist/primer.css"
        rel="stylesheet"
      />
      <script src={primerViewComponentsSrc}></script>
      <style>{bodyStyle}</style>
    </Helmet>
  )
}

export default Head
