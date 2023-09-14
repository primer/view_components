## ❗ Pre-merge checklist

Please ensure these items are checked before merging.

### 🔎 Smoke test

- [ ] All CI checks pass
- [ ] Lookbook opens in a browser
- [ ] Successful integration test with OpenProject as a primary consumer
  - [ ] Install the npm package locally
  - [ ] Install the `primer_view_components` gem locally
  - [ ] Verify no new build errors appear
  - [ ] Verify no new linting errors appear
  - [ ] Manually test critical paths
  - [ ] Manually test release-specific bugfixes and/or features work as described

### 🤔 Sanity test

- [ ] All bugfixes in this release have resolved their corresponding issues
- [ ] All new features in this release have been tested and verified as compatible with OpenProject
- [ ] No noticeable regressions have been introduced as a result of changes in this release
- [ ] Release notes accurately describe the changes made

Please also leave any testing notes as a comment on this pull request. In particular, describing any issues encountered during your testing. This is helpful in providing historical context to maintainers.
