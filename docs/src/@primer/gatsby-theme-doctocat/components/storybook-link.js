import React from 'react'
import {
  Link,
  StyledOcticon,
} from '@primer/components'
import {RocketIcon} from '@primer/octicons-react'

function StorybookLink({href}) {
  return (
    <Link href={href} lineHeight="condensedUltra" fontSize={1}>
      <StyledOcticon icon={RocketIcon} mr={2} />
      View storybook
    </Link>
  )
}

export default StorybookLink
