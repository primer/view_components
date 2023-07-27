// eslint-disable-next-line import/no-nodejs-modules
import path from 'node:path'
import type {PlaywrightTestConfig} from '@playwright/test'

/**
 * See https://playwright.dev/docs/test-configuration.
 */
const config: PlaywrightTestConfig = {
  testDir: path.join(__dirname, 'test', 'playwright'),
  testMatch: '**/*.test.ts',
  /* Maximum time one test can run for. */
  timeout: 10 * 1000,

  // https://playwright.dev/docs/api/class-testconfig#test-config-output-dir
  outputDir: path.join(__dirname, '.playwright', 'results'),
  snapshotDir: path.join(__dirname, '.playwright', 'screenshots'),

  /* Run tests in files in parallel */
  fullyParallel: true,
  workers: process.env.CI ? 4 : undefined,
  updateSnapshots: 'all',
  use: {
    baseURL: 'http://127.0.0.1:4000',
    browserName: 'chromium',
    headless: true,
    screenshot: 'only-on-failure'
  },
  expect: {
    toHaveScreenshot: {
      animations: 'disabled'
    },
    toMatchSnapshot: {
      threshold: 0
    }
  },
  /* Retry on CI only */
  retries: process.env.CI ? 2 : 0,

  reporter: [
    ['line'],
    ['html', {open: 'never', outputFolder: path.join(__dirname, '.playwright/report')}],
    ['json', {outputFile: path.join(__dirname, '.playwright', 'results.json')}]
  ],

  webServer: {
    command: 'cd demo; bin/rails s -p 4000',
    port: 4000
  }
}

export default config
