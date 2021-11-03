import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'

// Reset PrimerCSS changing body font-size to 14px
const bodyStyle = `
  body {
    font-size: 16px;
  }
  .hx-tooltip-container{
    position:relative;
    display:inline-block
}
.hx-tooltip{
    position:absolute;
    z-index:1000000;
    padding:.5em .75em;
    font:normal normal 11px/1.5 -apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji";
    -webkit-font-smoothing:subpixel-antialiased;
    color:white;
    text-align:center;
    text-decoration:none;
    text-shadow:none;
    text-transform:none;
    letter-spacing:normal;
    word-wrap:break-word;
    white-space:pre;
    background:black;;
    border-radius:6px;
    opacity:0
}
.hx-tooltip::before{
    position:absolute;
    z-index:1000001;
    color:black;;
    content:"";
    border:6px solid transparent;
    opacity:0
}
.hx-tooltip::after{
    position:absolute;
    display:block;
    right:0;
    left:0;
    height:12px;
    content:""
}
.hx-tooltip-visible,.hx-tooltip-visible::before{
    animation-name:tooltip-appear;
    animation-duration:.1s;
    animation-fill-mode:forwards;
    animation-timing-function:ease-in;
    animation-delay:.4s
}
.hx-tooltip-s,.hx-tooltip-se,.hx-tooltip-sw{
    top:100%;
    right:50%;
    margin-top:6px
}
.hx-tooltip-s::before,.hx-tooltip-se::before,.hx-tooltip-sw::before{
    right:50%;
    bottom:100%;
    margin-right:-6px;
    border-bottom-color:black;
}
.hx-tooltip-s::after,.hx-tooltip-se::after,.hx-tooltip-sw::after{
    bottom:100%
}
.hx-tooltip-n,.hx-tooltip-ne,.hx-tooltip-nw{
    right:50%;
    bottom:100%;
    margin-bottom:6px
}
.hx-tooltip-n::before,.hx-tooltip-ne::before,.hx-tooltip-nw::before{
    top:100%;
    right:50%;
    margin-right:-6px;
    border-top-color:black;
}
.hx-tooltip-n::after,.hx-tooltip-ne::after,.hx-tooltip-nw::after{
    top:100%
}
.hx-tooltip-s,.hx-tooltip-n{
    transform:translateX(50%)
}
.hx-tooltip-se,.hx-tooltip-ne{
    right:auto
}
.hx-tooltip-se::before,.hx-tooltip-ne::before{
    right:auto
}
.hx-tooltip-sw,.hx-tooltip-nw{
    right: 0
}
.hx-tooltip-sw::before,.hx-tooltip-nw::before{
    right:0;
    margin-right:6px
}
.hx-tooltip-w{
    right:100%;
    margin-right:6px;
    top:50%;
    transform:translateY(-50%)
}
.hx-tooltip-w::before{
    top:50%;
    bottom:50%;
    left:100%;
    margin-top:-6px;
    border-left-color:black;
}
.hx-tooltip-e{
    left:100%;
    margin-left:6px;
    top:50%;
    transform:translateY(-50%)
}
.hx-tooltip-e::before{
    top:50%;
    right:100%;
    bottom:50%;
    margin-top:-6px;
    border-right-color:black;
}
.hx-tooltip-multiline{
    width:max-content;
    max-width:250px;
    word-wrap:break-word;
    white-space:pre-line;
    border-collapse:separate
}
.hx-tooltip-multiline.hx-tooltip-s,.hx-tooltip-multiline.hx-tooltip-n{
    right:auto;
    left:50%;
    transform:translateX(-50%)
}
.hx-tooltip-multiline.hx-tooltip-w,.hx-tooltip-multiline.hx-tooltip-e{
    right:100%
}
@media screen and (max-width: 544px){
    .hx-tooltip{
        max-width:250px;
        word-wrap:break-word;
        white-space:normal
    }
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
