import React from 'react'
import {Link} from 'gatsby'
import Note from '@primer/gatsby-theme-doctocat/src/components/note'

function RequiresJSFlash() {
  return (
    <Note>
      This component requires JavaScript to function. Please refer to the{' '}
      <Link to="/#installation">Installation section</Link> to set it up.
    </Note>
  )
}

export default RequiresJSFlash
