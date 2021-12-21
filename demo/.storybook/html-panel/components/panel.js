import React, { useEffect, useState } from 'react';
import { useChannel } from '@storybook/api';
import { STORY_RENDERED } from '@storybook/core-events';
import style from 'react-syntax-highlighter/dist/esm/styles/hljs/github-gist';
import prettierHtml from 'prettier/parser-html';
import { format as prettierFormat } from 'prettier/standalone';

import SyntaxHighlighter from './syntax-highlighter';
import { STORY_ID } from '../constants';

export const Panel = () => {
  const [html, setHTML] = useState('');
  const [code, setCode] = useState('');

  const prettierConfig = {
    htmlWhitespaceSensitivity: 'ignore',
    parser: 'html',
    plugins: [prettierHtml],
  };

  useChannel({
    [STORY_RENDERED]: () => {
      const iframe = document.getElementById('storybook-preview-iframe')
      const html = iframe.contentWindow.document.getElementById(STORY_ID).innerHTML
      setHTML(html)
    },
  });

  useEffect(() => {
    setCode(prettierFormat(html, prettierConfig));
  }, [html]);

  return (
    <SyntaxHighlighter
      language={'xml'}
      copyable={true}
      padded={true}
      style={style}
      showLineNumbers={false}
      wrapLines={true}
    >
      {code}
    </SyntaxHighlighter>
  );
};
