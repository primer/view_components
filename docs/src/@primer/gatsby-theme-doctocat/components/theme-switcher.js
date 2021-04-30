import React from 'react'
import {Flex} from '@primer/components'
import {MoonIcon, SunIcon} from '@primer/octicons-react'

function ThemeSwitcher({children}) {
  const [colorMode, setColorMode] = React.useState('light')

  return (
    <div className="Box" data-color-mode={colorMode} data-dark-theme="dark" data-light-theme="light">
      <Flex pt={2} px={2} justifyContent="flex-end">
        <button
          className="btn"
          aria-label={colorMode === 'light' ? 'Activate dark mode' : 'Activate light mode'}
          onClick={() => setColorMode(colorMode === 'light' ? 'dark' : 'light')}
        >
          {colorMode === 'light' ? <MoonIcon /> : <SunIcon />}
        </button>
      </Flex>
      <div className="frame-example p-3">{children}</div>
    </div>
  )
}

export default ThemeSwitcher
