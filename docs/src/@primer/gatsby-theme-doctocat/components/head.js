import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'

// Reset PrimerCSS changing body font-size to 14px
const bodyStyle = `
  body {
    font-size: 16px;
  }
  .hx_tooltip-container{
    position:relative;
    display:inline-block
}
.hx_tooltip{
    position:absolute;
    z-index:1000000;
    padding:.5em .75em;
    font:normal normal 11px/1.5 -apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji";
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
    border-radius:6px;
    opacity:0
}
.hx_tooltip::before{
    position:absolute;
    z-index:1000001;
    color:var(--color-neutral-emphasis-plus);
    content:"";
    border:6px solid transparent;
    opacity:0
}
.hx_tooltip::after{
    position:absolute;
    display:block;
    right:0;
    left:0;
    height:12px;
    content:""
}
.hx_tooltip-open,.hx_tooltip-open::before{
    animation-name:tooltip-appear;
    animation-duration:.1s;
    animation-fill-mode:forwards;
    animation-timing-function:ease-in;
    animation-delay:.4s
}
.hx_tooltip-s,.hx_tooltip-se,.hx_tooltip-sw{
    top:100%;
    right:50%;
    margin-top:6px
}
.hx_tooltip-s::before,.hx_tooltip-se::before,.hx_tooltip-sw::before{
    right:50%;
    bottom:100%;
    margin-right:-6px;
    border-bottom-color:var(--color-neutral-emphasis-plus)
}
.hx_tooltip-s::after,.hx_tooltip-se::after,.hx_tooltip-sw::after{
    bottom:100%
}
.hx_tooltip-n,.hx_tooltip-ne,.hx_tooltip-nw{
    right:50%;
    bottom:100%;
    margin-bottom:6px
}
.hx_tooltip-n::before,.hx_tooltip-ne::before,.hx_tooltip-nw::before{
    top:100%;
    right:50%;
    margin-right:-6px;
    border-top-color:var(--color-neutral-emphasis-plus)
}
.hx_tooltip-n::after,.hx_tooltip-ne::after,.hx_tooltip-nw::after{
    top:100%
}
.hx_tooltip-s,.hx_tooltip-n{
    transform:translateX(50%)
}
.hx_tooltip-se,.hx_tooltip-ne{
    right:auto
}
.hx_tooltip-se::before,.hx_tooltip-ne::before{
    right:auto
}
.hx_tooltip-sw,.hx_tooltip-nw{
    right:0
}
.hx_tooltip-sw::before,.hx_tooltip-nw::before{
    right:0;
    margin-right:6px
}
.hx_tooltip-w{
    right:100%;
    margin-right:6px;
    top:50%;
    transform:translateY(-50%)
}
.hx_tooltip-w::before{
    top:50%;
    bottom:50%;
    left:100%;
    margin-top:-6px;
    border-left-color:var(--color-neutral-emphasis-plus)
}
.hx_tooltip-e{
    left:100%;
    margin-left:6px;
    top:50%;
    transform:translateY(-50%)
}
.hx_tooltip-e::before{
    top:50%;
    right:100%;
    bottom:50%;
    margin-top:-6px;
    border-right-color:var(--color-neutral-emphasis-plus)
}
.hx_tooltip-multiline{
    width:max-content;
    max-width:250px;
    word-wrap:break-word;
    white-space:pre-line;
    border-collapse:separate
}
.hx_tooltip-multiline.hx_tooltip-s,.hx_tooltip-multiline.hx_tooltip-n{
    right:auto;
    left:50%;
    transform:translateX(-50%)
}
.hx_tooltip-multiline.hx_tooltip-w,.hx_tooltip-multiline.hx_tooltip-e{
    right:100%
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
