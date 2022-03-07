import React from 'react'
import { Box, DropdownMenu, DropdownButton, ThemeProvider } from '@primer/react'
import primitives from '@primer/primitives'

const THEMES = Object.keys(primitives.colors)

function ThemeSwitcher({ children }) {
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
        <ThemeProvider dayScheme={colorMode.text}>
          <DropdownMenu
            renderAnchor={({ children, ...anchorProps }) => (
              <DropdownButton variant="small" {...anchorProps}>
                {children}
              </DropdownButton>
            )}
            items={items}
            selectedItem={colorMode}
            onChange={setColorMode}
          />
        </ThemeProvider>
      </Box>
      <div className="frame-example p-3">{children}</div>
    </div>
  )
}

export default ThemeSwitcher
