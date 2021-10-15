import React, { memo, useCallback } from 'react';
import { useGlobals } from '@storybook/api';
import { Icons, IconButton } from '@storybook/components';
import { PARAM_KEY } from '../constants';

export const ColorModeSelector = memo(() => {
  const [globals, updateGlobals] = useGlobals();

  const isActive = globals[PARAM_KEY] || false;

  const toggleOutline = useCallback(
    () =>
      updateGlobals({
        [PARAM_KEY]: !isActive,
      }),
    [isActive]
  );

  return (
    <IconButton
      key="outline"
      active={isActive}
      title="Apply outlines to the preview"
      onClick={toggleOutline}
    >
      <Icons icon="paintbrush" />
    </IconButton>
  );
});
