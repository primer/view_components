import React, { memo, useState } from 'react';
import { useGlobals } from '@storybook/api';
import { Icons, IconButton, WithTooltip, TooltipLinkList, TooltipMessage, Trigger } from '@storybook/components';
import { THEMES } from '../constants';

const getColorList = (active, set) => [
  THEMES.map((theme) => ({
    id: theme,
    title: theme,
    onClick: () => {
      set(theme);
    },
    right: <div>{theme}</div>,
    active: active === theme,
  })),
];

export const ColorModeSelector = memo(() => {
  const [colorMode, setColorMode] = useState('light');
  const [expanded, setExpanded] = useState(false);
  const iframe = document.getElementById('storybook-preview-iframe')

  const updateTheme = (theme) => {
    const root = iframe.contentWindow.document.children[0]
    root.setAttribute('data-color-mode', 'light')
    root.setAttribute('data-dark-theme', theme)
    root.setAttribute('data-light-theme', theme)
  }

  const themeList = THEMES.map(theme => ({
    id: theme,
    title: theme,
    onClick: () => {
      setColorMode(theme)
      updateTheme(theme)
    },
  }));

  return (
    <WithTooltip
      placement="bottom-start"
      trigger="click"
      tooltipShown={expanded}
      onVisibilityChange={s => setExpanded(s)}
      tooltip={<TooltipLinkList links={themeList} />}
      closeOnClick
    >
      <IconButton key="colorMode" active={!!colorMode} title="Color modes">
        <Icons icon="paintbrush" /> &nbsp;{colorMode}
      </IconButton>
    </WithTooltip>
  );
});
