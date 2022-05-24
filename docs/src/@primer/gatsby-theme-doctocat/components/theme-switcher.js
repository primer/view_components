import primitives from '@primer/primitives'
import {ActionList, ActionMenu, Box, ThemeProvider} from '@primer/react'
import React from 'react'

const THEMES = Object.keys(primitives.colors)

function ThemeSwitcher({children}) {
  const items = React.useMemo(
    () =>
      THEMES.map((theme) => ({
        text: theme,
        key: theme,
      })),
    [],
  )
  const [colorMode, setColorMode] = React.useState(items[0])

  return (
    <div
      className="Box"
      data-color-mode="light"
      data-dark-theme={colorMode.text}
      data-light-theme={colorMode.text}
    >
      <Box pt={2} px={2} justifyContent="flex-end" display="flex">
        <ThemeProvider dayScheme={colorMode.text}>
          <ActionMenu>
            <ActionMenu.Button aria-label="Select field type">
              {colorMode.text}
            </ActionMenu.Button>
            <ActionMenu.Overlay width="small">
              <ActionList selectionVariant="single">
                {items.map((item, index) => (
                  <ActionList.Item
                    key={index}
                    selected={item.key === colorMode.key}
                    onSelect={() => {
                      setColorMode(item)
                    }}
                  >
                    {item.text}
                  </ActionList.Item>
                ))}
              </ActionList>
            </ActionMenu.Overlay>
          </ActionMenu>
        </ThemeProvider>
      </Box>
      <div className="frame-example p-3">{children}</div>
    </div>
  )
}

export default ThemeSwitcher
