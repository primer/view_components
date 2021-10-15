import React from 'react'
import {Box, DropdownMenu, DropdownButton} from '@primer/components'

const THEMES = [
  'light',
  'light_colorblind',
  'dark',
  'dark_dimmed',
  'dark_high_contrast',
  'dark_colorblind',
]

function ThemeSwitcher({children}) {
  const items = React.useMemo(
    () => THEMES.map((theme) => ({
      text: theme,
      key: theme
    })),
    []
  )
  const [colorMode, setColorMode] = React.useState(items[0])

  return (
    <div className="Box" data-color-mode="light" data-dark-theme={colorMode.text} data-light-theme={colorMode.text}>
      <Box pt={2} px={2} justifyContent="flex-end" display="flex">
      <DropdownMenu
        renderAnchor={({children, ...anchorProps}) => (
          <DropdownButton variant="small" {...anchorProps}>
            {children}
          </DropdownButton>
        )}
        items={items}
        selectedItem={colorMode}
        onChange={setColorMode}
      />
      </Box>
      <div className="frame-example p-3">{children}</div>
    </div>
  )
}

export default ThemeSwitcher
