# Testing

<!-- prettier-ignore-start -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Testing](#testing)
  - [Table of Contents](#table-of-contents)
  - [Visual testing](#visual-testing)
    - [Prerequisites](#prerequisites)
    - [Continous Integration](#continous-integration)
  - [Other tests](#other-tests)
    - [System tests](#system-tests)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
<!-- prettier-ignore-end -->

## Visual testing

We use Playwright to run visual regression tests against our components along with automated accessibility checks. These tests are authored within the `test/playwright` directory and match the file pattern:
`*.test.ts`.

You can run these tests using Playwright locally but **we recommend you check the results** of
these tests on GitHub through the CI workflow.

To get started locally, make sure to follow the [Prerequisites](#prerequisites)
section to setup your machine. If you're looking for a quick overview of the commands
available, check out the table below.

| Task                                                  | Command                                         |
| :---------------------------------------------------- | :---------------------------------------------- |
| Run playwright tests                                  | `npx playwright test`                           |
| Run a specific test                                   | `npx playwright test path/to/test`              |
| View the report from a test run                       | `npx playwright show-report .playwright/report` |

### Prerequisites

To run Playwright locally, it is recommended to open the repo in a codespace. This is to ensure that the browser
rendering the screenshots will match the browser in CI.

Once you have the codespace open, make sure you're up to date with `script/setup`. Then you can run the `npx playwright test` command.

### Continous Integration

Playwright tests are included in the `Tests > Visual Regressions` jobs of the CI workflow.
The results of the test run are uploaded at the end of the job and are available
to download and view locally.

If you notice that `Tests > Visual Regressions` is failing, you can view the report of the
failing run by visiting the CI workflow, clicking into the job that has failed
and downloading the relevant report.

When the workflow runs, it will check in screenshots of previews for visual diff checking.

## Other tests

Before running the whole test suite with: `script/test`, you must run `bundle exec rake docs:preview`.

Run a subset of tests by supplying arguments to `script/test`:

1. `script/test FILE` runs all tests in the file.
1. `script/test FILE:LINE` runs test in specific line of the file.
1. `script/test 'GLOB'` runs all tests for matching glob.
   1. make sure to wrap the `GLOB` in single quotes `''`.

### System tests

Primer ViewComponents utilizes Cuprite for system testing components that rely on JavaScript functionality.

By default, the system tests run in a headless Chrome browser. Prefix the test command with `HEADLESS=false` to run the system tests in a normal browser.
