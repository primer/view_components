import { withPrefix } from "gatsby"
import React from 'react'
import Helmet from 'react-helmet'
import useSiteMetadata from '@primer/gatsby-theme-doctocat/src/use-site-metadata'
import '@primer/css/dist/primitives.css'
import '@primer/css/dist/color-modes.css'
import '@primer/css/dist/base.css'
import '@primer/css/dist/box.css'
import '@primer/css/dist/breadcrumb.css'
import '@primer/css/dist/buttons.css'
import '@primer/css/dist/table-object.css'
import '@primer/css/dist/forms.css'
import '@primer/css/dist/layout.css'
import '@primer/css/dist/links.css'
import '@primer/css/dist/navigation.css'
import '@primer/css/dist/pagination.css'
import '@primer/css/dist/tooltips.css'
import '@primer/css/dist/truncate.css'
import '@primer/css/dist/overlay.css'
import '@primer/css/dist/utilities.css'
import '@primer/css/dist/alerts.css'
import '@primer/css/dist/autocomplete.css'
import '@primer/css/dist/avatars.css'
import '@primer/css/dist/blankslate.css'
import '@primer/css/dist/branch-name.css'
import '@primer/css/dist/dropdown.css'
import '@primer/css/dist/header.css'
import '@primer/css/dist/labels.css'
import '@primer/css/dist/loaders.css'
import '@primer/css/dist/markdown.css'
import '@primer/css/dist/popover.css'
import '@primer/css/dist/progress.css'
import '@primer/css/dist/select-menu.css'
import '@primer/css/dist/subhead.css'
import '@primer/css/dist/timeline.css'
import '@primer/css/dist/toasts.css'
import '@primer/css/dist/toggle-switch.css'
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
