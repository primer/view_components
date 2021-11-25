import React from 'react'
import {Link} from 'gatsby'
import {Flash} from '@primer/components'

function RequiresJSFlash() {
  return (
    <Flash mb={3}>
      This component requires JavaScript to function. Please refer to the{' '}
      <Link to="/#installation">Installation section</Link> to set it up.
    </Flash>
  )
}

export default RequiresJSFlash
