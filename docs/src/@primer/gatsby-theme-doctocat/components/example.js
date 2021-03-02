import React from 'react'

function Example({src}) {
  return <div className="Box p-3" dangerouslySetInnerHTML={{ __html: src}}></div>
}

export default Example
