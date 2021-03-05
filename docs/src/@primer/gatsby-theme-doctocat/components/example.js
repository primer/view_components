import React from 'react'
import ThemeSwitcher from './theme-switcher'

function Example({src}) {
  return (
    <ThemeSwitcher>
      <div dangerouslySetInnerHTML={{ __html: src}}></div>
    </ThemeSwitcher>
  )
}

export default Example
