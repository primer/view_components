import React from 'react'
import ThemeSwitcher from './theme-switcher'

function Example({src}) {
  return (
    <ThemeSwitcher>
      <div className="Box p-3" dangerouslySetInnerHTML={{ __html: src}}></div>
    </ThemeSwitcher>
  )
}

export default Example
