import React, { useState } from 'react';
import { Icons, IconButton, WithTooltip, TooltipLinkList } from '@storybook/components';
import { STORY_RENDERED } from '@storybook/core-events';
import { useChannel } from "@storybook/api"
import { THEMES, STORY_ROOT_ID, STORY_ID } from '../constants';

export const ColorModeSelector = () => {
  const [colorMode, setColorMode] = useState('light');
  const [expanded, setExpanded] = useState(false);
  const iframe = document.getElementById('storybook-preview-iframe')

  useChannel({
    [STORY_RENDERED]: () => {
      const theme = document.getElementById('color-modes-btn').innerText.trim()
      if (theme === 'all') renderAllThemes()
    }
  });

  const setThemeAttributes = (theme, node) => {
    node.setAttribute('data-color-mode', 'light')
    node.setAttribute('data-dark-theme', theme)
    node.setAttribute('data-light-theme', theme)
  }

  const resetStory = (root) => {
    const story = iframe.contentWindow.document.getElementById(STORY_ID)

    story.classList.remove('story-wrap')
    story.removeAttribute('data-color-mode')
    story.removeAttribute('data-dark-theme')
    story.removeAttribute('data-light-theme')

    root.replaceChildren(story)
  }

  const updateTheme = (theme) => {
    if (theme === 'all') return renderAllThemes()

    const htmlRoot = iframe.contentWindow.document.children[0]
    setThemeAttributes(theme, htmlRoot)

    const root = iframe.contentWindow.document.getElementById(STORY_ROOT_ID)

    if (root.classList.contains('theme-wrap')) {
      resetStory(root)
    }
  }

  const renderAllThemes = () => {
    const root = iframe.contentWindow.document.getElementById(STORY_ROOT_ID)
    const newRoot = root.cloneNode()
    newRoot.classList.add('theme-wrap')

    const story = iframe.contentWindow.document.getElementById(STORY_ID)

    for (const theme of THEMES) {
      const storyClone = story.cloneNode(true)
      storyClone.classList.add('story-wrap')
      setThemeAttributes(theme, storyClone)

      newRoot.appendChild(storyClone)
    }

    root.replaceWith(newRoot)
  }

  const themeList = [...THEMES, 'all'].map(theme => ({
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
      <IconButton key="colorMode" active={!!colorMode} title="Color modes" id="color-modes-btn">
        <Icons icon="paintbrush" /> &nbsp;{colorMode}
      </IconButton>
    </WithTooltip>
  );
};
