// eslint-disable-next-line import/no-nodejs-modules
import path from 'node:path'
import type {PlaywrightTestConfig} from '@playwright/test'
import {devices} from '@playwright/test'

/**
 * See https://playwright.dev/docs/test-configuration.
 */
const config: PlaywrightTestConfig = {
  testDir: path.join(__dirname, 'test', 'playwright'),
  testMatch: '**/*.test.ts',
  /* Maximum time one test can run for. */
  timeout: 30 * 1000,

  // https://playwright.dev/docs/api/class-testconfig#test-config-output-dir
  outputDir: path.join(__dirname, '.playwright', 'results'),
  snapshotDir: path.join(__dirname, '.playwright', 'screenshots'),

  /* Run tests in files in parallel */
  fullyParallel: true,
  workers: 4,
  use: {
    baseURL: 'http://127.0.0.1:4000',
    browserName: 'chromium',
    headless: true
  },
  expect: {
    toHaveScreenshot: {
      animations: 'disabled'
    }
  },
  /* Retry on CI only */
  retries: process.env.CI ? 2 : 0,

  reporter: [['line']],

  webServer: {
    command: 'cd demo; bin/rails s -p 4000',
    port: 4000
  }
}

export default config
