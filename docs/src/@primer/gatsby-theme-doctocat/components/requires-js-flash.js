import React from 'react'
import {Flash, Link} from '@primer/components'

function RequiresJSFlash() {
  return (
    <Flash mb={3}>
      This component requires JavaScript to function. Please refer to the <Link href="/javascript">JavaScript docs</Link>.
    </Flash>
  )
}

export default RequiresJSFlash
