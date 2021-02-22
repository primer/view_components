import React from 'react'

const PADDING = 34 // accounts for p-3 and border

function IFrame({height, content}) {
  let rest = {
    style: {
      width: '100%',
      border: '0px',
    }
  };
  if (height === "auto") {
    rest.onLoad = (e) => {
      e.target.style.height = `${e.target.contentWindow.document.body.scrollHeight + PADDING}px`
    }
  } else {
    rest.style.height = `${Number(height) + PADDING}px`
  }


  return (
    <iframe srcDoc={`<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body>${content}</body></html>`} {...rest}></iframe>
  )
}

export default IFrame
