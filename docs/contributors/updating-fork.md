# Updating the fork

Whenever Primer is updated to a new version, we will update our fork as well. Since the whole versioning of this repository is done via Changesets, there is more to think about than just merging the latest changes:

To understand that process, let me shortly explain how the versioning with Changesets works:

1. All PRs that commit something release-worthy, have a Changeset file, to be found in the [.changeset](https://github.com/opf/primer_view_components/tree/main/.changeset) folder.
2. There is a Github Action, that creates an automatic Release PullRequest, whenever a new changeset file is merged in to the main branch. There will always be only one Release PR that is updated automatically with every new push to the main branch.
3. When we release, we merge the Release PR which triggers the package build, bumps the version, build the release notes based on the existing changeset files and deletes the changeset files afterwards.

This process, is the same in the upstream Primer repository. Since we aim to have a clean release history to keep track of all changes, I strongly recommend the following process:

**Always only update on version at a time!** Otherwise, the changeset file are already deleted on the `upstream/main` branch and will thus not be part of our release notes.

1. Go to https://github.com/primer/view_components and search for the last commit named `Release Tracking (#XXXX)`. This is the actual release commit that already deleted the changeset files. Since we want to include them (as explained above), have a look at the **last commit before that** and copy the SHA.
2. Then follow these steps:

```
git config remote.upstream.url || git remote add upstream https://github.com/primer/view_components.git
git fetch upstream

git checkout main
git branch -D bump/primer-upstream &>/dev/null || true
git branch -D bump/primer-upstream-ref &>/dev/null || true

git checkout -b bump/primer-upstream-ref
git reset --hard $COMMIT_SHA

git checkout -b bump/primer-upstream
git reset --hard origin/main
git merge bump/primer-upstream-ref
```

There is a [script](https://github.com/opf/primer_view_components/blob/main/script/merge-upstream) that does that automatically for you. It expects the commit SHA, as well as a [SED](https://www.gnu.org/software/sed/manual/sed.html) command line tool as arguments. For OS X I recommend to use `gnu-sed`.

```
brew install gnu-sed
./script/merge-upstream 1234567 gsed
```

3. Resolve the conflicts. Usually, most of the conflicts we changed the name of the repository and are ahead in the version. For those conflicts, you can simply choose our changes. 
4. If you did not use the script, but followed the steps manually, go to the .changeset folder again and search for all occurrences of `@primer/view-components`. Replace that with `@openproject/primer-view-components`. This is the reference to our package name.
5. Commit, push and create a PR. Once all tests are green, you can merge.
6. After the merge, the changes are part of the repository. If you want to release that, you have to merge the current Release PR afterwards as well. Be sure to wait until all GitHub Actions have run through before you do that.
7. Congratulations! You successfully updated :tada:
