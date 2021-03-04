import React from 'react'

function ThemeSwitcher({children}) {
  const [theme, setTheme] = React.useState('light')
  React.useEffect(() => {
    function handleKeyDown(event) {
      // Use `ctrl + cmd + t` to toggle between light and dark mode
      if (event.key === 't' && event.ctrlKey && event.metaKey) {
        setTheme(theme === 'light' ? 'dark' : 'light')
      }
    }
    document.addEventListener('keydown', handleKeyDown)
    return function cleanup() {
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [theme])
  return <div data-color-mode={theme} data-dark-theme="dark" data-light-theme="light">{children}</div>
}

export default ThemeSwitcher
