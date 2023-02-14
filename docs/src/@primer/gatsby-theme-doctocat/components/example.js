import React, { useEffect } from 'react'
import ThemeSwitcher from './theme-switcher'

function Example({src}) {
  useEffect(() => {
    /* Because we use dangerouslySetInnerHTML below, any <script> tags in __html
     * will not be executed. This eval hack sidesteps the issue.
    */
    document.querySelectorAll("script[data-eval]").forEach( (scriptEl) => {
      // eslint-disable-next-line no-eval
      eval(scriptEl.innerText)
    })
  })

  return (
    <ThemeSwitcher>
      <div dangerouslySetInnerHTML={{ __html: src}}></div>
    </ThemeSwitcher>
  )
}

export default Example
