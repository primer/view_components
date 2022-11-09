// eslint-disable-next-line import/no-nodejs-modules
import path from 'node:path'
import type {PlaywrightTestConfig} from '@playwright/test'
import {devices} from '@playwright/test'

/**
 * Read environment variables from file.
 * https://github.com/motdotla/dotenv
 */
// require('dotenv').config();

/**
 * See https://playwright.dev/docs/test-configuration.
 */
const config: PlaywrightTestConfig = {
  testDir: './test/playwright/',
  testMatch: '**/*.test.ts',
  /* Maximum time one test can run for. */
  timeout: 30 * 1000,

  // https://playwright.dev/docs/api/class-testconfig#test-config-output-dir
  outputDir: path.join(__dirname, '.playwright', 'results'),
  snapshotDir: path.join(__dirname, '.playwright', 'screenshots'),

  /* Run tests in files in parallel */
  fullyParallel: true,
  use: {
    screenshot: 'only-on-failure'
  },
  expect: {
    toHaveScreenshot: {
      animations: 'disabled'
    }
  },
  /* Retry on CI only */
  retries: process.env.CI ? 2 : 0,

  reporter: [
    ['line'],
    ['html', {open: 'never', outputFolder: path.join(__dirname, '.playwright/report')}],
    [
      'json',
      {
        outputFile: path.join(__dirname, '.playwright', 'results.json')
      }
    ]
  ],

  /* Configure projects for major browsers */
  projects: [
    {
      name: 'chromium',
      use: {
        ...devices['Desktop Chrome']
      }
    }

    // {
    //   name: 'firefox',
    //   use: {
    //     ...devices['Desktop Firefox']
    //   }
    // },

    // {
    //   name: 'webkit',
    //   use: {
    //     ...devices['Desktop Safari']
    //   }
    // }

    /* Test against mobile viewports. */
    // {
    //   name: 'Mobile Chrome',
    //   use: {
    //     ...devices['Pixel 5'],
    //   },
    // },
    // {
    //   name: 'Mobile Safari',
    //   use: {
    //     ...devices['iPhone 12'],
    //   },
    // },

    /* Test against branded browsers. */
    // {
    //   name: 'Microsoft Edge',
    //   use: {
    //     channel: 'msedge',
    //   },
    // },
    // {
    //   name: 'Google Chrome',
    //   use: {
    //     channel: 'chrome',
    //   },
    // },
  ],

  /* Folder for test artifacts such as screenshots, videos, traces, etc. */
  // outputDir: 'test-results/',

  /* Run your local dev server before starting the tests */
  webServer: {
    command: 'cd demo; bin/rails s -p 4000',
    port: 4000
  }
}

export default config
