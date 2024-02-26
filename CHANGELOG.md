# CHANGELOG

## 0.19.0

### Minor Changes

- [#2607](https://github.com/primer/view_components/pull/2607) [`1cf14e5`](https://github.com/primer/view_components/commit/1cf14e5034b7461663a982a80c6756f09f4fa968) Thanks [@camertron](https://github.com/camertron)! - Add ability to attach action menus to button group buttons

- [#2626](https://github.com/primer/view_components/pull/2626) [`1160edf`](https://github.com/primer/view_components/commit/1160edf76c72de4cc71f7b4ed435ebd336feb854) Thanks [@camertron](https://github.com/camertron)! - Upgrade to view_component v3.11.0

- [#2640](https://github.com/primer/view_components/pull/2640) [`56b2413`](https://github.com/primer/view_components/commit/56b24139e7b58a337cf98203cf7a765adfd20414) Thanks [@khiga8](https://github.com/khiga8)! - Mark `Flash` as deprecated

- [#2604](https://github.com/primer/view_components/pull/2604) [`8d67631`](https://github.com/primer/view_components/commit/8d67631298b6bbef8efb9acb2ced412253fe0d26) Thanks [@mattcosta7](https://github.com/mattcosta7)! - update tsconfig compile target

### Patch Changes

- [#2628](https://github.com/primer/view_components/pull/2628) [`5619810`](https://github.com/primer/view_components/commit/56198108dfb38c1a2a2b52e6798bbbd3ba143090) Thanks [@langermank](https://github.com/langermank)! - Primitives v8 bug fix: `invisible` button hover state in high contrast themes

- [#2620](https://github.com/primer/view_components/pull/2620) [`59c3396`](https://github.com/primer/view_components/commit/59c3396d4676947ffe98022dc8f7752eecf82cd0) Thanks [@khiga8](https://github.com/khiga8)! - Docs: update accessibility section of PVC Banner

- [#2611](https://github.com/primer/view_components/pull/2611) [`8c111df`](https://github.com/primer/view_components/commit/8c111df3cbd0c8964ab2376c72db2dc72e288de7) Thanks [@lindseywild](https://github.com/lindseywild)! - Update README docs with instructions to preview docs site locally

## 0.18.2

### Patch Changes

- [#2577](https://github.com/primer/view_components/pull/2577) [`6a3071d`](https://github.com/primer/view_components/commit/6a3071d6adc1135576156df9bc48fd99d23c0153) Thanks [@lindseywild](https://github.com/lindseywild)! - Adds documentation for the Rails Banner and focus management guidance

- [#2579](https://github.com/primer/view_components/pull/2579) [`c195fc5`](https://github.com/primer/view_components/commit/c195fc51dc373b86f8f8461a52562d18797c363c) Thanks [@keithamus](https://github.com/keithamus)! - Remove aria-disabled from dialogs

- [#2556](https://github.com/primer/view_components/pull/2556) [`077cb08`](https://github.com/primer/view_components/commit/077cb08fe4f7ef5c8e512879bd2847d90f74dea4) Thanks [@keithamus](https://github.com/keithamus)! - Fix issue with layering of nested overlays/dialogs

- [#2557](https://github.com/primer/view_components/pull/2557) [`77e59ee`](https://github.com/primer/view_components/commit/77e59ee8af781711026c7785ef58c300561c6e7d) Thanks [@keithamus](https://github.com/keithamus)! - Fix potential out-of-bounds error in ActionBar

- [#2585](https://github.com/primer/view_components/pull/2585) [`6124098`](https://github.com/primer/view_components/commit/61240988a7e7f0f76a8df1cc361ef6facf240ab7) Thanks [@khiga8](https://github.com/khiga8)! - Bug: Remove dismissable flash stealing focus

## 0.18.1

### Patch Changes

- [#2554](https://github.com/primer/view_components/pull/2554) [`652e795`](https://github.com/primer/view_components/commit/652e7957c59ddc5d05af9c9bc797a917d01cf453) Thanks [@keithamus](https://github.com/keithamus)! - Ensure Overlays that open dialogs do not close when the Dialog opens

- [#2553](https://github.com/primer/view_components/pull/2553) [`1ca2f17`](https://github.com/primer/view_components/commit/1ca2f1790a5fb95069f85936d6cb1deafad782fd) Thanks [@keithamus](https://github.com/keithamus)! - Ensure only direct clicks to the dialog can close it

## 0.18.0

### Minor Changes

- [#2551](https://github.com/primer/view_components/pull/2551) [`5340243`](https://github.com/primer/view_components/commit/5340243c91a5a7d020cf216f421704fc5a76afca) Thanks [@jonrohan](https://github.com/jonrohan)! - Remove large size options from SegmentedControl

### Patch Changes

- [#2527](https://github.com/primer/view_components/pull/2527) [`1d20198`](https://github.com/primer/view_components/commit/1d201989bfe0d1fb6cdb879f82264bdc55978d8d) Thanks [@keithamus](https://github.com/keithamus)! - Remove animations on actionlist checkmark

- [#2549](https://github.com/primer/view_components/pull/2549) [`1259249`](https://github.com/primer/view_components/commit/1259249eaddd4b8744a3dc212fb9f8800b45daac) Thanks [@keithamus](https://github.com/keithamus)! - Ensure dialogs do not close when a child menu item (or similar) is clicked

## 0.17.0

### Minor Changes

- [#2539](https://github.com/primer/view_components/pull/2539) [`9985fc0`](https://github.com/primer/view_components/commit/9985fc01ef4a343a7c455ec114a68a249a01ed3e) Thanks [@camertron](https://github.com/camertron)! - Use latest version of @primer/primitives

- [#2496](https://github.com/primer/view_components/pull/2496) [`983e3a5`](https://github.com/primer/view_components/commit/983e3a5fbf885c46d5bde0c749b0f9298ab2b53f) Thanks [@keithamus](https://github.com/keithamus)! - Primer::Alpha::Dialog uses <dialog> internally

### Patch Changes

- [#2495](https://github.com/primer/view_components/pull/2495) [`fbaea76`](https://github.com/primer/view_components/commit/fbaea76c3209a7c4e92d18b3b80bb347f971c448) Thanks [@antn](https://github.com/antn)! - Allow setting `test_selector` on select list options

- [#2538](https://github.com/primer/view_components/pull/2538) [`35e5d06`](https://github.com/primer/view_components/commit/35e5d0696f503bf2bac14329dc455cc6245f6ba9) Thanks [@camertron](https://github.com/camertron)! - Prevent ActionMenu's show_button slot from rendering its content more than once

- [#2541](https://github.com/primer/view_components/pull/2541) [`116a343`](https://github.com/primer/view_components/commit/116a3438d0f9404483b638ef3f13a656609415cb) Thanks [@khiga8](https://github.com/khiga8)! - Allow `Banner` to be rendered as a section

- [#2530](https://github.com/primer/view_components/pull/2530) [`1d14d5c`](https://github.com/primer/view_components/commit/1d14d5c03a528930ac59bb8ec30fbec2ea92883e) Thanks [@camertron](https://github.com/camertron)! - Update @oddbird/popover-polyfill to v0.3.8

- [#2491](https://github.com/primer/view_components/pull/2491) [`11b1eec`](https://github.com/primer/view_components/commit/11b1eecc817c7013ed56c84f7050e642b098db41) Thanks [@jonrohan](https://github.com/jonrohan)! - Fixing the utilities build not matching properly for `font_size`

- [#2511](https://github.com/primer/view_components/pull/2511) [`15a090a`](https://github.com/primer/view_components/commit/15a090a999e69056d78ba099671ff1f68d61c610) Thanks [@camertron](https://github.com/camertron)! - Only attach validation IDs to form elements that support validation

## 0.16.1

### Patch Changes

- [#2478](https://github.com/primer/view_components/pull/2478) [`6e7b7c2`](https://github.com/primer/view_components/commit/6e7b7c2340339a15b21857ee1fbc734a5760135d) Thanks [@jonrohan](https://github.com/jonrohan)! - Bug fix in ActionBar: When collapsed the menu and tooltips aren't visible in Firefox

## 0.16.0

### Minor Changes

- [#2445](https://github.com/primer/view_components/pull/2445) [`da60c73`](https://github.com/primer/view_components/commit/da60c7370104a7edd8713d271210e2c9cb3eeb96) Thanks [@camertron](https://github.com/camertron)! - Always convert CSS classes to system arguments in linters

- [#2447](https://github.com/primer/view_components/pull/2447) [`08a8e01`](https://github.com/primer/view_components/commit/08a8e012572bb5d2248f89acdaf7329747fd3108) Thanks [@kenyonj](https://github.com/kenyonj)! - Support font_size and border_radius in classify/utilities

### Patch Changes

- [#2452](https://github.com/primer/view_components/pull/2452) [`87e03ea`](https://github.com/primer/view_components/commit/87e03ea4dd41822454c72ddb7e55b0aa9294c69c) Thanks [@nicolleromero](https://github.com/nicolleromero)! - Ensure tooltip does not reopen errantly unless focus is visible

- [#2456](https://github.com/primer/view_components/pull/2456) [`fd38b17`](https://github.com/primer/view_components/commit/fd38b170014cfadbd8ecc78814f70a5323fda3ee) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Adds visible outlines to `Overlay` and `Tooltip` in high contrast mode.

- [#2432](https://github.com/primer/view_components/pull/2432) [`c162880`](https://github.com/primer/view_components/commit/c162880a5a57b86fd6f640d0dd5c9a4548335f09) Thanks [@dylanatsmith](https://github.com/dylanatsmith)! - Remove `user-select: none` to allow users to select form label text

- [#2428](https://github.com/primer/view_components/pull/2428) [`4cb9a57`](https://github.com/primer/view_components/commit/4cb9a57de1d507e7c22d7c3cdb39b20e73bc36bc) Thanks [@strackoverflow](https://github.com/strackoverflow)! - Fix an accessibility issue where the Dialog body could not be reached via keyboard navigation

- [#2411](https://github.com/primer/view_components/pull/2411) [`58e700a`](https://github.com/primer/view_components/commit/58e700ab9222054bc803541d9eccc4877254b1c1) Thanks [@keithamus](https://github.com/keithamus)! - Ensure scroll position does not change when opening ActionMenus

- [#2425](https://github.com/primer/view_components/pull/2425) [`65f418f`](https://github.com/primer/view_components/commit/65f418f8f191768b0fc0b92ffd2a681631594631) Thanks [@camertron](https://github.com/camertron)! - Use floats to hide ActionBar items to address Android Chrome overflow issue

- [#2455](https://github.com/primer/view_components/pull/2455) [`6ca4ac4`](https://github.com/primer/view_components/commit/6ca4ac4476b00be4f5561ae3ad452c4609dd2928) Thanks [@HDinger](https://github.com/HDinger)! - Make dismiss action on Banner translatable

- [#2434](https://github.com/primer/view_components/pull/2434) [`dc87edf`](https://github.com/primer/view_components/commit/dc87edf407d98cdefc32d095fea99909c066a2fc) Thanks [@langermank](https://github.com/langermank)! - Add missing `box-shadow` to text field

## 0.15.1

### Patch Changes

- [#2426](https://github.com/primer/view_components/pull/2426) [`78dd9dd`](https://github.com/primer/view_components/commit/78dd9ddb70ee5ade30e243968c87364a80ff1325) Thanks [@camertron](https://github.com/camertron)! - Fix typo in argument passed to event listener in ToolTip

## 0.15.0

### Minor Changes

- [#2378](https://github.com/primer/view_components/pull/2378) [`81b5acc6`](https://github.com/primer/view_components/commit/81b5acc641d2bebc3a634fe0d5d712ad289747cd) Thanks [@keithamus](https://github.com/keithamus)! - Primer::Alpha::ActionList now uses popover

- [#2340](https://github.com/primer/view_components/pull/2340) [`b8d05407`](https://github.com/primer/view_components/commit/b8d05407b42ec843f4a46b979779e6db69bd56ba) Thanks [@camertron](https://github.com/camertron)! - Add group support to ActionMenu

- [#2393](https://github.com/primer/view_components/pull/2393) [`745eae0d`](https://github.com/primer/view_components/commit/745eae0d0be5efa3f368630b49db1eda2a11307e) Thanks [@camertron](https://github.com/camertron)! - [ActionMenu] Don't allow previously hidden items to be checkable; add JavaScript API

### Patch Changes

- [#2414](https://github.com/primer/view_components/pull/2414) [`48a2405a`](https://github.com/primer/view_components/commit/48a2405a2cdb6865eb57c2ea411fcece026590d0) Thanks [@keithamus](https://github.com/keithamus)! - Prevent other Overlays closing when Escape is pressed while Tooltips are open

- [#2379](https://github.com/primer/view_components/pull/2379) [`2c59c33b`](https://github.com/primer/view_components/commit/2c59c33bf54e392d743fbdd1076d06bff2151b42) Thanks [@mperrotti](https://github.com/mperrotti)! - Updates 'inactive' state for buttons based on feedback from the a11y team:

  - inactive buttons need to meet the color contrast ratio minimum
  - inactive buttons shouldn't have aria-disabled since they can still accept interactions such as:
    - hover/focus to show a tooltip
    - click/activate to show a dialog with more detailed info on why it's inactive

  <!-- Changed components: Button -->

- [#2408](https://github.com/primer/view_components/pull/2408) [`57586da4`](https://github.com/primer/view_components/commit/57586da49cf0f82c0da4736bc276984d6ea3b479) Thanks [@HDinger](https://github.com/HDinger)! - Fix: Allow month attribute for Primer::Beta::RelativeTime

- [#2406](https://github.com/primer/view_components/pull/2406) [`fb9bf257`](https://github.com/primer/view_components/commit/fb9bf257c358add060679d401719993b21ce7f45) Thanks [@strackoverflow](https://github.com/strackoverflow)! - Fix an issue where multiple groups could not be paginated within the same NavList

- [#2412](https://github.com/primer/view_components/pull/2412) [`e7c9a6c6`](https://github.com/primer/view_components/commit/e7c9a6c62b82ec9ebff575ddd5fbd361fcc40334) Thanks [@camertron](https://github.com/camertron)! - Prevent Blankslates from having a zero width inside flex containers

## 0.14.0

### Minor Changes

- [#2367](https://github.com/primer/view_components/pull/2367) [`b2acc97d`](https://github.com/primer/view_components/commit/b2acc97d69203094911d013eea07c8e0de6daa02) Thanks [@camertron](https://github.com/camertron)! - Add an ActionMenu form input

- [#2335](https://github.com/primer/view_components/pull/2335) [`684f9a51`](https://github.com/primer/view_components/commit/684f9a51a1ccb006a9ce2fbadb296ca5c68bd560) Thanks [@camertron](https://github.com/camertron)! - Add a ClipboardCopyButton component

- [#2365](https://github.com/primer/view_components/pull/2365) [`314c0f1f`](https://github.com/primer/view_components/commit/314c0f1f1ec8152c0a0862ee3468e88efcad0ec8) Thanks [@camertron](https://github.com/camertron)! - Remove touch target gaps between ActionBar items

- [#2296](https://github.com/primer/view_components/pull/2296) [`3374555e`](https://github.com/primer/view_components/commit/3374555ee1d2c24e88ca4a53cc58221a0ec2bc51) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the button wrapper `Button--withTooltip` when using a tooltip with a button.

- [#2330](https://github.com/primer/view_components/pull/2330) [`6bf8da54`](https://github.com/primer/view_components/commit/6bf8da54220c3301ad0bc2bbb44c2905ad6db89c) Thanks [@camertron](https://github.com/camertron)! - Allow several font sizes for Subhead headings

- [#2336](https://github.com/primer/view_components/pull/2336) [`94db2c4b`](https://github.com/primer/view_components/commit/94db2c4bc590e6b41760f5a8867c6b1cae669a1d) Thanks [@camertron](https://github.com/camertron)! - Add Rails 7.1 support

- [#2366](https://github.com/primer/view_components/pull/2366) [`73d05613`](https://github.com/primer/view_components/commit/73d05613ec2a5eb2731b170927c505e9c688f4e0) Thanks [@camertron](https://github.com/camertron)! - Add missing 64px Avatar size

- [#2377](https://github.com/primer/view_components/pull/2377) [`482152ae`](https://github.com/primer/view_components/commit/482152aec156982cc309aaa830e46269a46ef355) Thanks [@gwwar](https://github.com/gwwar)! - Updates Primer::Alpha::TextField to support success inline validation messages and allows validation messages to contain html fragments.
  <!-- Changed components: Primer::Alpha::TextField -->

### Patch Changes

- [#2360](https://github.com/primer/view_components/pull/2360) [`94b7a445`](https://github.com/primer/view_components/commit/94b7a4455fbe0c80472034c7268f4beaa654cd2f) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Removes redundant `aria-disabled` from list item within `ActionMenu`.

- [#2337](https://github.com/primer/view_components/pull/2337) [`0189b553`](https://github.com/primer/view_components/commit/0189b553f9fb94858d5526a669d006dc0b2a6050) Thanks [@mperrotti](https://github.com/mperrotti)! - Adapts Blankslate to render proportionally in narrow areas

  <!-- Changed components: Blankslate -->

- [#2383](https://github.com/primer/view_components/pull/2383) [`7c2e6f6c`](https://github.com/primer/view_components/commit/7c2e6f6c6c3cc8cd69758b36760f4e18ec4e48ba) Thanks [@strackoverflow](https://github.com/strackoverflow)! - Fix an issue where ActionMenu wouldn't scroll its contents

- [#2384](https://github.com/primer/view_components/pull/2384) [`2c778661`](https://github.com/primer/view_components/commit/2c7786615ceb6b0149b87fb9d01ad31f977a908d) Thanks [@camertron](https://github.com/camertron)! - Re-introduce require 'primer/form_helper' for setups that rely on Rails eager load paths

## 0.13.2

### Patch Changes

- [#2331](https://github.com/primer/view_components/pull/2331) [`4f8af24f`](https://github.com/primer/view_components/commit/4f8af24f2bb657c09d3b371a9d2ab1e30ac3ad7c) Thanks [@camertron](https://github.com/camertron)! - Prevent scrolling when activating ActionMenu form items via space

- [#2323](https://github.com/primer/view_components/pull/2323) [`c481ed2d`](https://github.com/primer/view_components/commit/c481ed2dedf9a480dca2a4ba41d2f1e3b39a2687) Thanks [@keithamus](https://github.com/keithamus)! - Fix bug in ActionMenu/Tooltip/Overlay being always visible in Firefox on ios 17

## 0.13.1

### Patch Changes

- [#2326](https://github.com/primer/view_components/pull/2326) [`4e05b7ec`](https://github.com/primer/view_components/commit/4e05b7ecb764b104a0afa35c478eff5c79f9270e) Thanks [@camertron](https://github.com/camertron)! - Prevent scrolling when activating ActionMenu items via space

- [#2324](https://github.com/primer/view_components/pull/2324) [`cc44952c`](https://github.com/primer/view_components/commit/cc44952c1c84e4fcd3ad6dc786db7211cdb82d36) Thanks [@langermank](https://github.com/langermank)! - Revert Tooltip caret removal

  <!-- Changed components: Tooltip -->

## 0.13.0

### Minor Changes

- [#2284](https://github.com/primer/view_components/pull/2284) [`374d10fd`](https://github.com/primer/view_components/commit/374d10fd18e7371f49abf75dde135c3ed29fe33d) Thanks [@langermank](https://github.com/langermank)! - Update tooltip design

  - Removes caret
  - Decrease offset
  - Remove animation delay
  - Use v8 color tokens

  <!-- Changed components: Tooltip -->

- [#2293](https://github.com/primer/view_components/pull/2293) [`d7eafca0`](https://github.com/primer/view_components/commit/d7eafca0b2bbcea41f28c7ab16e6f396c150be8f) Thanks [@camertron](https://github.com/camertron)! - Fix multi-select behavior when ActionMenus are embedded in dialogs

  <!-- Changed components: Primer::Alpha::ActionMenu -->

- [#2291](https://github.com/primer/view_components/pull/2291) [`725bbd95`](https://github.com/primer/view_components/commit/725bbd954564995667398b1ea0b1388d4f6d8410) Thanks [@camertron](https://github.com/camertron)! - Allow ActionMenu items to submit multiple values on form submission; fix keyboard handling for submit items

  <!-- Changed components: Primer::Alpha::ActionMenu -->

### Patch Changes

- [#2286](https://github.com/primer/view_components/pull/2286) [`02e7f785`](https://github.com/primer/view_components/commit/02e7f785666bb85f522fe31c51a51c9a58806e33) Thanks [@langermank](https://github.com/langermank)! - fix SegmentedControl alignment issues

  <!-- Changed components: SegmentedControl -->

- [#2288](https://github.com/primer/view_components/pull/2288) [`caf09967`](https://github.com/primer/view_components/commit/caf09967dd29668f380e509514ec98b9aa95baa7) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Fixes issue where sometimes a dialog cannot be closed if another is open

  <!-- Changed components: Primer::Alpha::Dialog -->

- [#2292](https://github.com/primer/view_components/pull/2292) [`46e3ff02`](https://github.com/primer/view_components/commit/46e3ff02bd1e253e2bfb3bb2a586c589b3aa0c5b) Thanks [@jonrohan](https://github.com/jonrohan)! - Fix ActionBar issue where left and end key don't loop around to end of the action bar items.

- [#2290](https://github.com/primer/view_components/pull/2290) [`f33eed35`](https://github.com/primer/view_components/commit/f33eed35e619550bf2937d3f8f2ecaa219369d46) Thanks [@jonrohan](https://github.com/jonrohan)! - Bug fix: Respect autofocus attributes inside of a Dialog when opening a modal-dialog. When the dialog was opening before it was always focusing the first focusable element which was always the close button.

## 0.12.0

### Minor Changes

- [#2283](https://github.com/primer/view_components/pull/2283) [`da3bdb26`](https://github.com/primer/view_components/commit/da3bdb267e5753942d24e578a8aa2c6d339e5c83) Thanks [@mperrotti](https://github.com/mperrotti)! - Adds an 'inactive' state to buttons. An inactive button looks disabled and has aria-disabled, but it can still be clicked and focused. This was added to support buttons that are broken due to availability issues, but can't be removed from the page.

  <!-- Changed components: Primer::Beta::Button, Primer::Beta::BaseButton, Primer::Beta::IconButton -->

- [#2278](https://github.com/primer/view_components/pull/2278) [`83b70dd7`](https://github.com/primer/view_components/commit/83b70dd73ad970388a3fa6b107d4ca8e4c94a986) Thanks [@gwwar](https://github.com/gwwar)! - Add optional with_trailing_visual_label slot to Primer::Alpha::SegmentedControl::Item. Filling the slot will add a Primer::Beta::Label to the right of the item.
  <!-- Changed components: Primer::Alpha::SegmentedControl -->

### Patch Changes

- [#2281](https://github.com/primer/view_components/pull/2281) [`46d5d9cb`](https://github.com/primer/view_components/commit/46d5d9cb5b624eee147f67cabcfa8034c7e1668c) Thanks [@keithamus](https://github.com/keithamus)! - Fix tooltips opening when focus is removed while displaying

## 0.11.0

### Minor Changes

- [#2276](https://github.com/primer/view_components/pull/2276) [`7184d76e`](https://github.com/primer/view_components/commit/7184d76edbe94b008158940d15909b1778c9ed8c) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding option item_arguments hash argument to ActionBar::Item that will control the item system arguments

  <!-- Changed components: Primer::Alpha::ActionBar -->

- [#2259](https://github.com/primer/view_components/pull/2259) [`a2fe6134`](https://github.com/primer/view_components/commit/a2fe61342b2f3527533902d845f5a9d500d6910c) Thanks [@TylerJDev](https://github.com/TylerJDev)! - \* Includes ActionMenu in ActionBar focus trap when present.

  - Adjusts `focus_group.ts` to set `tabindex="0"` back to invoker if it is non-focusable.
  - Prevents popover invokers from being triggered with 'left' and 'right' arrow keys.

  <!-- Changed components: Primer::Alpha::ActionBar, Primer::Alpha::ActionMenu -->

### Patch Changes

- [#2260](https://github.com/primer/view_components/pull/2260) [`b584a6b5`](https://github.com/primer/view_components/commit/b584a6b57e07b4def45bd30e90bf31203e7b7010) Thanks [@camertron](https://github.com/camertron)! - ActionMenu: hide the menu when focus leaves the component; focus the first list item when the menu is activated with the mouse; allow disabling list items while still permitting them to be focused with the keyboard

  <!-- Changed components: Primer::Alpha::ActionMenu -->

## 0.10.0

### Minor Changes

- [#2240](https://github.com/primer/view_components/pull/2240) [`512fc39e`](https://github.com/primer/view_components/commit/512fc39eef56321e2f2001604b4c4c89ca656c63) Thanks [@camertron](https://github.com/camertron)! - Allow anonymous forms, mostly useful for tests

  <!-- Changed components: _none_ -->

- [#2241](https://github.com/primer/view_components/pull/2241) [`3f7e6198`](https://github.com/primer/view_components/commit/3f7e61989c31a19fafc07b01ca48d5554ab269de) Thanks [@camertron](https://github.com/camertron)! - Enable validation messages on radio button and check box groups

  <!-- Changed components: Primer::Alpha::CheckBoxGroup, Primer::Alpha::RadioButtonGroup -->

- [#2247](https://github.com/primer/view_components/pull/2247) [`09648632`](https://github.com/primer/view_components/commit/09648632c5b083b87f03e006e38f303bd75bc9cc) Thanks [@jonrohan](https://github.com/jonrohan)! - Graduate NavList to beta status

  <!-- Changed components: Primer::Alpha::NavList, Primer::Beta::NavList -->

- [#2251](https://github.com/primer/view_components/pull/2251) [`4a51102d`](https://github.com/primer/view_components/commit/4a51102d49c57ac0caaafa54e1c422afc66dd8ca) Thanks [@camertron](https://github.com/camertron)! - Add header variant to Dialog

  <!-- Changed components: Primer::Alpha::Dialog -->

### Patch Changes

- [#2256](https://github.com/primer/view_components/pull/2256) [`fd17adfd`](https://github.com/primer/view_components/commit/fd17adfd1cca6d034d3063b3ac7ab107b1725a8d) Thanks [@langermank](https://github.com/langermank)! - Fix disabled styles for radio

  <!-- Changed components: _none_ -->

- [#2250](https://github.com/primer/view_components/pull/2250) [`66c4dd69`](https://github.com/primer/view_components/commit/66c4dd6936b386caa42868beef9ea1b33f84b11b) Thanks [@langermank](https://github.com/langermank)! - - Improve contrast for icons in `invisible` button on hover in dark mode (within v8 colors)

  - Fix disabled button styles (v8 colors)
  - Bump Primitives to latest

  <!-- Changed components: Primer::Beta::Button -->

- [#2242](https://github.com/primer/view_components/pull/2242) [`bc254f13`](https://github.com/primer/view_components/commit/bc254f135eeb57b9872665d5e8ce1c30a8208f33) Thanks [@keithamus](https://github.com/keithamus)! - Remove background from anchored-position

  <!-- Changed components: Primer::Alpha::ActionMenu, Primer::Alpha::Overlay -->

- [#2249](https://github.com/primer/view_components/pull/2249) [`1209d241`](https://github.com/primer/view_components/commit/1209d2415c944796741c57150b8a41679d634fe5) Thanks [@camertron](https://github.com/camertron)! - Fix underline behavior in Link component

  <!-- Changed components: Primer::Beta::Link -->

- [#2254](https://github.com/primer/view_components/pull/2254) [`cdb9fe4d`](https://github.com/primer/view_components/commit/cdb9fe4d2e5d4c49c0aa4c76567709d9ac58ac7a) Thanks [@keithamus](https://github.com/keithamus)! - Only supply aria-label on Overlays with a role assigned

  <!-- Changed components: Primer::Alpha::ActionMenu, Primer::Alpha::Overlay -->

- [#2245](https://github.com/primer/view_components/pull/2245) [`495f911c`](https://github.com/primer/view_components/commit/495f911c5c4be2d8722dbb811eacc23a35e7d36a) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Fix bug in ActionMenu keyboard navigation, where items aren't skipped when they're functionally `[hidden]`.

  <!-- Changed components: Primer::Alpha::ActionMenu -->

- [#2244](https://github.com/primer/view_components/pull/2244) [`3c5fb3a7`](https://github.com/primer/view_components/commit/3c5fb3a70df51e10e720b97422678aa0b19a256e) Thanks [@camertron](https://github.com/camertron)! - Fix race condition causing dotcom axe check failures for icon button tooltips

  <!-- Changed components: Primer::Alpha::Tooltip, Primer::Beta::IconButton -->

- [#2248](https://github.com/primer/view_components/pull/2248) [`9885a5d8`](https://github.com/primer/view_components/commit/9885a5d8566df6c6b0dc165986c7cf60f051299a) Thanks [@keithamus](https://github.com/keithamus)! - Update popover support in older browsers.

  <!-- Changed components: Primer::Alpha::ActionMenu, Primer::Alpha::Overlay -->

## 0.9.0

### Minor Changes

- [#2205](https://github.com/primer/view_components/pull/2205) [`88ac3095`](https://github.com/primer/view_components/commit/88ac309577b5b735af5067ee6ab2c8c30f48aefc) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Add rubocop linter for `IconButton` component

  <!-- Changed components: Primer::IconButton -->

- [#2223](https://github.com/primer/view_components/pull/2223) [`00b7d5d7`](https://github.com/primer/view_components/commit/00b7d5d78e2f52dc6bc6c54689e50da976289203) Thanks [@jonrohan](https://github.com/jonrohan)! - Moving the render for the ActionBar::Item from the slot initializer to the call method.

  <!-- Changed components: _none_ -->

### Patch Changes

- [#2227](https://github.com/primer/view_components/pull/2227) [`bb336bb6`](https://github.com/primer/view_components/commit/bb336bb6f034e20778b4834edae3540c365b9d9f) Thanks [@jonrohan](https://github.com/jonrohan)! - [Bug] Don't fill in the spinner circle svg path

- [#2237](https://github.com/primer/view_components/pull/2237) [`70a8336f`](https://github.com/primer/view_components/commit/70a8336fda45b144f81c1ece54b17a26037126e4) Thanks [@jonrohan](https://github.com/jonrohan)! - Fixing ActionBar more menu items including buttons with no type

  <!-- Changed components: Primer::Alpha::ActionBar -->

- [#2204](https://github.com/primer/view_components/pull/2204) [`ed1644a2`](https://github.com/primer/view_components/commit/ed1644a2fa5b701611a13513cb903774f3f74152) Thanks [@keithamus](https://github.com/keithamus)! - Fix errors in older browsers with :popover-open

  <!-- Changed components: Primer::Alpha::Tooltip -->

- [#2236](https://github.com/primer/view_components/pull/2236) [`d663e450`](https://github.com/primer/view_components/commit/d663e4508341f5b9ef1788b8a2231782ce3ed44d) Thanks [@keithamus](https://github.com/keithamus)! - Centre anchored-position elements when their anchor is not present

  <!-- Changed components: Primer::Alpha::Overlay -->

## 0.8.0

### Minor Changes

- [#2215](https://github.com/primer/view_components/pull/2215) [`827634e9`](https://github.com/primer/view_components/commit/827634e9a442fc6a6508235bdd38a1739e88cf5e) Thanks [@mjimenez98](https://github.com/mjimenez98)! - Support SVGs as leading visuals in `Button` component

  <!-- Changed components: Primer::Beta::Button -->

- [#2222](https://github.com/primer/view_components/pull/2222) [`e196af7b`](https://github.com/primer/view_components/commit/e196af7bed7f862f758f5edfd51107579128e0ee) Thanks [@jonrohan](https://github.com/jonrohan)! - Replace dismiss button in Flash with IconButton

  <!-- Changed components: Primer::Beta::Flash -->

### Patch Changes

- [#2213](https://github.com/primer/view_components/pull/2213) [`bc4b3340`](https://github.com/primer/view_components/commit/bc4b33402a7cae813a77bafa7de9e1c7f2fc5419) Thanks [@camertron](https://github.com/camertron)! - Support Rails edge's custom deprecators

  <!-- Changed components: _none_ -->

- [#2212](https://github.com/primer/view_components/pull/2212) [`3d0036ae`](https://github.com/primer/view_components/commit/3d0036ae50b611942347d065f5be55822ec17748) Thanks [@keithamus](https://github.com/keithamus)! - Fix dialog invocation within deferred ActionMenus

  <!-- Changed components: Primer::Alpha::ActionMenu -->

## 0.7.0

### Minor Changes

- [#2200](https://github.com/primer/view_components/pull/2200) [`1b770f90`](https://github.com/primer/view_components/commit/1b770f9000faa119eb2ece3035be2eaa476ca1a1) Thanks [@TylerJDev](https://github.com/TylerJDev)! - Add rubocop linter for `Truncate` component

  <!-- Changed components: _none_ -->

- [#2207](https://github.com/primer/view_components/pull/2207) [`ba01f4e9`](https://github.com/primer/view_components/commit/ba01f4e9f7d287c01fb3dab1b04b58c49c1d71fb) Thanks [@langermank](https://github.com/langermank)! - Bump Primitives v7.12.0

  <!-- Changed components: _none_ -->

- [#2210](https://github.com/primer/view_components/pull/2210) [`aded2aa4`](https://github.com/primer/view_components/commit/aded2aa45261b13d870f474889d6bc6a803c484a) Thanks [@khiga8](https://github.com/khiga8)! - Fix accessibility bug of missing accessible name on `Primer::Alpha::Dialog`

  <!-- Changed components: Primer::Alpha::Dialog -->

### Patch Changes

- [#2203](https://github.com/primer/view_components/pull/2203) [`3f504021`](https://github.com/primer/view_components/commit/3f504021e26cb92c99b16b63fe3e9b45fd5ede3b) Thanks [@orhantoy](https://github.com/orhantoy)! - Fix guide URLs (in lib/primer/deprecations.yml)

  <!-- Changed components: _none_ -->

- [#2192](https://github.com/primer/view_components/pull/2192) [`73fc40bb`](https://github.com/primer/view_components/commit/73fc40bb83ac2b14936e38ad2706cfdd68abc34f) Thanks [@camertron](https://github.com/camertron)! - ActionMenu: Don't allow items to be unchecked in single-select mode

  <!-- Changed components: Primer::Alpha::ActionMenu -->

- [#2211](https://github.com/primer/view_components/pull/2211) [`9623ab63`](https://github.com/primer/view_components/commit/9623ab63dfb6a658d416376291d28ade9bf2b1fd) Thanks [@jonrohan](https://github.com/jonrohan)! - Updating tooltip migration linter link to correct url

- [#2202](https://github.com/primer/view_components/pull/2202) [`d7da4012`](https://github.com/primer/view_components/commit/d7da4012cb0a1d268cb0557cce171137dc766890) Thanks [@camertron](https://github.com/camertron)! - Label BorderBox lists with their header

  <!-- Changed components: Primer::Beta::BorderBox -->

- [#2190](https://github.com/primer/view_components/pull/2190) [`0a9bcda2`](https://github.com/primer/view_components/commit/0a9bcda29eedd5b4854ce71a413b22f275283729) Thanks [@radglob](https://github.com/radglob)! - Updates Primer::Beta::Button.with_tooltip to not accept `:label` type.

  <!-- Changed components: Primer::Beta::Button -->

- [#2201](https://github.com/primer/view_components/pull/2201) [`ba90a43d`](https://github.com/primer/view_components/commit/ba90a43d9904bb088e1ce3988c3b94211155e722) Thanks [@kintner](https://github.com/kintner)! - add aria-invalid when fields are invalid

  <!-- Changed components: Primer::Alpha::CheckBox, Primer::Alpha::CheckBoxGroup, Primer::Alpha::FormButton, Primer::Alpha::MultiInput, Primer::Alpha::RadioButton, Primer::Alpha::RadioButtonGroup, Primer::Alpha::Select, Primer::Alpha::SubmitButton, Primer::Alpha::TextArea, Primer::Alpha::TextField, Primer::Alpha::ToggleSwitch -->

## 0.6.0

### Minor Changes

- [#2187](https://github.com/primer/view_components/pull/2187) [`ce2011e6`](https://github.com/primer/view_components/commit/ce2011e615325b2e18d0974b5a08831ef442681f) Thanks [@camertron](https://github.com/camertron)! - Expose ActionList's #build_item and #build_avatar_item externally to facilitate parent-less item construction

  <!-- Changed components: Primer::Alpha::ActionList, Primer::Alpha::ActionMenu, Primer::Alpha::NavList -->

- [#2188](https://github.com/primer/view_components/pull/2188) [`5950afea`](https://github.com/primer/view_components/commit/5950afea48dca275df11603ffab6f8689777e08d) Thanks [@camertron](https://github.com/camertron)! - Allow disabling submit buttons

  <!-- Changed components: Primer::Alpha::FormButton, Primer::Alpha::SubmitButton -->

- [#2165](https://github.com/primer/view_components/pull/2165) [`1b8ff1b7`](https://github.com/primer/view_components/commit/1b8ff1b7883b9870dfc09c6b59f26d17b8d2be92) Thanks [@camertron](https://github.com/camertron)! - Add an accessible avatar item to ActionList, NavList, and ActionMenu

  <!-- Changed components: Primer::Alpha::ActionList, Primer::Alpha::ActionMenu, Primer::Alpha::NavList -->

- [#2186](https://github.com/primer/view_components/pull/2186) [`eab82c07`](https://github.com/primer/view_components/commit/eab82c0780b219f1d3a118cc912561f33ac49e7e) Thanks [@camertron](https://github.com/camertron)! - On dismiss, allow banners to be hidden instead of removed from DOM

  <!-- Changed components: Primer::Alpha::Banner -->

### Patch Changes

- [#2164](https://github.com/primer/view_components/pull/2164) [`93344455`](https://github.com/primer/view_components/commit/93344455a3fc7666dd459eeb06843e2a9c7a7806) Thanks [@camertron](https://github.com/camertron)! - Allow form buttons to be disabled on click with data-disable-with

  <!-- Changed components: Primer::Alpha::FormButton -->

- [#2158](https://github.com/primer/view_components/pull/2158) [`0afaecc6`](https://github.com/primer/view_components/commit/0afaecc6051ff5f85f804db3ac3494d208ed4999) Thanks [@jonrohan](https://github.com/jonrohan)! - Fix bug in ActionMenu button where return doesn't trigger menu

  <!-- Changed components: Primer::Alpha::ActionMenu -->

- [#2168](https://github.com/primer/view_components/pull/2168) [`45822328`](https://github.com/primer/view_components/commit/4582232870286d9cc2d6ae8bea6c6fd9da9659a6) Thanks [@keithamus](https://github.com/keithamus)! - Guard tooltip popover calls from `Failed to execute 'showPopover' on 'HTMLElement': Not supported on elements that do not have a valid value for the 'popover' attribute.`

  <!-- Changed components: Primer::Alpha::Tooltip -->

- [#2160](https://github.com/primer/view_components/pull/2160) [`8464823b`](https://github.com/primer/view_components/commit/8464823b7cb1d27cea9e4ead25014f1518e6bd26) Thanks [@langermank](https://github.com/langermank)! - Fix Dialog backdrop color fallback

  <!-- Changed components: _none_ -->

- [#2163](https://github.com/primer/view_components/pull/2163) [`e3aeda1f`](https://github.com/primer/view_components/commit/e3aeda1f567f3a8d08a252ab98e0aeae880d1eaf) Thanks [@langermank](https://github.com/langermank)! - Add fallbacks for primary Button

  <!-- Changed components: _none_ -->

- [#2170](https://github.com/primer/view_components/pull/2170) [`4391873d`](https://github.com/primer/view_components/commit/4391873d9970ef981e22d1b7360343037683c1d1) Thanks [@Tonkpils](https://github.com/Tonkpils)! - Add support for capitalize to text-transform

  <!-- Changed components: Primer::BaseComponent -->

- [#2169](https://github.com/primer/view_components/pull/2169) [`4f11f5e3`](https://github.com/primer/view_components/commit/4f11f5e32d0d108bce6fb688156b21704a75785f) Thanks [@camertron](https://github.com/camertron)! - Fix color contrast issues for action list hover state (danger style)

  <!-- Changed components: Primer::Alpha::ActionList, Primer::Alpha::ActionMenu -->

## 0.5.1

### Patch Changes

- [#2156](https://github.com/primer/view_components/pull/2156) [`5f809724`](https://github.com/primer/view_components/commit/5f8097241df130e5b54cd5a1bcfda0ca11258cda) Thanks [@langermank](https://github.com/langermank)! - Add correct fallbacks to `State` label

  <!-- Changed components: _none_ -->

- [#2151](https://github.com/primer/view_components/pull/2151) [`78e0d175`](https://github.com/primer/view_components/commit/78e0d175d266534ab9042b671057bed3e6dfb7c5) Thanks [@jdrush89](https://github.com/jdrush89)! - Checking document scrollbar width before making dialog backdrop visible to fix issue with document padding on mobile screens.

  <!-- Changed components: Primer::Alpha::Dialog -->

- [#2154](https://github.com/primer/view_components/pull/2154) [`9005b5cd`](https://github.com/primer/view_components/commit/9005b5cdb00a628f4f9efe93066dab5413b181e5) Thanks [@langermank](https://github.com/langermank)! - Add color declaration for Dialog `title`

  <!-- Changed components: _none_ -->

## 0.5.0

### Minor Changes

- [#2148](https://github.com/primer/view_components/pull/2148) [`cbd5c84d`](https://github.com/primer/view_components/commit/cbd5c84d8d290b0d018f15c5ee84cd94afcd4b0b) Thanks [@keithamus](https://github.com/keithamus)! - Add a linter discouraging use of <details-menu> in favor of Primer::Alpha::ActionMenu

  <!-- Changed components: _none_ -->

- [#2123](https://github.com/primer/view_components/pull/2123) [`f9119d95`](https://github.com/primer/view_components/commit/f9119d95f281d528f3c0086ebc521afd33bd4295) Thanks [@langermank](https://github.com/langermank)! - - Use Primitive v8 color tokens
  - Add tests for compiled CSS to ensure CSS color variables have a fallback

### Patch Changes

- [#2153](https://github.com/primer/view_components/pull/2153) [`b9871598`](https://github.com/primer/view_components/commit/b98715986852c5f0f51aaf9f9af0463d2eda727c) Thanks [@langermank](https://github.com/langermank)! - Update color fallback for `UnderlineNav` counter

## 0.4.0

### Minor Changes

- [#2111](https://github.com/primer/view_components/pull/2111) [`6ee6d774`](https://github.com/primer/view_components/commit/6ee6d774b463753c7b2b944dcf57dd4ff40c9589) Thanks [@keithamus](https://github.com/keithamus)! - refactor Primer::Alpha::Tooltip to use popover

  Changed components: Primer::Alpha::Tooltip

- [#2034](https://github.com/primer/view_components/pull/2034) [`707a1fa3`](https://github.com/primer/view_components/commit/707a1fa31dd23cae8316fa9d8a6c122bc4edc354) Thanks [@radglob](https://github.com/radglob)! - Partially address a11y issues in Link component.

  Links can no longer be rendered as `<span>`s.

- [#1941](https://github.com/primer/view_components/pull/1941) [`a8cc5ba2`](https://github.com/primer/view_components/commit/a8cc5ba2061207d9ca65c42f3d355eb8b7f03bb8) Thanks [@jonrohan](https://github.com/jonrohan)! - 🆕 New component!

  The `Primer::Alpha::ActionBar` component is used to create a toolbar of buttons that will fold into an ActionMenu when the space is smaller. [Design details](https://primer.style/design/components/action-bar/)

## 0.3.1

### Patch Changes

- [#2113](https://github.com/primer/view_components/pull/2113) [`f4736349`](https://github.com/primer/view_components/commit/f4736349bc7b04a8696960b821377b1237ec660c) Thanks [@camertron](https://github.com/camertron)! - Revert v8 color var fallbacks (#2083)

## 0.3.0

### Minor Changes

- [#2079](https://github.com/primer/view_components/pull/2079) [`f36ecc39`](https://github.com/primer/view_components/commit/f36ecc3969d339e43693d2fd81eee02e817e29db) Thanks [@camertron](https://github.com/camertron)! - Additional NavList accessibility improvements

* [#2086](https://github.com/primer/view_components/pull/2086) [`10abe7a0`](https://github.com/primer/view_components/commit/10abe7a0b068f2d7c6e8efe0d4f905b32e35253d) Thanks [@khiga8](https://github.com/khiga8)! - Add lint rule against .tooltipped and introduce accessibility.yml config

- [#2088](https://github.com/primer/view_components/pull/2088) [`b79fec8e`](https://github.com/primer/view_components/commit/b79fec8e134bd784658d2000a7ff4440e0cc34fb) Thanks [@jonrohan](https://github.com/jonrohan)! - Separating `<anchored-position>` web component and the .Overlay class into separate markup.

### Patch Changes

- [#2083](https://github.com/primer/view_components/pull/2083) [`e38ae1ec`](https://github.com/primer/view_components/commit/e38ae1ec7c5f0704b42f8978c03e4338dcd2c5e7) Thanks [@langermank](https://github.com/langermank)! - Update colors to use Primitive v8 CSS vars

* [#2078](https://github.com/primer/view_components/pull/2078) [`6bd439da`](https://github.com/primer/view_components/commit/6bd439da54b88a7aeb2900075405339415e9cc43) Thanks [@camertron](https://github.com/camertron)! - ToggleSwitch: Remove @debounce annotation in favor of a boolean flag to prevent confusing screen reader output

- [#2089](https://github.com/primer/view_components/pull/2089) [`4acf85d0`](https://github.com/primer/view_components/commit/4acf85d0cd8a6ce213ed8bc0313f07d947ebabbe) Thanks [@camertron](https://github.com/camertron)! - Change the 'skip changelog' label to 'skip changeset'

## 0.2.0

### Minor Changes

- [#2060](https://github.com/primer/view_components/pull/2060) [`bc40f586`](https://github.com/primer/view_components/commit/bc40f586293a26e977a9b96e538aa5fe92ac5bb1) Thanks [@camertron](https://github.com/camertron)! - ActionMenu: Move aria-checked to button

* [#2042](https://github.com/primer/view_components/pull/2042) [`9c53f8e0`](https://github.com/primer/view_components/commit/9c53f8e0c158e2f1c6618bf1a2635e4a41021fbb) Thanks [@camertron](https://github.com/camertron)! - Use polymorphic slots in ActionList and NavList

- [#2070](https://github.com/primer/view_components/pull/2070) [`04fc4f1b`](https://github.com/primer/view_components/commit/04fc4f1baec39993df468d0c9ca4a03803462186) Thanks [@camertron](https://github.com/camertron)! - Fix disabled button behavior

* [#2074](https://github.com/primer/view_components/pull/2074) [`b39eae8c`](https://github.com/primer/view_components/commit/b39eae8cd033089d3782c4552f9001a71eeceddf) Thanks [@camertron](https://github.com/camertron)! - Allow Beta::Details to be disabled

### Patch Changes

- [#2055](https://github.com/primer/view_components/pull/2055) [`5911ff9c`](https://github.com/primer/view_components/commit/5911ff9c3e22e3b52e435a0b7ed54ea97358621c) Thanks [@keithamus](https://github.com/keithamus)! - Tweak Overlay CSS to account for cases where the browser supports :open, :popover-open, both, or neither.

* [#2008](https://github.com/primer/view_components/pull/2008) [`53190440`](https://github.com/primer/view_components/commit/531904404a962620cca734f1582f0771bd47a125) Thanks [@langermank](https://github.com/langermank)! - Update color vars for `Button` with counter

- [#2021](https://github.com/primer/view_components/pull/2021) [`7abf0965`](https://github.com/primer/view_components/commit/7abf09658d28640efe278bd00a3d1d03dab3e3e5) Thanks [@keithamus](https://github.com/keithamus)! - dont open dialog if button is aria-disabled

* [#2006](https://github.com/primer/view_components/pull/2006) [`7282911b`](https://github.com/primer/view_components/commit/7282911ba38b2f11681e2a558e189cf2e6174bd4) Thanks [@keithamus](https://github.com/keithamus)! - Fix ActionMenu staying open when focus moved, in browsers with native popover

- [#2075](https://github.com/primer/view_components/pull/2075) [`2eb286f2`](https://github.com/primer/view_components/commit/2eb286f2c3f5171b52c6e64b70e1602230fc6e75) Thanks [@camertron](https://github.com/camertron)! - NavList: Add aria-current to active nav item

* [#2077](https://github.com/primer/view_components/pull/2077) [`fe578c16`](https://github.com/primer/view_components/commit/fe578c166da02173680e4825113ede4c94b9be43) Thanks [@camertron](https://github.com/camertron)! - Don't use aria-disabled for buttons

- [#2013](https://github.com/primer/view_components/pull/2013) [`b7207d27`](https://github.com/primer/view_components/commit/b7207d27b23c77ea7280cc4175c6d665897e8e40) Thanks [@langermank](https://github.com/langermank)! - Update `ButtonGroup` to use `Beta::Button`

* [#2073](https://github.com/primer/view_components/pull/2073) [`c4ada3b1`](https://github.com/primer/view_components/commit/c4ada3b1d567f6e819f8321e71d977c16f3215eb) Thanks [@camertron](https://github.com/camertron)! - Fix text_field.pcss to use flex-start instead of start

- [#2032](https://github.com/primer/view_components/pull/2032) [`607889bc`](https://github.com/primer/view_components/commit/607889bc18c4a4ec98dd966940bb361d272f5f60) Thanks [@langermank](https://github.com/langermank)! - Bug fix: Text field validation wrap styles

* [#2069](https://github.com/primer/view_components/pull/2069) [`532095e9`](https://github.com/primer/view_components/commit/532095e957b072337ed1707ebc5289990b6d8d56) Thanks [@jalafel](https://github.com/jalafel)! - Add event.stopPropogation to enter event

- [#2071](https://github.com/primer/view_components/pull/2071) [`c0fa71ec`](https://github.com/primer/view_components/commit/c0fa71ecf718a184b73bdfae5c799efb755ece3d) Thanks [@camertron](https://github.com/camertron)! - ActionMenu: don't swallow events attached via addEventListener

* [#2059](https://github.com/primer/view_components/pull/2059) [`bf60d7d7`](https://github.com/primer/view_components/commit/bf60d7d703752b9a6c096c8d1b1bd2fd0558a607) Thanks [@camertron](https://github.com/camertron)! - Fix keyboard functionality with deferred loading in ActionMenu

- [#2027](https://github.com/primer/view_components/pull/2027) [`f6d9fe97`](https://github.com/primer/view_components/commit/f6d9fe9741b66751a3c89cdfb5637a111ec4170b) Thanks [@keithamus](https://github.com/keithamus)! - ActionMenu: enable focussing first element on space activation

* [#2058](https://github.com/primer/view_components/pull/2058) [`3e50e06c`](https://github.com/primer/view_components/commit/3e50e06c308487b97aa5bf12bdc0c8eef66ba086) Thanks [@jonrohan](https://github.com/jonrohan)! - - Remove manual fallbacks for CSS vars
  - Update PostCSS plugin to add fallbacks at build time

- [#2072](https://github.com/primer/view_components/pull/2072) [`70086f5e`](https://github.com/primer/view_components/commit/70086f5e3cbdd360cf85a34de34df83d063652d3) Thanks [@jonrohan](https://github.com/jonrohan)! - ButtonGroup: Change reset selector to use .Button class

* [#2025](https://github.com/primer/view_components/pull/2025) [`2d1f5074`](https://github.com/primer/view_components/commit/2d1f50747714706f93b8bc64495a56fb72b3e24e) Thanks [@strackoverflow](https://github.com/strackoverflow)! - Preserve aria-label when `Primer::Beta::IconButton` `show_tooltip` is false

- [#2023](https://github.com/primer/view_components/pull/2023) [`b47a3781`](https://github.com/primer/view_components/commit/b47a37811147af663358cb055fe9ac79701caf43) Thanks [@camertron](https://github.com/camertron)! - Bump popover-polyfill to latest version

* [#2033](https://github.com/primer/view_components/pull/2033) [`54ed872b`](https://github.com/primer/view_components/commit/54ed872bfb08b8fb07fb9fc9c057627419c601ca) Thanks [@langermank](https://github.com/langermank)! - Add `@primer/primitives` dependency to docs

## 0.1.9

### Patch Changes

- [#1967](https://github.com/primer/view_components/pull/1967) [`20890415`](https://github.com/primer/view_components/commit/2089041551f0682b7c4cfa27a8656e148eec69ff) Thanks [@camertron](https://github.com/camertron)! - Toggle switch accessibility fixes

* [#2009](https://github.com/primer/view_components/pull/2009) [`65745bf4`](https://github.com/primer/view_components/commit/65745bf4c8044806a23e741eac0daf8e1fe65d53) Thanks [@camertron](https://github.com/camertron)! - Fix embedded example in SelectInput docs

- [#2011](https://github.com/primer/view_components/pull/2011) [`a1ca6fd0`](https://github.com/primer/view_components/commit/a1ca6fd0de5789f2b80fbc03257487dbe255b6f5) Thanks [@camertron](https://github.com/camertron)! - Make ActionList leading visual icons the same color as the item text.

* [#1998](https://github.com/primer/view_components/pull/1998) [`a23d5533`](https://github.com/primer/view_components/commit/a23d553372e08dbd57a0d4ad890b38c26d08674f) Thanks [@keithamus](https://github.com/keithamus)! - Fix style bug in popovers using native popover

- [#1996](https://github.com/primer/view_components/pull/1996) [`aeb9d2aa`](https://github.com/primer/view_components/commit/aeb9d2aa50238ade6b018b53a816d2c8b11e6457) Thanks [@keithamus](https://github.com/keithamus)! - Fix Dialogs aria-disabled attribute

* [#2003](https://github.com/primer/view_components/pull/2003) [`52ba2505`](https://github.com/primer/view_components/commit/52ba2505ca9897708357c5ed22a7bee0de4657c5) Thanks [@keithamus](https://github.com/keithamus)! - Fix positioning for native popovers

- [#1994](https://github.com/primer/view_components/pull/1994) [`064b0dea`](https://github.com/primer/view_components/commit/064b0dea7267a00ed5321ac9e1fe020f672ee085) Thanks [@keithamus](https://github.com/keithamus)! - Fix Overlay close buttons

* [#1995](https://github.com/primer/view_components/pull/1995) [`546df103`](https://github.com/primer/view_components/commit/546df103b50309ee8f9b6398707cd28eb99dcd98) Thanks [@keithamus](https://github.com/keithamus)! - Prevent page scrolling when using arrow keys in an ActionMenu

- [#1990](https://github.com/primer/view_components/pull/1990) [`15553fa9`](https://github.com/primer/view_components/commit/15553fa9d8f01a200053ddc45d1fc62e4da02738) Thanks [@jonrohan](https://github.com/jonrohan)! - Add custom properties fallback plugin to fallback primitives v8 colors

* [#1987](https://github.com/primer/view_components/pull/1987) [`01ad9325`](https://github.com/primer/view_components/commit/01ad932570295d03dd927646483c2f10b6fe6760) Thanks [@langermank](https://github.com/langermank)! - add padding back to autocomplete

- [#2002](https://github.com/primer/view_components/pull/2002) [`ef2540a1`](https://github.com/primer/view_components/commit/ef2540a1408c37e8d67fefcad62adcb1d99d938c) Thanks [@keithamus](https://github.com/keithamus)! - Fix focus groups when using native `popover`

* [#2004](https://github.com/primer/view_components/pull/2004) [`0cc69107`](https://github.com/primer/view_components/commit/0cc691072892f194f58796bef87eb832ea92a6d4) Thanks [@keithamus](https://github.com/keithamus)! - Fix bug where dialogs aren't shown due to keydown and pointer events firing

## 0.1.8

### Patch Changes

- [#1969](https://github.com/primer/view_components/pull/1969) [`37174d1b`](https://github.com/primer/view_components/commit/37174d1b97b20ffaa4b00080962a56726c6f6bed) Thanks [@jhunschejones](https://github.com/jhunschejones)! - Don't show segmented control item separator on first item

* [#1943](https://github.com/primer/view_components/pull/1943) [`40912f6a`](https://github.com/primer/view_components/commit/40912f6a173a67a4fbd8aaab54962ea25821ba51) Thanks [@camertron](https://github.com/camertron)! - Additional accessibility fixes for NavList and ActionList

- [#1965](https://github.com/primer/view_components/pull/1965) [`cd6d5ed4`](https://github.com/primer/view_components/commit/cd6d5ed48f3773e8532886422bc4b8b5e0e38321) Thanks [@langermank](https://github.com/langermank)! - Adjust background color for Button with Counter, fix small and large TextField visual alignment bugs

## 0.1.7

### Patch Changes

- [#1955](https://github.com/primer/view_components/pull/1955) [`ef9c7be2`](https://github.com/primer/view_components/commit/ef9c7be27fd718bec7006619f7a69d19a198fbe8) Thanks [@keithamus](https://github.com/keithamus)! - Add size argument to ActionMenu

* [#1962](https://github.com/primer/view_components/pull/1962) [`25a7ce9d`](https://github.com/primer/view_components/commit/25a7ce9d92c6bb3537ef68022a519794b12b98a1) Thanks [@camertron](https://github.com/camertron)! - Action menu form input

- [#1960](https://github.com/primer/view_components/pull/1960) [`55e0d2c6`](https://github.com/primer/view_components/commit/55e0d2c66ee87a0d99a12f65a6bff2074efcc1b8) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Don't use to_sentence in ERB linters so they can be run outside of Rails.

* [#1964](https://github.com/primer/view_components/pull/1964) [`d6a46055`](https://github.com/primer/view_components/commit/d6a46055cd4e9c40352f0ca61a8b0b3e2967146d) Thanks [@langermank](https://github.com/langermank)! - Upgrade Primitives and PCSS, rename tokens to pre-v8 release

## 0.1.6

### Patch Changes

- [#1946](https://github.com/primer/view_components/pull/1946) [`62e60565`](https://github.com/primer/view_components/commit/62e605658abbbd59cefef18ebd4ad4acd68c2351) Thanks [@camertron](https://github.com/camertron)! - Address NavList Axe violation

* [#1949](https://github.com/primer/view_components/pull/1949) [`f398971f`](https://github.com/primer/view_components/commit/f398971f4e2da71b37fe731e43ae47e39849e0d0) Thanks [@langermank](https://github.com/langermank)! - Use min-width for ActionMenu to fix visual regression with inline descriptions

- [#1901](https://github.com/primer/view_components/pull/1901) [`dcab49f3`](https://github.com/primer/view_components/commit/dcab49f3ce542d62d1f819d18355ae8e1ed3ce79) Thanks [@radglob](https://github.com/radglob)! - Add width parameter to autocomplete.

* [#1953](https://github.com/primer/view_components/pull/1953) [`e64edfc4`](https://github.com/primer/view_components/commit/e64edfc495591719f3e0ac9c9b2b8e2e429d2e4f) Thanks [@camertron](https://github.com/camertron)! - Fix opening a dialog from an ActionMenu item

- [#1951](https://github.com/primer/view_components/pull/1951) [`90e32894`](https://github.com/primer/view_components/commit/90e32894c758bab65e22c8b0b1bfae86d66c2967) Thanks [@camertron](https://github.com/camertron)! - Fix ActionMenu's internal label

* [#1933](https://github.com/primer/view_components/pull/1933) [`92bd7848`](https://github.com/primer/view_components/commit/92bd7848db11384ed08a0094e20c952d682ac777) Thanks [@simurai](https://github.com/simurai)! - Use inline for Buttons

## 0.1.5

### Patch Changes

- [#1830](https://github.com/primer/view_components/pull/1830) [`d7e4f5d0`](https://github.com/primer/view_components/commit/d7e4f5d0d029a838696a16b0d85f928fe8b9268a) Thanks [@langermank](https://github.com/langermank)! - ActionMenu upstream from Experimental

* [#1903](https://github.com/primer/view_components/pull/1903) [`bb627a21`](https://github.com/primer/view_components/commit/bb627a21b0df7a109cbb939dbf8c171a368670bc) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Migrate usage of old Slots API in previews.

- [#1900](https://github.com/primer/view_components/pull/1900) [`9cd530ee`](https://github.com/primer/view_components/commit/9cd530eece6284848c4d7f9b0c8f1cd4e71537b0) Thanks [@keithamus](https://github.com/keithamus)! - Add the ability to pass an icon to Dialog `with_show_button`, which will turn it from a Beta::Button to a Beta::IconButton.

* [#1932](https://github.com/primer/view_components/pull/1932) [`5602fbbb`](https://github.com/primer/view_components/commit/5602fbbbc5783ba88f075d972c00082109da7e84) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Fix use of removed slots API in docs.

- [#1907](https://github.com/primer/view_components/pull/1907) [`c691fbeb`](https://github.com/primer/view_components/commit/c691fbeb6e65f1a4fc420933123a44664a6a4f5d) Thanks [@neall](https://github.com/neall)! - Fix up reserved CSS class linter

## 0.1.4

### Patch Changes

- [#1829](https://github.com/primer/view_components/pull/1829) [`bb54d982`](https://github.com/primer/view_components/commit/bb54d982433910ae28005b72de73ca69a6f8a8f3) Thanks [@josepmartins](https://github.com/josepmartins)! - Add responsive values for `border` and `border-radius` system argument

* [#1897](https://github.com/primer/view_components/pull/1897) [`eae7a7f8`](https://github.com/primer/view_components/commit/eae7a7f8a4891efa4873558d380eabb638272095) Thanks [@camertron](https://github.com/camertron)! - Fix widths of text fields and multi inputs.

## 0.1.3

### Patch Changes

- [#1895](https://github.com/primer/view_components/pull/1895) [`e53f1995`](https://github.com/primer/view_components/commit/e53f1995e6b97a92169479255196c1eec07cbd1f) Thanks [@camertron](https://github.com/camertron)! - Modify merge_aria to combine plural attributes; introduce merge_data

* [#1894](https://github.com/primer/view_components/pull/1894) [`5d118b0a`](https://github.com/primer/view_components/commit/5d118b0ae8b10429801f12f8c08e9aaf4895dbab) Thanks [@mikekavouras](https://github.com/mikekavouras)! - Update Primer::Alpha::TextInput to support multiple target attributes

- [#1887](https://github.com/primer/view_components/pull/1887) [`9cc2f5bf`](https://github.com/primer/view_components/commit/9cc2f5bf3a59e7c97ca44b4b17da7c849bda5e2a) Thanks [@camertron](https://github.com/camertron)! - ActionList item and divider content

* [#1892](https://github.com/primer/view_components/pull/1892) [`d72334d1`](https://github.com/primer/view_components/commit/d72334d1ef2a40e3ed1e96bfebc1b896752c521c) Thanks [@hrs](https://github.com/hrs)! - Deprecate Primer::LayoutComponent in favor of Primer::Alpha::Layout, and add a migration guide

- [#1891](https://github.com/primer/view_components/pull/1891) [`5f48d6f8`](https://github.com/primer/view_components/commit/5f48d6f83d0aa5b82ca3a764161cfafae9de8fe5) Thanks [@camertron](https://github.com/camertron)! - Associate title with dialog

* [#1889](https://github.com/primer/view_components/pull/1889) [`dd1d382d`](https://github.com/primer/view_components/commit/dd1d382d52abaff1edadb64cd4eef89515c17184) Thanks [@langermank](https://github.com/langermank)! - Bug fix: ActionList `danger` variant hover/active contrast

## 0.1.2

### Patch Changes

- [#1880](https://github.com/primer/view_components/pull/1880) [`7a160a4c`](https://github.com/primer/view_components/commit/7a160a4c6db18687fdc5ebebbe5dc9ab0926443a) Thanks [@camertron](https://github.com/camertron)! - Allow consumers to set ActionList item content's tag

* [#1869](https://github.com/primer/view_components/pull/1869) [`53b99f6a`](https://github.com/primer/view_components/commit/53b99f6ae1c7fdfb4b929d6f60215aacedbcdfc7) Thanks [@keithamus](https://github.com/keithamus)! - Make Overlay headings optional

- [#1873](https://github.com/primer/view_components/pull/1873) [`125861b8`](https://github.com/primer/view_components/commit/125861b8cbff95db90126f8c0aa297b9a0bb4ade) Thanks [@camertron](https://github.com/camertron)! - Remove ability to show trailing action buttons in ActionList and NavList on hover

* [#1875](https://github.com/primer/view_components/pull/1875) [`8bbeb72a`](https://github.com/primer/view_components/commit/8bbeb72a5ef60917265b93791cd20ab99045540e) Thanks [@camertron](https://github.com/camertron)! - Allow ActionList dividers to be added manually

- [#1871](https://github.com/primer/view_components/pull/1871) [`6b1170ae`](https://github.com/primer/view_components/commit/6b1170aef5b5f703e239881bdd0717c6e4c1a973) Thanks [@camertron](https://github.com/camertron)! - Deny tag argument for ActionList headings

* [#1876](https://github.com/primer/view_components/pull/1876) [`b3b94e98`](https://github.com/primer/view_components/commit/b3b94e989f51fcc776cf312208bd4dcadde31161) Thanks [@antn](https://github.com/antn)! - Upgrade octicons to >= 18.0.0

- [#1877](https://github.com/primer/view_components/pull/1877) [`864fb98f`](https://github.com/primer/view_components/commit/864fb98fd38af79490b326caf3a0fe325ffb3066) Thanks [@hrs](https://github.com/hrs)! - Deprecate Primer::Truncate in favor of Primer::Beta::Truncate, and adding a migration guide

* [#1878](https://github.com/primer/view_components/pull/1878) [`9c211ce2`](https://github.com/primer/view_components/commit/9c211ce222e774acef11d1d438adfdc6251ce5ac) Thanks [@camertron](https://github.com/camertron)! - Attach behavior to TextField's clear button

## 0.1.1

### Patch Changes

- [#1864](https://github.com/primer/view_components/pull/1864) [`1476b869`](https://github.com/primer/view_components/commit/1476b869db27a6ed50b7e8d83db6ef475efb31de) Thanks [@simurai](https://github.com/simurai)! - Fix underline of UnderlineNav being cut off when followed by a flash banner

* [#1865](https://github.com/primer/view_components/pull/1865) [`df8dcced`](https://github.com/primer/view_components/commit/df8dcceda484c2582f9085e11e5678c1f0bd446d) Thanks [@keithamus](https://github.com/keithamus)! - Add aria attributes to Overlay show_button

- [#1865](https://github.com/primer/view_components/pull/1865) [`df8dcced`](https://github.com/primer/view_components/commit/df8dcceda484c2582f9085e11e5678c1f0bd446d) Thanks [@keithamus](https://github.com/keithamus)! - Allow for IconButtons in overlay show_button

* [#1867](https://github.com/primer/view_components/pull/1867) [`c6bfce04`](https://github.com/primer/view_components/commit/c6bfce043a9cf197a7b212e96bc0178bc5310246) Thanks [@jonrohan](https://github.com/jonrohan)! - Fixing TabNav double render of extra content

- [#1828](https://github.com/primer/view_components/pull/1828) [`4e6201d4`](https://github.com/primer/view_components/commit/4e6201d4307f923f24a2fd04b6bb30ddb1cf5337) Thanks [@camertron](https://github.com/camertron)! - Address accessibility issues in NavList and ActionList

* [#1730](https://github.com/primer/view_components/pull/1730) [`8c77e133`](https://github.com/primer/view_components/commit/8c77e133ba2507e6dd70d0666ea78b50a57d4144) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move Primer::Navigation::TabComponent to Primer::Alpha::Navigation::Tab

- [#1850](https://github.com/primer/view_components/pull/1850) [`a909eae0`](https://github.com/primer/view_components/commit/a909eae016c1716387799c76a00019b5a03cc25c) Thanks [@mayamessinger](https://github.com/mayamessinger)! - Fix beta button tooltip compatibility with display :block

* [#1847](https://github.com/primer/view_components/pull/1847) [`16b16264`](https://github.com/primer/view_components/commit/16b162646fb51422d6604addbd27cb6bf0978106) Thanks [@keithamus](https://github.com/keithamus)! - Remove animation from Overlay component

## 0.1.0

### Minor Changes

- [#1401](https://github.com/primer/view_components/pull/1401) [`f824d1d0`](https://github.com/primer/view_components/commit/f824d1d0e8337ef34eef6af2419bd9ecc8537fe3) Thanks [@keithamus](https://github.com/keithamus)! - Add Overlay component

### Patch Changes

- [#1844](https://github.com/primer/view_components/pull/1844) [`15869d48`](https://github.com/primer/view_components/commit/15869d48ad3b22151ef97290fb0f1c8cf8dc6c6f) Thanks [@camertron](https://github.com/camertron)! - Remove extra space between flash icon and message

* [#1840](https://github.com/primer/view_components/pull/1840) [`04b75c70`](https://github.com/primer/view_components/commit/04b75c70e4b42a82e4a4ce31a976bfd1e5c6e9fa) Thanks [@camertron](https://github.com/camertron)! - Fix issue causing NavList parents to appear selected

- [#1845](https://github.com/primer/view_components/pull/1845) [`98792bdd`](https://github.com/primer/view_components/commit/98792bdd47c8f0ac50ef839ab5e5948984d66c3b) Thanks [@camertron](https://github.com/camertron)! - Use system arguments instead of utility classes for NavList's "show more" item

* [#1823](https://github.com/primer/view_components/pull/1823) [`5eadffd3`](https://github.com/primer/view_components/commit/5eadffd354891a3befb3b9152a16ba0a7c375aec) Thanks [@neall](https://github.com/neall)! - Add general reserved-class-checking linter

## 0.0.123

### Patch Changes

- [#1835](https://github.com/primer/view_components/pull/1835) [`498191b4`](https://github.com/primer/view_components/commit/498191b437a30abd15d3ca3996d26bfcfe73a717) Thanks [@camertron](https://github.com/camertron)! - Fix conditional inclusion of polymorphic slots module

* [#1822](https://github.com/primer/view_components/pull/1822) [`ad56ddef`](https://github.com/primer/view_components/commit/ad56ddef07b2a4e45ca17f0838e5c211840f5873) Thanks [@camertron](https://github.com/camertron)! - Allow NavList selection/deselection by id/href in javascript

## 0.0.122

### Patch Changes

- [#1818](https://github.com/primer/view_components/pull/1818) [`c8fa002f`](https://github.com/primer/view_components/commit/c8fa002f807c508c86cd387512e3e81ef01b1db3) Thanks [@camertron](https://github.com/camertron)! - Fix issue in TabPanels causing extra content to render twice

* [#1824](https://github.com/primer/view_components/pull/1824) [`2a234537`](https://github.com/primer/view_components/commit/2a2345372113dc23df1507fdcd6c588351cc3fd7) Thanks [@langermank](https://github.com/langermank)! - ToggleSwitch and SegmentedControl visual updates + Primitives (PCSS) version bump

- [#1595](https://github.com/primer/view_components/pull/1595) [`f31bf3f9`](https://github.com/primer/view_components/commit/f31bf3f95a03efb4931a421b7d49df7aa22b6ea7) Thanks [@soberstadt](https://github.com/soberstadt)! - Change engine to mount on ActionController::Base

* [#1832](https://github.com/primer/view_components/pull/1832) [`557ec8ba`](https://github.com/primer/view_components/commit/557ec8bad66e32a6a5183a9b6496d5910658de41) Thanks [@joelhawksley](https://github.com/joelhawksley)! - support ViewComponent v3.0.0.rc2

- [#1821](https://github.com/primer/view_components/pull/1821) [`c12ae8c5`](https://github.com/primer/view_components/commit/c12ae8c5dbe9fd0b8c723cac297139976fa28552) Thanks [@camertron](https://github.com/camertron)! - Add a standalone FormControl component

* [#1814](https://github.com/primer/view_components/pull/1814) [`8090cda2`](https://github.com/primer/view_components/commit/8090cda2a389a99e100ecea979d40602a3d52ae6) Thanks [@camertron](https://github.com/camertron)! - Expose additional form components

- [#1827](https://github.com/primer/view_components/pull/1827) [`c0545a65`](https://github.com/primer/view_components/commit/c0545a659855c3c6ec20f5e9faf680b2e7a9cc52) Thanks [@joelhawksley](https://github.com/joelhawksley)! - use lookbook 1.5.2

* [#1833](https://github.com/primer/view_components/pull/1833) [`a90e1554`](https://github.com/primer/view_components/commit/a90e155475819bb5f82b0947916b46ada4ea1633) Thanks [@camertron](https://github.com/camertron)! - Fix regression causing check boxes to always render enabled

## 0.0.121

### Patch Changes

- [#1791](https://github.com/primer/view_components/pull/1791) [`b68cf7f7`](https://github.com/primer/view_components/commit/b68cf7f7d74379765cd373a5ea060204e3cf7db2) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::LocalTime component

* [#1808](https://github.com/primer/view_components/pull/1808) [`31544417`](https://github.com/primer/view_components/commit/31544417010274b4f8b3b6574587b917a0bbf0e4) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Rename URLHelpers to UrlHelpers to fix console error.

- [#1788](https://github.com/primer/view_components/pull/1788) [`7ad70066`](https://github.com/primer/view_components/commit/7ad7006651dc4dbbd21f444ad10ee1fdb5c3eeba) Thanks [@camertron](https://github.com/camertron)! - Document TextField's auto_check_src argument

* [#1784](https://github.com/primer/view_components/pull/1784) [`3b830167`](https://github.com/primer/view_components/commit/3b8301674ccd74e7ae31826a766883a0612a3960) Thanks [@jonrohan](https://github.com/jonrohan)! - Remove unused deprecated component wrappers

       - "Primer::Dropdown::Menu::Item"
       - "Primer::Dropdown::Menu"
       - "Primer::Dropdown"
       - "Primer::HellipButton"
       - "Primer::LabelComponent"
       - "Primer::LinkComponent"
       - "Primer::Markdown"
       - "Primer::MenuComponent"
       - "Primer::OcticonComponent"
       - "Primer::OcticonSymbolsComponent"
       - "Primer::PopoverComponent"
       - "Primer::SpinnerComponent"
       - "Primer::StateComponent"
       - "Primer::SubheadComponent"
       - "Primer::TabContainerComponent"
       - "Primer::TimelineItemComponent::BadgeComponent"
       - "Primer::TimelineItemComponent"

- [#1787](https://github.com/primer/view_components/pull/1787) [`972dd7bd`](https://github.com/primer/view_components/commit/972dd7bd92e79b2e8b54555f91770c4c1b280709) Thanks [@neall](https://github.com/neall)! - Allow toggle-switch forms to use caption templates.

* [#1792](https://github.com/primer/view_components/pull/1792) [`730b0a8d`](https://github.com/primer/view_components/commit/730b0a8d70a9e5bc42856c3f30779ebf0d2b9ac9) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::TimeAgoComponent

- [#1776](https://github.com/primer/view_components/pull/1776) [`61b28872`](https://github.com/primer/view_components/commit/61b288721a0315bcad4694615c9b34ddad5d10b7) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding aria labeled by and described by check to SegmentedControl component. Marking as accessibility reviewed

* [#1805](https://github.com/primer/view_components/pull/1805) [`238328a7`](https://github.com/primer/view_components/commit/238328a734cff1322d18c129d340bb5a254bc272) Thanks [@paulcsmith](https://github.com/paulcsmith)! - Update CloseButton to work with more aria-label types

## 0.0.120

### Patch Changes

- [#1772](https://github.com/primer/view_components/pull/1772) [`9dfec861`](https://github.com/primer/view_components/commit/9dfec861e67aa90a392a0047ae7a06bdbcd1d437) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated Primer::ClipboardCopy component and clipboard_copy.rb file

* [#1771](https://github.com/primer/view_components/pull/1771) [`0541d18c`](https://github.com/primer/view_components/commit/0541d18c9d76155f5aea3e72420884b97c0ac3b9) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated box_component.rb file `Primer::BoxComponent`

- [#1782](https://github.com/primer/view_components/pull/1782) [`809d8d32`](https://github.com/primer/view_components/commit/809d8d3226ba62ce1040e5d9d5feacdbff1654f9) Thanks [@jdennes](https://github.com/jdennes)! - Prefer Primer::Beta::Button in ERBLint::Linters::ButtonComponentMigrationCounter

* [#1783](https://github.com/primer/view_components/pull/1783) [`7337d5ef`](https://github.com/primer/view_components/commit/7337d5ef691c07288d42ba14bf2ac30a2eb11737) Thanks [@langermank](https://github.com/langermank)! - Remove the deprecated `Primer::DropdownMenuComponent`.

- [#1768](https://github.com/primer/view_components/pull/1768) [`fe8e7071`](https://github.com/primer/view_components/commit/fe8e7071d90aa6bc8fe838fb75af384466f31bfa) Thanks [@jdennes](https://github.com/jdennes)! - Add RuboCop::Cop::Primer::TestSelector to encourage use of the test_selector argument

* [#1780](https://github.com/primer/view_components/pull/1780) [`49d27b22`](https://github.com/primer/view_components/commit/49d27b22724deeb68b8e017306c97808813e3ee3) Thanks [@langermank](https://github.com/langermank)! - Bug fix: Adjust the body tag padding-right when an overlay is open to avoid page shift

- [#1767](https://github.com/primer/view_components/pull/1767) [`cf28f5e4`](https://github.com/primer/view_components/commit/cf28f5e4179b73fe9307a944fdba52fc8e86449e) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Use ViewComponent 3.0.0.rc1

* [#1770](https://github.com/primer/view_components/pull/1770) [`b8b0308d`](https://github.com/primer/view_components/commit/b8b0308d9c12c98cc491cc2b9db905a3f0bb1073) Thanks [@tomthorogood](https://github.com/tomthorogood)! - Fix incorrect typography descriptions

- [#1781](https://github.com/primer/view_components/pull/1781) [`716abfb1`](https://github.com/primer/view_components/commit/716abfb1ddb026790c8d26f6d88f5de472946d3e) Thanks [@jdennes](https://github.com/jdennes)! - Correct contributing guidelines

## 0.0.119

### Patch Changes

- [#1763](https://github.com/primer/view_components/pull/1763) [`a2c5b4c9`](https://github.com/primer/view_components/commit/a2c5b4c9f73554a401a58902da1b4d247a6408b8) Thanks [@neall](https://github.com/neall)! - Standardize how we generate ids for HTML

* [#1588](https://github.com/primer/view_components/pull/1588) [`e389a554`](https://github.com/primer/view_components/commit/e389a554a05ec3dd12dbf139b2158caa81ee904b) Thanks [@koddsson](https://github.com/koddsson)! - Update `axe-core` scanning in system tests

- [#1760](https://github.com/primer/view_components/pull/1760) [`fdd7bc1e`](https://github.com/primer/view_components/commit/fdd7bc1ea3309a649586a04b3a10eeef5e1d0650) Thanks [@camertron](https://github.com/camertron)! - Show error messages when toggle switches fail

## 0.0.118

### Patch Changes

- [#1757](https://github.com/primer/view_components/pull/1757) [`9bc35cce`](https://github.com/primer/view_components/commit/9bc35cceff429a7fa347d3957afe7ea27eed2b19) Thanks [@camertron](https://github.com/camertron)! - Bump view_component to v2.81.0 to fix issue with Rails main

* [#1753](https://github.com/primer/view_components/pull/1753) [`95df035a`](https://github.com/primer/view_components/commit/95df035a61edbf2bf43a55570b63a8646a216b02) Thanks [@keithamus](https://github.com/keithamus)! - Update `with_show_button` slot to use `Primer::Beta::Button` instead of `Primer::ButtonComponent`.

- [#1736](https://github.com/primer/view_components/pull/1736) [`927a52c3`](https://github.com/primer/view_components/commit/927a52c3e83f4eb48e8c37fdbf6c377957eedc03) Thanks [@dependabot](https://github.com/apps/dependabot)! - Add format_style to RelativeTime component

* [#1728](https://github.com/primer/view_components/pull/1728) [`1c9981f4`](https://github.com/primer/view_components/commit/1c9981f48ae9113049ec55306b6fd3fd287d1cbc) Thanks [@langermank](https://github.com/langermank)! - Use a button tag for ActionList::Items

- [#1750](https://github.com/primer/view_components/pull/1750) [`64343de4`](https://github.com/primer/view_components/commit/64343de4323fc56ff5270d3809be3142795077cf) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding `:auto` to size option to Dialog component

* [#1756](https://github.com/primer/view_components/pull/1756) [`280972cb`](https://github.com/primer/view_components/commit/280972cbc38250971b071914cfaeb22e473b7c6a) Thanks [@langermank](https://github.com/langermank)! - Fix media query typo in Button

- [#1754](https://github.com/primer/view_components/pull/1754) [`d662c1c7`](https://github.com/primer/view_components/commit/d662c1c77f70cd27c5b894af0231a9de43938f2f) Thanks [@keithamus](https://github.com/keithamus)! - Fix bug where clicking inside dialog, but finishing click outside, dismisses dialog

## 0.0.117

### Patch Changes

- [#1719](https://github.com/primer/view_components/pull/1719) [`8e4b37bc`](https://github.com/primer/view_components/commit/8e4b37bc269a1a285ce1bce695691f82827c9bc2) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Fix previews that used old slots API

* [#1721](https://github.com/primer/view_components/pull/1721) [`3cea518c`](https://github.com/primer/view_components/commit/3cea518c521631ac5e40e857c0eb87d863409a0d) Thanks [@joelhawksley](https://github.com/joelhawksley)! - fix more previews to use new Slots API

- [#1722](https://github.com/primer/view_components/pull/1722) [`0186096b`](https://github.com/primer/view_components/commit/0186096be9ae6990ed90b1ff04a26d73dabc78a4) Thanks [@simurai](https://github.com/simurai)! - Disable `is()` selector

* [#1724](https://github.com/primer/view_components/pull/1724) [`3533d8fb`](https://github.com/primer/view_components/commit/3533d8fbc77189656c9c2c85e343c548bc2596cf) Thanks [@simurai](https://github.com/simurai)! - Remove PCSS imports for Docs

- [#1718](https://github.com/primer/view_components/pull/1718) [`f96b7edd`](https://github.com/primer/view_components/commit/f96b7edd1af06170c4dea3a418630a8bd12bc092) Thanks [@joelhawksley](https://github.com/joelhawksley)! - fix missed Slots API changes

* [#1716](https://github.com/primer/view_components/pull/1716) [`9a4ad693`](https://github.com/primer/view_components/commit/9a4ad6935ea9d6852ee08c3ff4d7d45e0f07cc78) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::StateComponent` to `Primer::Beta::State` and deprecate the original

- [#1720](https://github.com/primer/view_components/pull/1720) [`365048a3`](https://github.com/primer/view_components/commit/365048a39af18484ac0eb9ca6985858fb2285b88) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::SubheadComponent` to `Primer::Beta::Subhead` and deprecate the original

* [#1729](https://github.com/primer/view_components/pull/1729) [`897b3524`](https://github.com/primer/view_components/commit/897b35246c7d8c9a813984eaa101fa0e9368ad63) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Correctly deprecate `Primer::TimelineItemComponent::BadgeComponent` in favor of `Primer::Beta::TimelineItem::Badge`

- [#1715](https://github.com/primer/view_components/pull/1715) [`34dfc3ab`](https://github.com/primer/view_components/commit/34dfc3abdc66ad15db3449ec1acae4b41be63e28) Thanks [@neall](https://github.com/neall)! - Add Primer::Forms::ToggleSwitchForm

* [#1713](https://github.com/primer/view_components/pull/1713) [`9b535d89`](https://github.com/primer/view_components/commit/9b535d89962a2cac4fc50d3a43119db3ccad8041) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Use new Slots API in previews.

- [#1725](https://github.com/primer/view_components/pull/1725) [`f84c7dda`](https://github.com/primer/view_components/commit/f84c7dda2239f4e01b1785db83fe70007df47f89) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::TabContainerComponent` to `Primer::Alpha::TabContainer`

* [#1717](https://github.com/primer/view_components/pull/1717) [`da56d348`](https://github.com/primer/view_components/commit/da56d34842afc7cbe3abe54de7545faa993abcae) Thanks [@KyFaSt](https://github.com/KyFaSt)! - Make tool_tip Trusted Types compatible

- [#1699](https://github.com/primer/view_components/pull/1699) [`14498234`](https://github.com/primer/view_components/commit/14498234a2953427a7fffd54c2aff82df594c9a1) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Update component deprecation in CI to report as info instead of errors. Update the deprecation messages to always provide a replacement when possible.

* [#1726](https://github.com/primer/view_components/pull/1726) [`0b21fb75`](https://github.com/primer/view_components/commit/0b21fb757cabb2f9ddc40cad57b58db6216a2002) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::HellipButton` to `Primer::Alpha::HellipButton`

- [#1727](https://github.com/primer/view_components/pull/1727) [`97a781a9`](https://github.com/primer/view_components/commit/97a781a9da38aa6c0f5cd8a98a889130d488693a) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move Primer::TimelineItemComponent to Primer::Beta::TimelineItem

## 0.0.116

### Patch Changes

- [#1710](https://github.com/primer/view_components/pull/1710) [`8e3390cd`](https://github.com/primer/view_components/commit/8e3390cd67088e3cc4add0b98331239fc860cd3a) Thanks [@joelhawksley](https://github.com/joelhawksley)! - All components use new `with_*` Slots API.

* [#1712](https://github.com/primer/view_components/pull/1712) [`1568f7f9`](https://github.com/primer/view_components/commit/1568f7f99735baab0ab59d79a10675dda7c1ba1a) Thanks [@simurai](https://github.com/simurai)! - Improve `Counter` colors when nested in `Button`

- [#1711](https://github.com/primer/view_components/pull/1711) [`b39dd62c`](https://github.com/primer/view_components/commit/b39dd62c37d8311e2374e39e056fb94c3cb1c4a5) Thanks [@camertron](https://github.com/camertron)! - Add option for controlling when form fields should be nested under their parent

* [#1704](https://github.com/primer/view_components/pull/1704) [`f54ee3f7`](https://github.com/primer/view_components/commit/f54ee3f7a5cf13efafee6e0b6980f8607ced38dd) Thanks [@camertron](https://github.com/camertron)! - Add option to skip adding model scope to form inputs

- [#1586](https://github.com/primer/view_components/pull/1586) [`bf704000`](https://github.com/primer/view_components/commit/bf70400033f6d0aa4c57020f37ba8ccd51e9ef7a) Thanks [@jonrohan](https://github.com/jonrohan)! - Updating touch targets on SegmentedControl

* [#1703](https://github.com/primer/view_components/pull/1703) [`8103ec36`](https://github.com/primer/view_components/commit/8103ec36c27bf31fdb073010a02556f9e57d7838) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Beta components use new `with_*` Slots API.

## 0.0.115

### Patch Changes

- [#1670](https://github.com/primer/view_components/pull/1670) [`217db072`](https://github.com/primer/view_components/commit/217db07287d7383155051eba8c496d9a9636c54c) Thanks [@simurai](https://github.com/simurai)! - Move `Layout` styles to PVC

* [#1667](https://github.com/primer/view_components/pull/1667) [`ee7f476d`](https://github.com/primer/view_components/commit/ee7f476dd13b58e1c38538950780493b97142c8b) Thanks [@camertron](https://github.com/camertron)! - Make multi input a form control

- [#1672](https://github.com/primer/view_components/pull/1672) [`1a7daddb`](https://github.com/primer/view_components/commit/1a7daddb62cfb01825f09a9edb5310c0d9e44e07) Thanks [@neall](https://github.com/neall)! - Add auto_check_src option to forms framework text fields to run server-side validation on field change

* [#1698](https://github.com/primer/view_components/pull/1698) [`29a5415e`](https://github.com/primer/view_components/commit/29a5415ecb6810d79abd135a32e9d63076c7a8c1) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::SpinnerComponent` to `Primer::Beta::Spinner`

- [#1697](https://github.com/primer/view_components/pull/1697) [`4ff75a58`](https://github.com/primer/view_components/commit/4ff75a58b5daa94c9e24fc0cf2723a5a6750f4fe) Thanks [@joelhawksley](https://github.com/joelhawksley)! - ActionList, Alpha::AutoComplete, Banner, and Alpha::Dialog use new "with\_\*" Slots API.

* [#1696](https://github.com/primer/view_components/pull/1696) [`d709bae1`](https://github.com/primer/view_components/commit/d709bae13ad0ff907b20b0471cbcb847daf3724a) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Moving `Primer::OcticonSymbolsComponent` to `Primer::Alpha::OcticonSymbols`, and deprecating the original

- [#1694](https://github.com/primer/view_components/pull/1694) [`b1fc5dfd`](https://github.com/primer/view_components/commit/b1fc5dfd591c4ebcb16469003c5aff4eb115b485) Thanks [@camertron](https://github.com/camertron)! - Fix sass variable in layout.pcss

* [#1687](https://github.com/primer/view_components/pull/1687) [`a5b6f02e`](https://github.com/primer/view_components/commit/a5b6f02e32e6fa05005a57cc82a0682b5bcd2351) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Deprecate Primer::LocalTime in favor of Primer::RelativeTime

- [#1692](https://github.com/primer/view_components/pull/1692) [`f50c77fe`](https://github.com/primer/view_components/commit/f50c77fe215240a70d9355180fdddf17a2daae24) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Deprecating Primer::TimeAgo in favor of Primer::RelativeTime, and adding a migration guide

* [#1690](https://github.com/primer/view_components/pull/1690) [`c1845c65`](https://github.com/primer/view_components/commit/c1845c65c3d7aaae3abb31f9846279783734974e) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Move `Primer::Beta::Octicon` to `Primer::Beta::Octicon` and deprecate the original

- [#1688](https://github.com/primer/view_components/pull/1688) [`988077aa`](https://github.com/primer/view_components/commit/988077aae27c11fc270e1e9302498b2d2cd1113c) Thanks [@manuelpuyol](https://github.com/manuelpuyol)! - Fix tooltips not adding aria attributes when Turbo navigating

* [#1691](https://github.com/primer/view_components/pull/1691) [`ab416be9`](https://github.com/primer/view_components/commit/ab416be957c4c48f0073c2d8a1c1218ea7f9c3d5) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Start migration to new slots API. You may see warnings for using the non-`with_` slot setter API.

- [#1682](https://github.com/primer/view_components/pull/1682) [`e5144a38`](https://github.com/primer/view_components/commit/e5144a3867ee10a37c8662a27d2cb85711aae8ad) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Moving `Primer::MenuComponent` to `Primer::Alpha::Menu` and deprecating the original

* [#1693](https://github.com/primer/view_components/pull/1693) [`219f5ef4`](https://github.com/primer/view_components/commit/219f5ef4844523f388843b612f23909484cb881a) Thanks [@camertron](https://github.com/camertron)! - Use URL helpers in previews that interact with the server-side

- [#1701](https://github.com/primer/view_components/pull/1701) [`2c73c2f7`](https://github.com/primer/view_components/commit/2c73c2f7fbfa142da67e5c1044bc1c2cdfa50891) Thanks [@camertron](https://github.com/camertron)! - Properly scope Lookbook routes

* [#1695](https://github.com/primer/view_components/pull/1695) [`7a881bf5`](https://github.com/primer/view_components/commit/7a881bf5a50720bc630c66a903256445aeb14a3e) Thanks [@simurai](https://github.com/simurai)! - Remove `forms.css` import for Lookbook

## 0.0.114

### Patch Changes

- [#1685](https://github.com/primer/view_components/pull/1685) [`5f062fed`](https://github.com/primer/view_components/commit/5f062fed16980bd1ec437636eef1851dfea56388) Thanks [@simurai](https://github.com/simurai)! - Revert moving `button` styles to PVC

* [#1681](https://github.com/primer/view_components/pull/1681) [`0c9611f5`](https://github.com/primer/view_components/commit/0c9611f5a08c78452be999c08d9f24703b5bd671) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Moving Primer::Markdown to Primer::Beta::Markdown, and deprecating the original

## 0.0.113

### Patch Changes

- [#1650](https://github.com/primer/view_components/pull/1650) [`2941ba2b`](https://github.com/primer/view_components/commit/2941ba2b9f98cb62f315e6b6ff90913e854da67d) Thanks [@keithamus](https://github.com/keithamus)! - Add RelativeTime component

* [#1665](https://github.com/primer/view_components/pull/1665) [`f9759ff0`](https://github.com/primer/view_components/commit/f9759ff0e4c2d33990a4b1cc22f5341239324b3d) Thanks [@camertron](https://github.com/camertron)! - Add a button input to the forms framework

- [#1636](https://github.com/primer/view_components/pull/1636) [`0af266a7`](https://github.com/primer/view_components/commit/0af266a7d6a75e351b35b620043f545dcaa8d03f) Thanks [@simurai](https://github.com/simurai)! - Remove `ActionListItem` animation

* [#1638](https://github.com/primer/view_components/pull/1638) [`5c421277`](https://github.com/primer/view_components/commit/5c4212777189c62c420f4e756cccef7c48a356fd) Thanks [@simurai](https://github.com/simurai)! - Move `FormControl` styles to PVC

- [#1664](https://github.com/primer/view_components/pull/1664) [`d56dfa60`](https://github.com/primer/view_components/commit/d56dfa606019b4951783ac2d581b74b5234a8d6c) Thanks [@camertron](https://github.com/camertron)! - Allow form inputs to be hidden

* [#1630](https://github.com/primer/view_components/pull/1630) [`e744c14f`](https://github.com/primer/view_components/commit/e744c14f72de7052fa52e14776675924e04ff269) Thanks [@simurai](https://github.com/simurai)! - Move `button` styles to PVC

- [#1666](https://github.com/primer/view_components/pull/1666) [`5a7c5320`](https://github.com/primer/view_components/commit/5a7c532075a5208e5aad9d801d79b2ce7e9a1c19) Thanks [@camertron](https://github.com/camertron)! - Add the primer_fields_for helper

* [#1671](https://github.com/primer/view_components/pull/1671) [`e0be2776`](https://github.com/primer/view_components/commit/e0be2776d46c390cbfc0a3fcfa278b3b5874f428) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Add a migration guide for moving from Primer::DropdownMenuComponent to Primer::Beta::Dropdown

- [#1635](https://github.com/primer/view_components/pull/1635) [`653ac92b`](https://github.com/primer/view_components/commit/653ac92b2db6853715221a579913839631db4fd6) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Converting deprecations list to a .yml file, and updating all code around deprecations to use this new structure

* [#1668](https://github.com/primer/view_components/pull/1668) [`84cd95ed`](https://github.com/primer/view_components/commit/84cd95ed641444a8acd602acd00389ce65173460) Thanks [@camertron](https://github.com/camertron)! - Allow form components and entire forms to skip rendering

- [#1643](https://github.com/primer/view_components/pull/1643) [`7e20e148`](https://github.com/primer/view_components/commit/7e20e1483caf000800c67e0a465b8f45587655cf) Thanks [@camertron](https://github.com/camertron)! - Fix disabled ToggleSwitch behavior

* [#1673](https://github.com/primer/view_components/pull/1673) [`7a26cbb6`](https://github.com/primer/view_components/commit/7a26cbb69b090d017f753d9f6a190ed197ad5563) Thanks [@camertron](https://github.com/camertron)! - Ensure nested forms can be hidden independently of their radio button or check box

- [#1651](https://github.com/primer/view_components/pull/1651) [`7e430ac1`](https://github.com/primer/view_components/commit/7e430ac18af9ec49396f89383cebfa976e69e059) Thanks [@simurai](https://github.com/simurai)! - Move `Overlay` styles to PVC

* [#1674](https://github.com/primer/view_components/pull/1674) [`a6c5bb52`](https://github.com/primer/view_components/commit/a6c5bb52bd3c941133bfedf05c0e107e6d7f1fbd) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Moving `Primer::ClipboardCopy` to `Primer::Beta::ClipboardCopy`, and deprecating the original

- [#1663](https://github.com/primer/view_components/pull/1663) [`15392142`](https://github.com/primer/view_components/commit/1539214202031b7646f2a709bf333283603a76e3) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Adding a migration guide and updating deprecation settings for Primer::ButtonComponent -> Primer::Beta::Button

* [#1662](https://github.com/primer/view_components/pull/1662) [`d2b33606`](https://github.com/primer/view_components/commit/d2b336065aacbe3dab3d67d9a53f3122a0dc31db) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding `Primer::ViewComponents::AUDITED` variable to access when a component was last audited. Get's data from the `static/audited_at.json` file.

- [#1639](https://github.com/primer/view_components/pull/1639) [`ddc30dd5`](https://github.com/primer/view_components/commit/ddc30dd5fa485966ead559d6de204df86c6aeddb) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Adding "guide" to PVC deprecation configuration, and providing a much more detailed deprecation notice based on configuration for each component

## 0.0.112

### Patch Changes

- [#1624](https://github.com/primer/view_components/pull/1624) [`61c8a7d6`](https://github.com/primer/view_components/commit/61c8a7d606f00eaf4e1b4c16f10306282ac034e0) Thanks [@jonrohan](https://github.com/jonrohan)! - Deleting deprecated Primer::Image component

* [#1620](https://github.com/primer/view_components/pull/1620) [`4898307e`](https://github.com/primer/view_components/commit/4898307eee7430555ef1e78fdfd1d3204c66823b) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - adding css source for Marketing Button and Link, from Primer CSS

- [#1626](https://github.com/primer/view_components/pull/1626) [`be3d92aa`](https://github.com/primer/view_components/commit/be3d92aaf1d6f656cc640a09168075279facfca3) Thanks [@simurai](https://github.com/simurai)! - Move `navigation` styles to PVC

* [#1617](https://github.com/primer/view_components/pull/1617) [`9322db97`](https://github.com/primer/view_components/commit/9322db976c7c29374faf7be3d4b4e1d0a12d42cf) Thanks [@simurai](https://github.com/simurai)! - Update `dropdown` hover text color

- [#1632](https://github.com/primer/view_components/pull/1632) [`7f1181be`](https://github.com/primer/view_components/commit/7f1181be49960337254db834e9b2b9a5fdb7b0b8) Thanks [@camertron](https://github.com/camertron)! - Improve performance of the deny\_\* methods

* [#1625](https://github.com/primer/view_components/pull/1625) [`3af9bf5e`](https://github.com/primer/view_components/commit/3af9bf5e778bb1fe475ed7efda9fc1a5ed36d695) Thanks [@jonrohan](https://github.com/jonrohan)! - Deprecate components and moving to new namespace:

  - Primer::Dropdown moving to Primer::Alpha::Dropdown
  - Primer::Dropdown::Menu moving to Primer::Alpha::Dropdown::Menu
  - Primer::Dropdown::Menu::Item moving to Primer::Alpha::Dropdown::Menu::Item

- [#1618](https://github.com/primer/view_components/pull/1618) [`72f8c3a9`](https://github.com/primer/view_components/commit/72f8c3a989e23135b56e347a0be8e2be4dbb253e) Thanks [@simurai](https://github.com/simurai)! - Move`Box` styles to PVC

* [#1629](https://github.com/primer/view_components/pull/1629) [`a7527531`](https://github.com/primer/view_components/commit/a7527531d01d0af4a08d002bb3024bca1828d40a) Thanks [@jonrohan](https://github.com/jonrohan)! - Deprecate Primer::PopoverComponent moving to Primer::Beta::Popover

- [#1634](https://github.com/primer/view_components/pull/1634) [`cdc13a18`](https://github.com/primer/view_components/commit/cdc13a18d406e9b0b2dd3bb4ba7b058c72052b84) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - Adding a custom erblint schema to allow `severity` in linter configuration

* [#1609](https://github.com/primer/view_components/pull/1609) [`c4408661`](https://github.com/primer/view_components/commit/c44086611439e93d7214068dd332f37308b7c24f) Thanks [@simurai](https://github.com/simurai)! - Move `autocomplete` styles to PVC

- [#1623](https://github.com/primer/view_components/pull/1623) [`7643e514`](https://github.com/primer/view_components/commit/7643e51449abe73a71453c1d2f46a69e8661a963) Thanks [@jonrohan](https://github.com/jonrohan)! - Deleting deprecated Primer::ProgressBarComponent in favor of Primer::Beta::ProgressBar

## 0.0.111

### Patch Changes

- [#1599](https://github.com/primer/view_components/pull/1599) [`62dd9461`](https://github.com/primer/view_components/commit/62dd946124001709dcb193a49af91dd785fa4f8c) Thanks [@simurai](https://github.com/simurai)! - Move `Popover` styles to PVC

* [#1605](https://github.com/primer/view_components/pull/1605) [`63b40c1b`](https://github.com/primer/view_components/commit/63b40c1bd83bdcf0114a238d9904330ea7af6e3a) Thanks [@jonrohan](https://github.com/jonrohan)! - Remove the deprecated `Primer::CounterComponet` and use `Primer::Beta::Counter`.

- [#1611](https://github.com/primer/view_components/pull/1611) [`047674c8`](https://github.com/primer/view_components/commit/047674c872b5ca3fedd768cee8473b7d5e665c95) Thanks [@safeforge](https://github.com/safeforge)! - Avoid double-registering of exported components

* [#1601](https://github.com/primer/view_components/pull/1601) [`ce2e959d`](https://github.com/primer/view_components/commit/ce2e959dd62d2859e6dbb3113bc1867ff7b3dcf8) Thanks [@simurai](https://github.com/simurai)! - Move `flash` styles to PVC

- [#1607](https://github.com/primer/view_components/pull/1607) [`c97f7b72`](https://github.com/primer/view_components/commit/c97f7b72daed4d167668ac703c59702522def49b) Thanks [@simurai](https://github.com/simurai)! - Move `Avatar` + `AvatarStack` styles to PVC

* [#1598](https://github.com/primer/view_components/pull/1598) [`040f4943`](https://github.com/primer/view_components/commit/040f49435db61d5ec454b1be68e9addb0bb47a9b) Thanks [@simurai](https://github.com/simurai)! - Move `TimelineItem` styles to PVC

- [#1608](https://github.com/primer/view_components/pull/1608) [`75ad4765`](https://github.com/primer/view_components/commit/75ad4765ccbac2b0b5e631877c26373d13760ed3) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - testing to ensure CSS classes used by PVC components are valid, according to the available selectors

* [#1600](https://github.com/primer/view_components/pull/1600) [`4501861b`](https://github.com/primer/view_components/commit/4501861b6d8eb662fda30a9e6c9fbbb62d1ed6d3) Thanks [@simurai](https://github.com/simurai)! - Move `dropdown` styles to PVC

## 0.0.110

### Patch Changes

- [#1583](https://github.com/primer/view_components/pull/1583) [`a06f52cf`](https://github.com/primer/view_components/commit/a06f52cf77eff76f5a9003a9b224dc425de78f4b) Thanks [@jonrohan](https://github.com/jonrohan)! - Migrating progress bar component to beta folder, and adding progress bar css.

* [#1579](https://github.com/primer/view_components/pull/1579) [`05e07bb1`](https://github.com/primer/view_components/commit/05e07bb1ff0a7d42fca94c0a922e24e7558af939) Thanks [@camertron](https://github.com/camertron)! - Move Banner to alpha namespace

- [#1592](https://github.com/primer/view_components/pull/1592) [`f743267e`](https://github.com/primer/view_components/commit/f743267e791222a8388084433b2fa4143b11b129) Thanks [@simurai](https://github.com/simurai)! - Move `Breadcrumbs` styles to PVC

* [#1584](https://github.com/primer/view_components/pull/1584) [`cad5c235`](https://github.com/primer/view_components/commit/cad5c23548ad5682c8dce0d8f2831b08c2628889) Thanks [@simurai](https://github.com/simurai)! - Move `blankslate` styles to PVC

- [#1574](https://github.com/primer/view_components/pull/1574) [`b3e351d2`](https://github.com/primer/view_components/commit/b3e351d23bc0f545ddb21384dc2567d08c07ed83) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - adding a test suite to show all component-specific selectors are used in previews, and updating various component previews for lookbook

* [#1587](https://github.com/primer/view_components/pull/1587) [`ac54ecc4`](https://github.com/primer/view_components/commit/ac54ecc4c2870cbb89d326d5d1808e6a36c543ec) Thanks [@simurai](https://github.com/simurai)! - Move labels styles to PVC

- [#1594](https://github.com/primer/view_components/pull/1594) [`55f0d4df`](https://github.com/primer/view_components/commit/55f0d4dfd6fa111b4b3c551e087119637255f617) Thanks [@simurai](https://github.com/simurai)! - Move `Subhead` styles to PVC

* [#1593](https://github.com/primer/view_components/pull/1593) [`7042b5f5`](https://github.com/primer/view_components/commit/7042b5f5ef7f52fcef0a268023b6f096bd1d43e5) Thanks [@simurai](https://github.com/simurai)! - Move `ToggleSwitch` styles to PVC

- [#1590](https://github.com/primer/view_components/pull/1590) [`820022c3`](https://github.com/primer/view_components/commit/820022c3fbd69ab7d16aadcd46f23e74673bd2b0) Thanks [@simurai](https://github.com/simurai)! - Move `Truncate` styles to PVC

## 0.0.109

### Patch Changes

- [#1554](https://github.com/primer/view_components/pull/1554) [`74db3db4`](https://github.com/primer/view_components/commit/74db3db45e5d36b239a5c3ccf2c1f30da1106a69) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - build the utilities.yml for PVC's classify utilities directly in PVC

* [#1566](https://github.com/primer/view_components/pull/1566) [`613f5697`](https://github.com/primer/view_components/commit/613f56976d184961405dc96cfc334a0e915098a0) Thanks [@dependabot](https://github.com/apps/dependabot)! - Allow arrow key navigation on aria-disabled elements in details-menu

- [#1571](https://github.com/primer/view_components/pull/1571) [`bc235b39`](https://github.com/primer/view_components/commit/bc235b3901ff03b0d10de61eb3b5e7b450cfd262) Thanks [@jonrohan](https://github.com/jonrohan)! - SegmentedControl: Don't update selected state on links

* [#1559](https://github.com/primer/view_components/pull/1559) [`b5340016`](https://github.com/primer/view_components/commit/b53400169d180a662ac9c07d1786f533c7c3c29d) Thanks [@camertron](https://github.com/camertron)! - Additional legacy flash/banner classes; fix data-target issue

- [#1576](https://github.com/primer/view_components/pull/1576) [`619a8f9a`](https://github.com/primer/view_components/commit/619a8f9a97d0a4854f01de9c19c06a50807a65d2) Thanks [@camertron](https://github.com/camertron)! - Remove redundant data-show-dialog-id system_argument in dialog component

* [#1575](https://github.com/primer/view_components/pull/1575) [`eead9f6a`](https://github.com/primer/view_components/commit/eead9f6ac1021d4398341408c292d2f00a6f486c) Thanks [@neall](https://github.com/neall)! - Allow form field names to end in "?"

## 0.0.108

### Patch Changes

- [#1560](https://github.com/primer/view_components/pull/1560) [`8bc7d1c5`](https://github.com/primer/view_components/commit/8bc7d1c588b94aded4f15f159b40be71c33f3121) Thanks [@safeforge](https://github.com/safeforge)! - Avoid double-registering of exported components

## 0.0.107

### Patch Changes

- [#1539](https://github.com/primer/view_components/pull/1539) [`c86d4785`](https://github.com/primer/view_components/commit/c86d4785460507d9cab9fc44edab281ad2b128ef) Thanks [@jonrohan](https://github.com/jonrohan)! - Bug Fix: Fixing bad CSS in action-list.css and writing test to check for error

* [#1552](https://github.com/primer/view_components/pull/1552) [`746696f4`](https://github.com/primer/view_components/commit/746696f42dccda969f5306e67952ddc80023390f) Thanks [@jonrohan](https://github.com/jonrohan)! - Disable focus-visible-pseudo-class plugin to fix primary Button

- [#1550](https://github.com/primer/view_components/pull/1550) [`8211b263`](https://github.com/primer/view_components/commit/8211b26385355f39baad810c63b12cb34193a0bd) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated `Primer::ImageCrop` component

* [#1538](https://github.com/primer/view_components/pull/1538) [`03008a4a`](https://github.com/primer/view_components/commit/03008a4a06f03f8120c6510f3a45694ef79f72b8) Thanks [@jonrohan](https://github.com/jonrohan)! - Export component CSS selectors as json file for use in component CSS coverage tests, linters, etc.

- [#1540](https://github.com/primer/view_components/pull/1540) [`94c6b7fd`](https://github.com/primer/view_components/commit/94c6b7fd6653bc207635393d8a28d8f5014e29f3) Thanks [@jonrohan](https://github.com/jonrohan)! - `app/components/primer/alpha/action_list/action-list.pcss` was re-written to `app/components/primer/alpha/action_list.pcss`

* [#1548](https://github.com/primer/view_components/pull/1548) [`c9b2c558`](https://github.com/primer/view_components/commit/c9b2c5581b6d91fae709b6150bbf41db8b85ede2) Thanks [@camertron](https://github.com/camertron)! - Include legacy flash classes in banners

## 0.0.106

### Patch Changes

- [#1533](https://github.com/primer/view_components/pull/1533) [`1ee5cc19`](https://github.com/primer/view_components/commit/1ee5cc19d21f45662038449f288f35797b117d16) Thanks [@camertron](https://github.com/camertron)! - Introduce the Banner component

## 0.0.105

### Patch Changes

- [#1531](https://github.com/primer/view_components/pull/1531) [`58436f71`](https://github.com/primer/view_components/commit/58436f71d8a64a290bcd725542b5c2434c7aacf4) Thanks [@issyl0](https://github.com/issyl0)! - rubocop/config/default: Unset `DisabledByDefault`

* [#1532](https://github.com/primer/view_components/pull/1532) [`d67dae0a`](https://github.com/primer/view_components/commit/d67dae0a6d762d4aeb9ed48926daa93d9f2e3405) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - migrate Primer::LinkComponent to Primer::Beta::Link and mark the old one as deprecated

- [#1395](https://github.com/primer/view_components/pull/1395) [`488532ce`](https://github.com/primer/view_components/commit/488532ceaa024fd04fb1e00d8b7f052608679a9e) Thanks [@josepmartins](https://github.com/josepmartins)! - Add a11yreviewed variable in frontmatter

* [#1527](https://github.com/primer/view_components/pull/1527) [`595a6754`](https://github.com/primer/view_components/commit/595a67548ada4efcc1268fb59b15ebb9cc7bc5b6) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - deprecating Primer::Image in favor of Primer::Alpha::Image

- [#1507](https://github.com/primer/view_components/pull/1507) [`16ecd00e`](https://github.com/primer/view_components/commit/16ecd00e6022c5fb7607f278a014537d77ce84ff) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding lookbook and status to `static/arguments.json` file.

* [#1225](https://github.com/primer/view_components/pull/1225) [`c026577c`](https://github.com/primer/view_components/commit/c026577caa9a4c0eb52b9f83f614a928ab3f7445) Thanks [@jonrohan](https://github.com/jonrohan)! - Creating new `Primer::Alpha::SegmentedControl` component. [Design guidelines](https://primer.style/design/components/segmented-control)

- [#1530](https://github.com/primer/view_components/pull/1530) [`72866fc2`](https://github.com/primer/view_components/commit/72866fc297a5b3e64562f3b535f58eb1fcecb75a) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - migrating Primer::LabelComponent to Primer::Beta::Label

* [#1528](https://github.com/primer/view_components/pull/1528) [`1724aa2b`](https://github.com/primer/view_components/commit/1724aa2b39a0c515b4e1135999fd8d0d4cc869de) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - migrating Primer::ImageCrop to Primer::Alpha::ImageCrop

## 0.0.104

### Patch Changes

- [#1505](https://github.com/primer/view_components/pull/1505) [`5d3448bb`](https://github.com/primer/view_components/commit/5d3448bb379621d2acaf22c2ed38fae6528497bd) Thanks [@camertron](https://github.com/camertron)! - Pass select list options to Rails form builder

* [#1498](https://github.com/primer/view_components/pull/1498) [`b3668d38`](https://github.com/primer/view_components/commit/b3668d3836c35e52a301544de9955b09c023e82a) Thanks [@neall](https://github.com/neall)! - Add option for nested forms for check boxes

- [#1488](https://github.com/primer/view_components/pull/1488) [`db5b5f65`](https://github.com/primer/view_components/commit/db5b5f6514cfd0952dd299b121f5cc2f2f001067) Thanks [@jonrohan](https://github.com/jonrohan)! - Building PostCSS components separately

* [#1486](https://github.com/primer/view_components/pull/1486) [`9a936bd1`](https://github.com/primer/view_components/commit/9a936bd18053f7f17d1c1146349a157b90c5c91e) Thanks [@langermank](https://github.com/langermank)! - Remove dead SCSS code from ActionList

- [#1491](https://github.com/primer/view_components/pull/1491) [`f43bd08a`](https://github.com/primer/view_components/commit/f43bd08af6ffcd7ad4607c61cc1569bf2fccd7ee) Thanks [@camertron](https://github.com/camertron)! - Allow IconButton tooltips to be hidden

## 0.0.103

### Patch Changes

- [#1457](https://github.com/primer/view_components/pull/1457) [`7fa6d221`](https://github.com/primer/view_components/commit/7fa6d221f4e2196d3421592d89f48a4abe7b8373) Thanks [@orhantoy](https://github.com/orhantoy)! - Remove dead Flex and FlexItem links from nav

* [#1469](https://github.com/primer/view_components/pull/1469) [`a3442456`](https://github.com/primer/view_components/commit/a3442456c5230918ff3cedb7293d4799b963599d) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::HeadingComponent component.

- [#1480](https://github.com/primer/view_components/pull/1480) [`c764cee6`](https://github.com/primer/view_components/commit/c764cee6744c91671db729bd7ac60dc532398820) Thanks [@koddsson](https://github.com/koddsson)! - Fix nested dialogs

* [#1466](https://github.com/primer/view_components/pull/1466) [`9b5cff15`](https://github.com/primer/view_components/commit/9b5cff1513ca24f85906fd8ed54d34d056504535) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::HiddenTextExpander component.

- [#1471](https://github.com/primer/view_components/pull/1471) [`5687bebe`](https://github.com/primer/view_components/commit/5687bebebb3c0fa58bf63d2a1ff09602b9f3987d) Thanks [@koddsson](https://github.com/koddsson)! - Make sure nested dialogs behave correctly

* [#1479](https://github.com/primer/view_components/pull/1479) [`b0281033`](https://github.com/primer/view_components/commit/b028103397ac94375035d38c5ca85e85aeffde08) Thanks [@khiga8](https://github.com/khiga8)! - move tooltip to be adjacent to button

- [#1468](https://github.com/primer/view_components/pull/1468) [`ae99c2ed`](https://github.com/primer/view_components/commit/ae99c2ed9e9b937d79443cbc393bddd6f02a2112) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::CloseButton component.

* [#1476](https://github.com/primer/view_components/pull/1476) [`f174b31c`](https://github.com/primer/view_components/commit/f174b31c7bf59d08402d03c35a2bc52fc34bc687) Thanks [@camertron](https://github.com/camertron)! - Bump view_component to 2.74.1 to fix deadlock issues in Lookbook

- [#1452](https://github.com/primer/view_components/pull/1452) [`9252a124`](https://github.com/primer/view_components/commit/9252a12435d9bb5a3bd2610a72e12358c1ca2c2b) Thanks [@steves](https://github.com/steves)! - Move sample forms out of test folder

* [#1467](https://github.com/primer/view_components/pull/1467) [`a3b562ca`](https://github.com/primer/view_components/commit/a3b562cae569902c0ce3131599654b8a00720095) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing the deprecated Primer::DetailsComponent component.

## 0.0.102

### Patch Changes

- [#1450](https://github.com/primer/view_components/pull/1450) [`ef4498df`](https://github.com/primer/view_components/commit/ef4498df7630e3b5d9895eb92910fc36622c32de) Thanks [@camertron](https://github.com/camertron)! - Don't export ToggleSwitchElement

* [#1446](https://github.com/primer/view_components/pull/1446) [`4f235520`](https://github.com/primer/view_components/commit/4f23552009b932be1238a38b7cef21ffcc6fe632) Thanks [@camertron](https://github.com/camertron)! - Allow NavLists to define sub-items as well as a trailing visual

- [#1445](https://github.com/primer/view_components/pull/1445) [`493530ed`](https://github.com/primer/view_components/commit/493530ed8e097c89322d52e73d6ac8a320573b43) Thanks [@camertron](https://github.com/camertron)! - Remove unused instance variable in ActionList

* [#1441](https://github.com/primer/view_components/pull/1441) [`bd8fe7f5`](https://github.com/primer/view_components/commit/bd8fe7f5c9c20e28354d96a36717f6a56ef57fa4) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated FlexComponent and FlexItemComponent

## 0.0.101

### Patch Changes

- [#1424](https://github.com/primer/view_components/pull/1424) [`d7b277ef`](https://github.com/primer/view_components/commit/d7b277ef00aed062d6d123cb99c014a14ea3c7a1) Thanks [@camertron](https://github.com/camertron)! - Allow specifying an unchecked value for check box inputs

* [#1439](https://github.com/primer/view_components/pull/1439) [`56fae759`](https://github.com/primer/view_components/commit/56fae7599e74b1b734e30c10b7b8b54e4782df5d) Thanks [@camertron](https://github.com/camertron)! - Support system arguments for ActionList item anchor tags

- [#1438](https://github.com/primer/view_components/pull/1438) [`b0329cda`](https://github.com/primer/view_components/commit/b0329cdac8ea5edbe38ddec20107777c394caa0d) Thanks [@langermank](https://github.com/langermank)! - ActionListItem `line-height` bug fix

* [#1435](https://github.com/primer/view_components/pull/1435) [`8312e6ce`](https://github.com/primer/view_components/commit/8312e6cee8f51260e810000ed89624e2f316e25b) Thanks [@camertron](https://github.com/camertron)! - Allow NavList items to be selected by the current page

## 0.0.100

### Patch Changes

- [#1428](https://github.com/primer/view_components/pull/1428) [`b7b0c8be`](https://github.com/primer/view_components/commit/b7b0c8be1e2a82327f6dd4b2104a3e4fb3089394) Thanks [@bolonio](https://github.com/bolonio)! - Remove external classes from the the button content `<span>` in `Primer::beta::Button`

* [#1427](https://github.com/primer/view_components/pull/1427) [`2139fa30`](https://github.com/primer/view_components/commit/2139fa30982b49e88a44ab6be72f3428f6e5b0f1) Thanks [@langermank](https://github.com/langermank)! - Beta::Button CSS bug fixes

## 0.0.99

### Patch Changes

- [#1421](https://github.com/primer/view_components/pull/1421) [`c35a5c32`](https://github.com/primer/view_components/commit/c35a5c3226ab39aa62182ee4816e63d9c1d0c598) Thanks [@langermank](https://github.com/langermank)! - Fix Beta::Button visual regressions
  - Add back link styles
  - Ensure invisible buttons are blue when no visuals are present

* [#1422](https://github.com/primer/view_components/pull/1422) [`a129a4d1`](https://github.com/primer/view_components/commit/a129a4d1b7d1dfae6d2d623e1603ea6e75533940) Thanks [@camertron](https://github.com/camertron)! - Add SVG and custom content options to NavList's leading visual slot

## 0.0.98

### Patch Changes

- [#1420](https://github.com/primer/view_components/pull/1420) [`d6623553`](https://github.com/primer/view_components/commit/d662355359b1b5d8801cc6a86a1376cb1d2da63b) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - un-deprecate Primer::ButtonComponent for now, due to inconsistencies and issues in migrating to Primer::Beta::Button

* [`1d4b6851`](https://github.com/primer/view_components/commit/1d4b685174ca82cb0f67e65cc095810841b0b390) Thanks [@jonrohan](https://github.com/jonrohan)! - Move previews into root and include in gemspec. Thanks [@steves](https://github.com/steves)! [#1404](https://github.com/primer/view_components/pull/1404)

- [#1416](https://github.com/primer/view_components/pull/1416) [`f99156fd`](https://github.com/primer/view_components/commit/f99156fddcab45467a4da773387efa4ea13401c3) Thanks [@jonrohan](https://github.com/jonrohan)! - Don't use outside images in docs examples

## 0.0.97

### Patch Changes

- [#1268](https://github.com/primer/view_components/pull/1268) [`f26afd94`](https://github.com/primer/view_components/commit/f26afd9427c82d38c0c1f7d866dade959cb78364) Thanks [@camertron](https://github.com/camertron)! - Add the ActionList and NavList components

* [#1412](https://github.com/primer/view_components/pull/1412) [`cf548425`](https://github.com/primer/view_components/commit/cf54842572f9e040c1fb51c2b9c0c5e3a2902235) Thanks [@owenniblock](https://github.com/owenniblock)! - Change header tag to div on `Primer::Alpha::Dialog`

## 0.0.96

### Patch Changes

- [#1400](https://github.com/primer/view_components/pull/1400) [`ae48b9fe`](https://github.com/primer/view_components/commit/ae48b9fe9d7ef3a908ea9f84f5fd25cf9bf40e50) Thanks [@langermank](https://github.com/langermank)! - - Add Lookbook previews for Beta Button and IconButton
  - Tiny CSS bug fix

* [#1406](https://github.com/primer/view_components/pull/1406) [`1fec4bf5`](https://github.com/primer/view_components/commit/1fec4bf5097d3f002208840694d05dd4401c7a83) Thanks [@jonrohan](https://github.com/jonrohan)! - Raise on usage of deprecated arguments in Primer::Beta::Button

- [#1402](https://github.com/primer/view_components/pull/1402) [`7e50f6d9`](https://github.com/primer/view_components/commit/7e50f6d93338da50e2aa670c7c9f1a23fb7dfecc) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Move Octicon cache preload to initializer.

## 0.0.95

### Patch Changes

- [#1372](https://github.com/primer/view_components/pull/1372) [`98155b10`](https://github.com/primer/view_components/commit/98155b10599d3b1753c32b7c247acadff926eaa4) Thanks [@jonrohan](https://github.com/jonrohan)! - Delete the deprecated Primer::ButtonGroup component

* [#1386](https://github.com/primer/view_components/pull/1386) [`142b8193`](https://github.com/primer/view_components/commit/142b8193abd973a5bf6fd413d0a1e11fa0b3d3ae) Thanks [@khiga8](https://github.com/khiga8)! - Make sure duplicate ID associations aren't created for the Button

- [#1371](https://github.com/primer/view_components/pull/1371) [`d0ddcce0`](https://github.com/primer/view_components/commit/d0ddcce0fbb4b46b1746e5688b23c54e1ba74f12) Thanks [@jonrohan](https://github.com/jonrohan)! - Delete the deprecated Primer::BaseButton component

* [#1396](https://github.com/primer/view_components/pull/1396) [`e0c50dcb`](https://github.com/primer/view_components/commit/e0c50dcbc12f31bdc0cac480f563952404051f14) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - mark Primer::ButtonComponent as deprecated in favor of Primer::Beta::Button

- [#1393](https://github.com/primer/view_components/pull/1393) [`5533f8e7`](https://github.com/primer/view_components/commit/5533f8e7dfffceba0e4b94bbc3bae1e17ebcff91) Thanks [@camertron](https://github.com/camertron)! - Add the Requested-With header to toggle switch requests

* [#1382](https://github.com/primer/view_components/pull/1382) [`6fd690c8`](https://github.com/primer/view_components/commit/6fd690c8804cd4a1cc8bdbb76d1f6f7e795ab8d6) Thanks [@kangarruu](https://github.com/kangarruu)! - Docs change to fix typo and descriptions in dialog.rb

- [#1397](https://github.com/primer/view_components/pull/1397) [`1ad8cfa7`](https://github.com/primer/view_components/commit/1ad8cfa753872e3ee5d196315ed5048351073029) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - deprecated Primer::IconButton in favor of Primer::Beta::IconButton"

* [#1390](https://github.com/primer/view_components/pull/1390) [`94c31645`](https://github.com/primer/view_components/commit/94c316459db0299afa0946eee5ae2987a16879f3) Thanks [@neall](https://github.com/neall)! - Support submitting a check box group as an array

- [#1392](https://github.com/primer/view_components/pull/1392) [`1f424aab`](https://github.com/primer/view_components/commit/1f424aabc6e8be4bd3a2c55190414a1b125b9111) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing `static/arguments.yml` and replacing with `static/arguments.json`. The data output doesn't change.

* [#1381](https://github.com/primer/view_components/pull/1381) [`040148d8`](https://github.com/primer/view_components/commit/040148d8cc197c12945466b99805177db69fbf95) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Simplify CI configuration to a single build per Ruby/Rails version.

- [#1394](https://github.com/primer/view_components/pull/1394) [`27d82335`](https://github.com/primer/view_components/commit/27d823358e4abb9ba6c5c208c44aab300546c144) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding optional wrapper arguments to IconButton

## 0.0.94

### Patch Changes

- [#1352](https://github.com/primer/view_components/pull/1352) [`a02944bb`](https://github.com/primer/view_components/commit/a02944bb6e2393ebe476466b96cfc022dd571fd2) Thanks [@jonrohan](https://github.com/jonrohan)! - Update eslint custom-element rules so web components can match ruby component names

* [#1364](https://github.com/primer/view_components/pull/1364) [`e8714975`](https://github.com/primer/view_components/commit/e87149754da0a7551ddc18f6244ec901fede943f) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - added Primer::Alpha::ToggleSwitch to the docs build task so it will build and deploy

- [#1354](https://github.com/primer/view_components/pull/1354) [`c1edd34f`](https://github.com/primer/view_components/commit/c1edd34f8e60ec5b9689891e279ded3a8b0ef23e) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - consolidating deprecations into a single list, updating component status migrator for this change, and ensuring rubocop / erblint deprecation linters can be run against changed files only instead of all files

## 0.0.93

### Patch Changes

- [#1214](https://github.com/primer/view_components/pull/1214) [`33949aa9`](https://github.com/primer/view_components/commit/33949aa9e1be9e9a86a1eefb10e9cd3b47ecdeda) Thanks [@keithamus](https://github.com/keithamus)! - Adding Primer Dialog Component

* [#1325](https://github.com/primer/view_components/pull/1325) [`a54e5510`](https://github.com/primer/view_components/commit/a54e5510ecc87b55ed9a6bf71ac1c9d2e3b3fef9) Thanks [@langermank](https://github.com/langermank)! - Adding Primer::Beta::Button and Primer::Beta::IconButton with visual refinements

- [#1340](https://github.com/primer/view_components/pull/1340) [`a4f868c3`](https://github.com/primer/view_components/commit/a4f868c32af1ae76f2bba760e9565c2bade22f56) Thanks [@jsoref](https://github.com/jsoref)! - Let forks ✅ on `main`

* [#1335](https://github.com/primer/view_components/pull/1335) [`cbf52761`](https://github.com/primer/view_components/commit/cbf52761ab5624dfd9bc35a2220f87068c370039) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding the `postcss-mixins` plugin to our CSS build step.

## 0.0.92

### Patch Changes

- [#1312](https://github.com/primer/view_components/pull/1312) [`ff515aa4`](https://github.com/primer/view_components/commit/ff515aa43baf99eda3ba56ede28693c733307b19) Thanks [@danielnc](https://github.com/danielnc)! - Fixing Primer::Forms::ActsAsComponent::TemplateParams keyword args

* [#1331](https://github.com/primer/view_components/pull/1331) [`7bf8ba76`](https://github.com/primer/view_components/commit/7bf8ba76ce54bc509eb12ab29f1aa0e3c5f6d3d8) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated Primer::BorderBoxComponent

- [#1318](https://github.com/primer/view_components/pull/1318) [`624a8875`](https://github.com/primer/view_components/commit/624a8875a7cc1640a23dec3cc8256ffb893ec1c3) Thanks [@jonrohan](https://github.com/jonrohan)! - Removing deprecated Primer::ButtonGroup component

* [#1330](https://github.com/primer/view_components/pull/1330) [`b89ac4dd`](https://github.com/primer/view_components/commit/b89ac4dd64be4e7fcbb4a14cf486a326db4e4a3c) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Rename test class names that collided

- [#1332](https://github.com/primer/view_components/pull/1332) [`3004d86d`](https://github.com/primer/view_components/commit/3004d86db2d7e99dbe16f85ce02100499661b1be) Thanks [@jonrohan](https://github.com/jonrohan)! - Ignore compiled _.js _.css files

* [#1307](https://github.com/primer/view_components/pull/1307) [`311fe11e`](https://github.com/primer/view_components/commit/311fe11e7a9e918e6a749c0f01b5db68b3210c2d) Thanks [@khiga8](https://github.com/khiga8)! - Improving screen reader support for tooltip with `sr-only`

- [#1321](https://github.com/primer/view_components/pull/1321) [`f18ef0f0`](https://github.com/primer/view_components/commit/f18ef0f0ea1404dd081cf4398505304ca9b9087d) Thanks [@camertron](https://github.com/camertron)! - Adding Primer::Alpha::ToggleSwitch component

## 0.0.91

### Patch Changes

- [#1280](https://github.com/primer/view_components/pull/1280) [`1337cd47`](https://github.com/primer/view_components/commit/1337cd471cb26eda8813ec7c508a0f19e7d0309b) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - moving Primer::DetailsComponent to Primer::Beta::Details, and replacing the original with a deprecated component for backward compatibility

* [#1303](https://github.com/primer/view_components/pull/1303) [`16204453`](https://github.com/primer/view_components/commit/1620445358b7dbc482fa371ac9df8a221f00ca90) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - moving Primer::Alpha::HiddenTextExpander to Primer::Alpha::HiddenTextExpander and replacing the original with a deprecated version

- [#1314](https://github.com/primer/view_components/pull/1314) [`9aef2dcb`](https://github.com/primer/view_components/commit/9aef2dcb4164e0a92f160c49ab40dd74fb24c8ff) Thanks [@camertron](https://github.com/camertron)! - Instruct terser to not mangle class names so Catalyst works

* [#1306](https://github.com/primer/view_components/pull/1306) [`5e9003eb`](https://github.com/primer/view_components/commit/5e9003eb32740c7a18864f2e6d7d51642e31d615) Thanks [@khiga8](https://github.com/khiga8)! - Update docs to discourage standalone tooltip use.

- [#1308](https://github.com/primer/view_components/pull/1308) [`b773b71c`](https://github.com/primer/view_components/commit/b773b71cbcecc20c04a835efc24e0dca0995b118) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Update ViewComponent dependency to fix failing integration tests.

* [#1297](https://github.com/primer/view_components/pull/1297) [`c684d071`](https://github.com/primer/view_components/commit/c684d0718b571d47cd508f3865237743c48172ee) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - migrating Primer::HeadingComponent to Primer::Beta::Heading, and replacing original with deprecated version

- [#1316](https://github.com/primer/view_components/pull/1316) [`6241f130`](https://github.com/primer/view_components/commit/6241f1307f4b46cce23981b5a1916c424a700d4c) Thanks [@jonrohan](https://github.com/jonrohan)! - Creating a primer_view_components.css bundle that will ship with the npm package

## 0.0.90

### Patch Changes

- [#1290](https://github.com/primer/view_components/pull/1290) [`cc81b54c`](https://github.com/primer/view_components/commit/cc81b54ccdeb685efb3711aad02e8229fee9d9c5) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating BorderBox slot use to the new `.with_#{slot_name}` syntax

* [#1294](https://github.com/primer/view_components/pull/1294) [`52fed9a9`](https://github.com/primer/view_components/commit/52fed9a944cae6104eeba1054d4a00b309eac795) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating slot use for examples in all components in the root component folder

- [#1295](https://github.com/primer/view_components/pull/1295) [`26d6c3e3`](https://github.com/primer/view_components/commit/26d6c3e3412ca18e71cd67b0797c40183f47ff17) Thanks [@khiga8](https://github.com/khiga8)! - Revert "Use `visibility: 'hidden'` instead of `hidden` attribute"

* [#1292](https://github.com/primer/view_components/pull/1292) [`28cdc994`](https://github.com/primer/view_components/commit/28cdc99466471fa7f89fe9cf094a91509456b604) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating slot use in examples, for all `status :alpha` components

- [#1293](https://github.com/primer/view_components/pull/1293) [`4d1e8d29`](https://github.com/primer/view_components/commit/4d1e8d297f52023ce3901e29e364bc1584cc6546) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating slot use for components in the beta/ folder

* [`fe709011`](https://github.com/primer/view_components/commit/fe7090113519090d08eddf04540986702c9a595e) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - move the Primer::CloseButton component into Primer::Beta::CloseButton, update all references, create a deprecated Primer::CloseButton in place of the original

- [`7da8c968`](https://github.com/primer/view_components/commit/7da8c968ef20fa3c19e1c6850886694a942facda) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - moving Primer::Counter to Primer::Beta::Counter, and replace original with a deprecated version"

## 0.0.89

### Patch Changes

- [#1284](https://github.com/primer/view_components/pull/1284) [`401dac2a`](https://github.com/primer/view_components/commit/401dac2a1ab2e026b231399ddb03cfb51bc7742f) Thanks [@jonrohan](https://github.com/jonrohan)! - Don't render tooltip on IconButton when tag is a summary element

* [#1283](https://github.com/primer/view_components/pull/1283) [`ea1c29d7`](https://github.com/primer/view_components/commit/ea1c29d7fa0d917a729cba684bf5f8ae039bb228) Thanks [@jonrohan](https://github.com/jonrohan)! - Updating label component to not always have large

## 0.0.88

### Patch Changes

- [#1275](https://github.com/primer/view_components/pull/1275) [`1e9ce95c`](https://github.com/primer/view_components/commit/1e9ce95cdc942acdb51807839b2924731a1ab295) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - move Primer::ButtonGroup to Primer::Beta::ButtonGroup, update all references, and add deprecated Primer::ButtonGroup for backwards compatibility

* [#1266](https://github.com/primer/view_components/pull/1266) [`7d2949de`](https://github.com/primer/view_components/commit/7d2949de758b97aa940287a1ceabd5d16209cae2) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - moving Primer::BoxComponent to Primer::Box and creating deprecated Primer::BoxComponent for backward compatibility

- [#1281](https://github.com/primer/view_components/pull/1281) [`843061de`](https://github.com/primer/view_components/commit/843061de168a1927a80fd22e7da795c1a9ddaacd) Thanks [@jonrohan](https://github.com/jonrohan)! - Always set `:absolute` position on Primer::Alpha::Tooltip

* [#934](https://github.com/primer/view_components/pull/934) [`d638fefb`](https://github.com/primer/view_components/commit/d638fefbb55ce9802e91b374903bcde9cc6ab612) Thanks [@pouretrebelle](https://github.com/pouretrebelle)! - Refactor the LabelComponent API

## 0.0.87

### Patch Changes

- [#1274](https://github.com/primer/view_components/pull/1274) [`c153f734`](https://github.com/primer/view_components/commit/c153f734a891fc3bc7dfc3bed34630ff38ab39d7) Thanks [@jonrohan](https://github.com/jonrohan)! - Fixing whitespace in rendered LinkComponent

* [#1273](https://github.com/primer/view_components/pull/1273) [`f38517ac`](https://github.com/primer/view_components/commit/f38517acf1aed43b27f2c6b94634d70b124883e6) Thanks [@camertron](https://github.com/camertron)! - Revert removal of BlankslateComponent

- [#1270](https://github.com/primer/view_components/pull/1270) [`44919308`](https://github.com/primer/view_components/commit/4491930812d16a9bcb5d8f05b4d94e49e469afa5) Thanks [@camertron](https://github.com/camertron)! - Use a custom form builder; introduce primer_form_for

* [#1269](https://github.com/primer/view_components/pull/1269) [`9ae9615f`](https://github.com/primer/view_components/commit/9ae9615f31acf43875feb89661cac6311527f9fd) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating component migrator script with improvements in component reference updates, deprecations, etc.

- [#1276](https://github.com/primer/view_components/pull/1276) [`759ea56f`](https://github.com/primer/view_components/commit/759ea56f00cbe3e536f4e558a9fb9a3e1b89bf7b) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - correcting the updates to nav.yml in the component status migrator

## 0.0.86

### Patch Changes

- [#1247](https://github.com/primer/view_components/pull/1247) [`dbe606b7`](https://github.com/primer/view_components/commit/dbe606b7f38ba52f24edeae2f02f390ad13133ab) Thanks [@khiga8](https://github.com/khiga8)! - Set `aria-hidden="true"` when type is label

* [#1262](https://github.com/primer/view_components/pull/1262) [`4a347b69`](https://github.com/primer/view_components/commit/4a347b6965990c1d73296d297367cb72b36539d2) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating the component migrator to support `--status stable`

- [#1244](https://github.com/primer/view_components/pull/1244) [`91a6d2df`](https://github.com/primer/view_components/commit/91a6d2df032fbb21ccaf3edc07b86f3c97b1add0) Thanks [@neall](https://github.com/neall)! - Stop requiring aria-label on ClipboardCopy with other content.

* [#1256](https://github.com/primer/view_components/pull/1256) [`544dd564`](https://github.com/primer/view_components/commit/544dd5647da64c06020d3ae7719f9b6ad32bee55) Thanks [@khiga8](https://github.com/khiga8)! - Use `visibility: 'hidden'` instead of `hidden` attribute to hide tooltip

- [#1238](https://github.com/primer/view_components/pull/1238) [`204a8e4e`](https://github.com/primer/view_components/commit/204a8e4e11931061f7a855b79f90c7aaa2e51945) Thanks [@camertron](https://github.com/camertron)! - Merge primer/rails_forms into primer/view_components

* [#1265](https://github.com/primer/view_components/pull/1265) [`61a78c4f`](https://github.com/primer/view_components/commit/61a78c4f3362fc532149ddf5090252dd3af9122d) Thanks [@jonrohan](https://github.com/jonrohan)! - Update IconButton and Button tooltips to be sibling instead of child

- [#1255](https://github.com/primer/view_components/pull/1255) [`3729a9bf`](https://github.com/primer/view_components/commit/3729a9bfed5d1dbe40510b6a783212453fcc08d3) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - migrating `Primer::BorderBoxComponent` to `Primer::Beta::BorderBox`

* [#1241](https://github.com/primer/view_components/pull/1241) [`918cfe3f`](https://github.com/primer/view_components/commit/918cfe3f143e5fe30dfb4db1dd46449bc54a0a87) Thanks [@jonrohan](https://github.com/jonrohan)! - Deprecating the `Primer::Alpha::Autocomplete` component

- [#1062](https://github.com/primer/view_components/pull/1062) [`4b673a6c`](https://github.com/primer/view_components/commit/4b673a6c1ec9f0bc0710128fc365448e94d7b387) Thanks [@hectahertz](https://github.com/hectahertz)! - Add `Tooltip` support to `IconButton`

* [#1261](https://github.com/primer/view_components/pull/1261) [`8191b80d`](https://github.com/primer/view_components/commit/8191b80de219f100c07cea9d9fdabfa9f50f6e1e) Thanks [@camertron](https://github.com/camertron)! - Make all subdirs of docs/static in prepare script

- [#1260](https://github.com/primer/view_components/pull/1260) [`1a6562fe`](https://github.com/primer/view_components/commit/1a6562fe46503e21aade77df1f6ae542cbc2ddd6) Thanks [@khiga8](https://github.com/khiga8)! - Move tooltip to be sibling of link

* [#1258](https://github.com/primer/view_components/pull/1258) [`d3880f74`](https://github.com/primer/view_components/commit/d3880f74d4fe20ad1a81c9b40af10c67dda52369) Thanks [@camertron](https://github.com/camertron)! - Replace YAML load with YAML safe load with allowed classes list

- [#1254](https://github.com/primer/view_components/pull/1254) [`fc2fbace`](https://github.com/primer/view_components/commit/fc2fbace9c4728dea582df40efde118cfe8ac6a8) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - cleaning up the BlankSlate component to ensure it follows current standards for beta components

## 0.0.85

### Patch Changes

- [#1239](https://github.com/primer/view_components/pull/1239) [`bc9e8385`](https://github.com/primer/view_components/commit/bc9e8385894b708929d0e58a63681572493f090e) Thanks [@langermank](https://github.com/langermank)! - Remove deprecated params added for autocomplete beta

## 0.0.84

### Patch Changes

- [#1189](https://github.com/primer/view_components/pull/1189) [`ec3af746`](https://github.com/primer/view_components/commit/ec3af746dceb8e4a0c967fe270f149d48e81489b) Thanks [@langermank](https://github.com/langermank)! - Autocomplete design updates

* [#1229](https://github.com/primer/view_components/pull/1229) [`5631d286`](https://github.com/primer/view_components/commit/5631d286c559cf4bbb96b85c0bb41dbeda5953d4) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - component generator: correcting template and thor tasks to account for component status

- [#1232](https://github.com/primer/view_components/pull/1232) [`3a154bf4`](https://github.com/primer/view_components/commit/3a154bf4452f5ed8f7694eb917c13258d34ff6c0) Thanks [@jonrohan](https://github.com/jonrohan)! - Consolidating view_components previews into test/previews/ folder

* [#1224](https://github.com/primer/view_components/pull/1224) [`2fc38746`](https://github.com/primer/view_components/commit/2fc387460e5f185463cbca8ffe0f098a06e2dec8) Thanks [@camertron](https://github.com/camertron)! - Add the ConditionalWrapper for conditionally wrapping content

- [#1234](https://github.com/primer/view_components/pull/1234) [`ee04a4a9`](https://github.com/primer/view_components/commit/ee04a4a937c56156b3232552c7d10b0ec0336ab7) Thanks [@mxriverlynn](https://github.com/mxriverlynn)! - updating links in the contributing docs to point to correct locations

## 0.0.83

### Patch Changes

- [#1222](https://github.com/primer/view_components/pull/1222) [`d48f6c4b`](https://github.com/primer/view_components/commit/d48f6c4ba45945ad87e81ea98e16d36347a864eb) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding listen path for the app/components folder

* [#1223](https://github.com/primer/view_components/pull/1223) [`c675cfe1`](https://github.com/primer/view_components/commit/c675cfe15425ad61f89c0d9f78c6f5ad36f11f75) Thanks [@khiga8](https://github.com/khiga8)! - Update README.md

- [#1215](https://github.com/primer/view_components/pull/1215) [`32a8b21f`](https://github.com/primer/view_components/commit/32a8b21f5d0281ce10504946c8541520764310ac) Thanks [@khiga8](https://github.com/khiga8)! - Add `DeprecatedComponents` ERB lint rule

* [#1228](https://github.com/primer/view_components/pull/1228) [`ab9dfabc`](https://github.com/primer/view_components/commit/ab9dfabc92b7914f10828ffd6580a91508eae764) Thanks [@khiga8](https://github.com/khiga8)! - Update devcontainer.json with ERB lint extension

- [#1227](https://github.com/primer/view_components/pull/1227) [`85fdb403`](https://github.com/primer/view_components/commit/85fdb40385cf59dd181aceff56c4991515a7f3fe) Thanks [@keithamus](https://github.com/keithamus)! - Upgrade JS packages

* [#1216](https://github.com/primer/view_components/pull/1216) [`e3de2bb4`](https://github.com/primer/view_components/commit/e3de2bb466518b380ef87b1f4a2433fdc3bbbfcc) Thanks [@jonrohan](https://github.com/jonrohan)! - Move lookbook previews from the lookbook folder to the main project

## 0.0.82

### Patch Changes

- [#1211](https://github.com/primer/view_components/pull/1211) [`047c6be6`](https://github.com/primer/view_components/commit/047c6be6f601192255a3611940e46fc5a24b46bd) Thanks [@camertron](https://github.com/camertron)! - Don't lint ERB files with Rubocop

* [#1210](https://github.com/primer/view_components/pull/1210) [`7b3d5941`](https://github.com/primer/view_components/commit/7b3d59415d846e254128d04253fadfdb399c8c84) Thanks [@camertron](https://github.com/camertron)! - Silence polymorphic slots warning message

## 0.0.81

### Patch Changes

- [#1200](https://github.com/primer/view_components/pull/1200) [`a6505054`](https://github.com/primer/view_components/commit/a6505054a07ae006c9d48e19a2b4be6c2e2663b3) Thanks [@camertron](https://github.com/camertron)! - Use Rubocop cops to lint .erb files

* [#1201](https://github.com/primer/view_components/pull/1201) [`de2c7d68`](https://github.com/primer/view_components/commit/de2c7d68ff7d13135c04f5dd40a1e547e41923ba) Thanks [@camertron](https://github.com/camertron)! - Add xsmall size for octicons

## 0.0.80

### Patch Changes

- [#1192](https://github.com/primer/view_components/pull/1192) [`d9440694`](https://github.com/primer/view_components/commit/d9440694cccd6eee9642ee74a1f2c351c83de1e7) Thanks [@camertron](https://github.com/camertron)! - Fix sidebar link to the Flash component in docs

* [#1199](https://github.com/primer/view_components/pull/1199) [`3c16e7b3`](https://github.com/primer/view_components/commit/3c16e7b3825d9644a0628edf3d317c3418a9ca03) Thanks [@BlakeWilliams](https://github.com/BlakeWilliams)! - Prevent slot from overriding component system_arguments

- [#1191](https://github.com/primer/view_components/pull/1191) [`d82359d6`](https://github.com/primer/view_components/commit/d82359d6ea677ffa17c134536bfe660e27ce4851) Thanks [@camertron](https://github.com/camertron)! - Fix PVC installation docs to mention correct Javascript include

* [#1198](https://github.com/primer/view_components/pull/1198) [`63977720`](https://github.com/primer/view_components/commit/63977720e421d06942320c79345536a52ff4f9e2) Thanks [@camertron](https://github.com/camertron)! - Add ActionList linter

- [#1194](https://github.com/primer/view_components/pull/1194) [`568f312c`](https://github.com/primer/view_components/commit/568f312cce81250d6699027febb6ff3816532ca8) Thanks [@camertron](https://github.com/camertron)! - Remove version manager files

## 0.0.79

### Patch Changes

- [#1188](https://github.com/primer/view_components/pull/1188) [`fb7218ac`](https://github.com/primer/view_components/commit/fb7218ac5c4de2253cb627c99bc9469635cde98b) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Revert leftover deprecated arguments from 1163.

## 0.0.78

### Patch Changes

- [#1186](https://github.com/primer/view_components/pull/1186) [`ff2c3fe1`](https://github.com/primer/view_components/commit/ff2c3fe1913d7a1d65dbd4f608b68155ed247bef) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Revert #1163, as additional work will be needed to ship those changes to production successfully.

## 0.0.77

### Patch Changes

- [#1185](https://github.com/primer/view_components/pull/1185) [`66a15b1a`](https://github.com/primer/view_components/commit/66a15b1a556e9814109317729b729dbee5316594) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Rename FlashComponent to Flash

* [#1183](https://github.com/primer/view_components/pull/1183) [`84b9e4ef`](https://github.com/primer/view_components/commit/84b9e4ef60c9f0d1c2df830f247f2a55aac82783) Thanks [@camertron](https://github.com/camertron)! - Remove trailing newlines from the output of LinkComponent

## 0.0.76

### Patch Changes

- [#1182](https://github.com/primer/view_components/pull/1182) [`33fc7907`](https://github.com/primer/view_components/commit/33fc7907b0476bebd1d2c54e3e9c335b5e12da3b) Thanks [@camertron](https://github.com/camertron)! - Adjust DeprecatedArguments cop to handle boolean values

* [#1179](https://github.com/primer/view_components/pull/1179) [`aa7afef2`](https://github.com/primer/view_components/commit/aa7afef27dff6baac2d98e23d47194fbfddbe181) Thanks [@maxbeizer](https://github.com/maxbeizer)! - Add `role` to system args docs.

- [#1180](https://github.com/primer/view_components/pull/1180) [`3dfcf015`](https://github.com/primer/view_components/commit/3dfcf015af0e301e54a15986cb114ccf84dd65d9) Thanks [@joelhawksley](https://github.com/joelhawksley)! - Upgrading view_component
  - Bump to latest release of [view_component 2.56.0](https://github.com/github/view_component/releases/tag/v2.56.0).
  - Remove dependency on the now-changed private `@rendered_component` api.

## 0.0.75

### Patch Changes

- [#1163](https://github.com/primer/view_components/pull/1163) [`1fabdc63`](https://github.com/primer/view_components/commit/1fabdc636e44094cebbaf58bfde7c15e2231016a) Thanks [@langermank](https://github.com/langermank)! - Autocomplete design updates

## 0.0.74

### Patch Changes

- [#1150](https://github.com/primer/view_components/pull/1150) [`36702a8e`](https://github.com/primer/view_components/commit/36702a8e621766772fe09d80de74c4debe8950fd) Thanks [@jonrohan](https://github.com/jonrohan)! - Adding changesets workflow to the repository for managing releases.

* [#1153](https://github.com/primer/view_components/pull/1153) [`8b21a680`](https://github.com/primer/view_components/commit/8b21a6808f5a9b18bd8b436b07b5b8b84b5a7397) Thanks [@camertron](https://github.com/camertron)! - Add a linter for calls to super in templates

- [#1141](https://github.com/primer/view_components/pull/1141) [`300f79a7`](https://github.com/primer/view_components/commit/300f79a762c71397de90f8d1cada529b9e9d63b6) Thanks [@maxbeizer](https://github.com/maxbeizer)! - AutoComplete component does not apply stacked label class if the label is not visible

## 0.0.73

### Bug

- Add conditional check for shadow root to avoid errors.

  _Kate Higa_

## 0.0.72

### Bug

- Fix tooltip arrow being off-centered for `s` and `n`.
- Revert tooltip arrow offset for `sw`, `se`, `nw`, and `ne`.

  _Kate Higa_

### Misc

- Adding [lookbook](https://github.com/allmarkedup/lookbook) dev server to the project.

  _Jon Rohan_

- Bump @primer/behaviors and remove dead code.

  _Kate Higa_

- Enable `eslint-plugin-custom-elements` linting rulesets.

  _Kate Higa_, _Kristján Oddsson_

- Introduce `DeprecatedComponents` rubocop rule.

  _Kate Higa_

- Fix alphabetization of components in docs.

  _David Wilson_

- Give codespaces more memory (4gb is not sufficient).

  _Lindsey Wild_
  _Cameron Dutro_

- Rewrite the documentation for deploying the Rails storybook.

  _Cameron Dutro_

### Bug Fixes

- Ensure that no whitespace is added inside LinkComponent.

  _Sam Morrow_

### Misc

- Update documentation to reflect deprecation of `require "view_component/engine"`

  _Leo Correa_

## 0.0.71

### Updates

- Add responsive values for `text_align` system argument

  _Lukas Spieß_

## 0.0.70

### New

- Add `Tooltip` support to `Button`.

  _Hector Garcia_

- Add `Tooltip` support to `Link`.

  _Hector Garcia_

### Updates

- Bumps @primer/css to 19.7.1
  _Kate Higa_

- Bumps auto-complete package to 3.1.0
- Updates AutoComplete API with optional clear button, restricted icon, and other argument restrictions

  _Lindsey Wild_, _Kate Higa_, _Owen Niblock_

- Check for the `gh` CLI tool in release scripts.

  _Cameron Dutro_

### Bug Fixes

- Ensure tooltip arrow position and tooltip width is correct.

  _Kate Higa_

- Fix `.eslintrc.json` `.ts` files override.

  _Hector Garcia_

## 0.0.69

### New

- Add ability to attach custom CSS classes to items added to `Truncate` components.

  _Cameron Dutro_

- Add `Primer::Alpha::Tooltip` component

  _Kate Higa_, _Kristján Oddsson_

### Breaking Changes

- Module for [script/update-statuses-project.rb](script/update-statuses-project.rb) changed to `GitHub`

  _Josh Soref_

### Misc

- Spelling fixes

  _Josh Soref_

- Bump view_component in Gemfile.lock files

  _Cameron Dutro_

- Remove markdown file mistakenly checked in.

  _Kate Higa_

- Upgrade octicons to >= 17.0.0

  _Jon Rohan_

### Bug Fixes

- Fix missing @primer/components dependency.

  _Hector Garcia_

## 0.0.68

### Updates

- Add accessible labels to Search AutoComplete when provided with an icon.

  _Andri Alexandrou_

- Restricts children for AutoComplete API to prevent accessibility violations and misuse

  _Lindsey Wild_

- Migrate from Heroku to Azure for the Rails storybook server.
- Build storybook static assets into Docker image.

  _Cameron Dutro_

- Remove CSS utilities from Blankslate

  _Hector Garcia_

- Improve last example on the PopoverComponent docs

  _Hector Garcia_

### Bug Fixes

- Fix live reloading during local docs development.

  _Cameron Dutro_

- Fix sequence of content in Subhead.

  _Hector Garcia_

### Deprecations

- Deprecate `Tooltip` component.

  _Kate Higa_

### Misc

- Updates README with missing `alt` attribute on image

  _Kate Higa_

- Updates contributing docs

  _Lindsey Wild_

- Fix link in system arguments docs

  _Lukas Spieß_

## 0.0.67

- Updating octicons to `> 16`

  _Jon Rohan_

## 0.0.66

- Revert optimization changes to utilities.

  _Josh Klina_

## 0.0.65

### Breaking Changes

- Revert accessibility changes to `Spinner` introduced since 0.0.60.

  _Charlotte Dann_

### Updates

- Optimize logic for converting class names into args

  _Josh Klina_

### Deprecations

- Deprecate `variant` in favor of `size` in `ButtonComponent` and `ButtonGroup`.

  _Manuel Puyol_

### Bug Fixes

- Call `image_path` on `Primer::Image#src`.

  _Manuel Puyol_

## 0.0.64

### New

- Add `raise_on_invalid_aria` config option to silence `aria-label` errors.

  _Manuel Puyol_

### Bug Fixes

- Add missing `border: 0`, `font_size: 0` and responsive `flex` system arguments.

  _Manuel Puyol_

## 0.0.63

### Breaking Changes

- Rename `caret` argument to `dropdown` in `ButtonComponent`.

  _Manuel Puyol_

- Remove `:large` variant from `ButtonComponent`.

  _Manuel Puyol_

- Update `Spinner` to add system arguments to outermost element

  _Charlotte Dann_

### Deprecations

- Deprecate `icon` and `counter` slots in `ButtonComponent` in favor of `leading_visual` and `trailing_visual`.

  _Manuel Puyol_

### Bug Fixes

- Fix `PopoverComponent`, allowing to reset `left` and `right` positioning.

  _Manuel Puyol_

## 0.0.62

### New

- Add linter for tracking deprecated `LayoutComponent` callsites

  _Josh Klina_

- Add functional `Label` schemes: `accent`, `attention`, `severe`, `done` and `sponsors`.

  _Manuel Puyol, Simon Luthi_

- Add linter to migrate from deprecated `Label` schemes to the new ones.

  _Manuel Puyol_

### Updates

- Update `Button` to add `8px` spacing between icon, text and counter.

  _Manuel Puyol_

- Update `BlankslateApiMigration` linter to support interpolations.

  _Manuel Puyol_

- Change spacing in `Blankslate`:

  - Between `description` and `primary_action` to `32px`.
  - Between `primary_action` and `secondary_action` to `16px`.

    _Manuel Puyol_

- Improve performance of `Classify#call`.

  _Cameron Dutro_

### Breaking Changes

- Add a warning to users if they try to use `tag:` parameters on a component where the tag is fixed.

  _Owen Niblock_

- Updating to @primer/css@19.0.0 and @primer/primitives@7.1.0. Which removes support for deprecated system color arguments.

  _Jon Rohan_

- Prevent `aria-label` to be used with `:div, :span, :p` tags without an explicit `role`.

  _Manuel Puyol_

### Deprecations

- Deprecate `Label` schemes `info` and `warning` in favor of `accent` and `attention`.

  _Manuel Puyol, Simon Luthi_

## 0.0.61

### New

- Adding new Alpha component: `Layout` with `main` and `sidebar` slots

  _Cameron Dutro_

- Add a two-column layout linter.

  _Cameron Dutro_

- Add the `HellipButton` component

  _Amélia Chavot_, _Owen Niblock_

### Updates

- Bump Storybook version to include Skip to Content links for keyboard auditors.

  _Katie Foster @inkblotty_

- Update the `HiddenTextExpander` component to use the `HellipButton`.

  _Amélia Chavot_, _Owen Niblock_

### Misc

- Fix components not rendering in Storybook because of kebab case arguments.

  _Amélia Chavot_, _Manuel Puyol_, _Owen Niblock_

- Fix a typo on a command on the contribution page.

  _Amélia Chavot_, _Owen Niblock_

### Bug Fixes

- Fix issue where tags were not self-closing when they are void elements.

  _Owen Niblock_

### Deprecations

- Deprecate `Primer::BlankslateComponent` in favor of `Primer::Beta::Blankslate`.

  _Manuel Puyol_

### Breaking Changes

- Require an `aria-label` to be provided for the `HiddenTextExpander` component.

  _Amélia Chavot_, _Owen Niblock_

- Rename `force_system_arguments` to `raise_on_invalid_options` to better reflect its functionality

  _Owen Niblock_

- Renamed `Blankslate` `title` slot to `heading`.

  _Manuel Puyol_

- Removed `Blankslate` `large` variant.

  _Manuel Puyol_

- Renamed `Blankslate` `graphic` slot to `visual`.

  _Manuel Puyol_

## 0.0.60

### Updates

- Adding new Alpha component: BorderBox Header with optional `title` slot

  _Katie Foster @inkblotty_

- Add note about `Breadcrumbs` not being responsive.

  _Joel Hawksley_

- Handling arguments that aren't system arguments or string arguments in primer_octicon.

  _Jon Rohan, Manuel Puyol_

- Improvements to the Procfile so script/dev works as expected.

  _Cameron Dutro_

- Migrating grid classes to utilities.yml process

  _Jon Rohan_

- Adding new system color arguments, and deprecating old arguments.

  _Jon Rohan_

- Make `Spinner` more accessible by adding `sr-only` loading text.

  _Manuel Puyol_

- Make class name validation configurable instead of relying on the Rails env.

  _Cameron Dutro_

### Bug Fixes

- Removes unwanted bottom border from active tab of `Alpha::TabNav`.

  _Ned Schwartz_

### Breaking changes

- Add size restriction to `Avatar`.

  _Kate Higa_

- Remove `square` attribute from `Avatar` in favor of `shape`. This change also affects `TimelineItem` `avatar` slot.

  _Manuel Puyol_

## 0.0.59

### Updates

- Changed `ClipboardCopy` to use `copy` instead of `paste` icon.

  _Cole Bemis_

### Breaking changes

- `Breadcrumbs` no longer accepts padding and font size system arguments.

  _Joel Hawksley_

## 0.0.58

### Updates

- Add accessibility section to `Breadcrumbs` page.

  _Kate Higa_

- Improve performance of the Classify module, i.e. `Classify.call`.

  _Cameron Dutro_

- Background arguments are now pulled in through the utilities class.

  _Jon Rohan_

- Border arguments are now pulled in through the utilities class.

  _Jon Rohan_

### Breaking changes

- `bg:` system argument will no longer accept hex color strings, and deprecated color scale.

  _Jon Rohan_

### Bug fixes

- Fix `ClipboardCopy` octicons not toggling correctly after first click.

  _Manuel Puyol, Kristján Oddsson_

## 0.0.57

### Bug fixes

- Don't suggest empty colors for Octicons when autocorrecting.

  _Manuel Puyol_

## 0.0.56

### Updates

- `Octicon` linter will autocorrect colors.

  _Manuel Puyol_

- `Button` linter will autocorrect when button uses `href`, `name`, `value` or `tabindex`.

  _Manuel Puyol_

- `Flash` linter won't autocorrect flashes with ERB in their content.

  _Manuel Puyol_

- Eager load components.

  _Cameron Dutro_

### Misc

- Refactor some of the rubocop valid_node? logic into BaseCop class.

  _Jon Rohan_

- Fix validation checker to use Utilities for color-\* classes.

  _Jon Rohan_

## 0.0.55

### Breaking changes

- `Primer::Breadcrumbs` requires `href`s for all items and no longer accepts the `selected` argument.

  _Joel Hawksley_

- Split `TabNav` into `TabNav` and `TabPanels`.

  _Kate Higa_

### New

- Use the allocation_stats gem to count object allocations in our benchmarks.
- Improve performance of Octicon cache key construction.

  _Cameron Dutro_

- Update `@primer/css` to `17.7.0` which includes a new argument for `word_break`

  _Jon Rohan_

### Misc

- Clean up extra constants in `UnderlineNav`.

  _Kate Higa_

## 0.0.54

### Breaking changes

- Rename `BreadcrumbComponent` to `Beta::Breadcrumbs`.

  _Joel Hawksley_

- Split `UnderlineNavComponent` into `Alpha::UnderlineNav` and `Alpha::UnderlinePanels`.

  _Kate Higa_

## 0.0.53

### New

- Add autocorrection to `FlashComponent` linter when the context is basic text.

  _Manuel Puyol_

### Updates

- Linters won't mark offenses when the ignore count is correct unless explicitly configured to do so.

  _Manuel Puyol_

- Deprecating background and border color presentational arguments

  _Jon Rohan_

- Map the `for` argument when autofixing `ClipboardCopy` migrations.

  _Kristján Oddsson_

- Add autocorrection for `CloseButton` linter.

  _Manuel Puyol_

- Moving text color variables to Utilities class

  _Jon Rohan_

### Bug fixes

- Linters won't convert HTML special elements.

  _Manuel Puyol_

### Misc

- Only run CHANGELOG CI on pull requests.

  _Manuel Puyol_

- Run CI actions on pushes to main.

  _Cameron Dutro_

- Get to 100% code coverage.

  _Cameron Dutro_

## 0.0.52

### New

- Adding `Primer::Beta::Truncate` component to reflect changes in primer/css component [Truncate](https://primer.style/css/components/truncate).

  _Jon Rohan_

- Add cop to look for deprecated system arguments and suggest replacements.

  _Jon Rohan_

- Add cop to use `primer_octicon` in favor of `octicon`.

  _Manuel Puyol_

- Fix release script so it doesn't loop continuously.

  _Cameron Dutro_

### Updates

- Promote `ClipboardCopy` to beta.

  _Manuel Puyol_

- PrimerOcticon linter supports `aria-` and `data-` attributes.

  _Manuel Puyol_

- Linters can:

  - convert values with ERB interpolations.
  - autocorrect cases with custom classes.

    _Manuel Puyol_

- Add a `scheme` option to `BorderBoxComponent` rows.

  _Cameron Dutro_

- Upgrade rubocop and support Ruby 3.0.

  _Cameron Dutro_

- Linters will not autocorrect cases where a required argument is missing.

  _Manuel Puyol_

### Misc

- Update benchmarks to run in every supported Ruby version.

  _Manuel Puyol_

- Add a linter generator.

  _Manuel Puyol_

## 0.0.51

### Breaking changes

- Rename `width` and `height` System Arguments to `w` and `h`, resolving conflict with HTML attribute names.

  _Manuel Puyol_

### Updates

- `SystemArgumentInsteadOfClass` linter will check for arguments in ViewHelpers.

  _Manuel Puyol_

## 0.0.50

### Updates

- Fix incorrect slots syntax in docs.

  _Joel Hawksley_, _Blake Williams_

### New

- Add linter suggestions for `CloseButton` component.

  _Manuel Puyol_

### Breaking changes

- Update to `octicons` `v15`, removing open-ended dependency. See [https://github.com/primer/octicons/releases/tag/v15.0.0] for icon name changes in release.

  _Joel Hawksley_

### Updates

- Don't require `title` for `Label`.

  _Manuel Puyol_

- Improve autocorrectable linters to convert known SystemArgument classes.

  _Manuel Puyol_

- Add support for `width: :full` and `height: :full` to System Arguments.

  _Joel Hawksley_

### Bug fixes

- Update linters to not autocorrect attributes with ERB blocks.

  _Manuel Puyol_

- Fix `:height` and `:width` docs to pull from Utilities

  _Jon Rohan_

## 0.0.49

### New

- Add linter suggestions for `Label` component.

  _Manuel Puyol_

- Add linter suggestions for `ClipboardCopy` component.

  _Manuel Puyol_

### Updates

- Update the `Truncate` component to accept `:strong` as a tag.

  _Amélia Chavot_

- Improve `Primer::Classify::Utilities.classes_to_hash` performance.

  _Manuel Puyol_

### Breaking changes

- Require tab with panels to have `panel_id` so `aria-controls` can be set.

  _Kate Higa_

- Renames:

  - `Primer::AvatarStackComponent` to `Primer::Beta::AvatarStack`.

    _Manuel Puyol_

### Misc

- Extract example tag parsing into helper.

  _Kate Higa_

- Generate a static constant JSON and use it when defining linters.

  _Manuel Puyol_

## 0.0.48

### Breaking changes

- Ensure panels in `Navigation::Tab` have a label.

  _Kate Higa_

### Misc

- Expose custom cops and default config for erblint.

  _Manuel Puyol_

- Fix double constant assign.

  _Manuel Puyol_

## 0.0.47

### Breaking changes

- Restrict tag for `Popover` to `:div` and `Popover` heading slot to headings.

  _Kate Higa_

- Renames:

  - `Primer::AutoComplete` to `Primer::Beta::AutoComplete`
  - `Primer::AutoComplete::Item` to `Primer::Beta::AutoComplete::Item`
  - `Primer::AvatarComponent` to `Primer::Beta::Avatar`

    _Manuel Puyol_

### Misc

- Update `doc_examples_axe_test` to exclude non-standalone components and fix `Markdown` example.

  _Kate Higa_

- Update `DetailsComponent` examples.

  _Manuel Puyol_

- Add linter to suggest system arguments instead of classes.

  _Manuel Puyol_

- Update component generator to create components in the right status module.

  _Manuel Puyol_

- Add example for truncating HTML to `Truncate`.

  _Joel Hawksley_

- Update docs generation to point to the correct file sources.

  _Manuel Puyol_

- Add ENV flag to dump linter data into a file.

  _Manuel Puyol_

## 0.0.46

### Updates

- Default to matching `name` and `id` of `input`.

  _Kate Higa_

- Restrict usage of padding system arguments on BorderBox, recommending use of `padding` density instead.

  _Joel Hawksley_

### Breaking changes

- Restrict `TabNav`and `Tab` tags.

  _Kate Higa_

- Restrict `AvatarStack` body slot tag and `ImageCrop` spinner tag.

  _Kate Higa_

- Restrict `Details` body slot tags and `UnderlineNav` body slot tags.

  _Kate Higa_

- Move Primer::Classify from `app/lib/` to `lib/`. This requires an extra `require "primer/classify"` statement for anywhere Classify is needed.

  _Manuel Puyol, Jon Rohan_

- Restrict `Menu` heading slot tags to heading tags and require `tag` argument.

  _Kate Higa_

- Adding animation, vertical_align, word_break, display, visibility, & position arguments to the utilities class. `animation: :grow` is now `animation: :hover_grow` this was a change because we changed the class name in primer.

  _Jon Rohan_

### Misc

- Update contributing guidelines with release instructions.

  _Kate Higa_

- Prevent flexible tag syntax with rubocop rule.

  _Kate Higa_

- Update linter autocorrection to use `""` instead of `true` for boolean attributes.

  _Manuel Puyol_

- Update Storybook version.

  _Manuel Puyol_

- Add a changelog authoring guide to `CHANGELOG.md`.

  _Amélia Chavot_

## 0.0.45

### Updates

- Allow copying from elements using `for` in `ClipboardCopy`.

  _Manuel Puyol_

### Breaking changes

- Remove `label` argument in favor of `aria-label` in `ClipboardCopy`.

  _Manuel Puyol_

### Misc

- Add autocorrect for button linters.

  _Manuel Puyol_

- Unify contributing guidelines.

  _Kate Higa_

- Rerun flaky system tests.

  _Manuel Puyol_

- Check if selector is a classify class in Utilities.

  _Jon Rohan_

## 0.0.44

### Updates

- Allow `Dropdown` menu items to be rendered outside a list.

  _Manuel Puyol_

### Breaking changes

- Require a label or `aria-label` to be provided for `AutoComplete` component.

  _Kate Higa_

- Renames:

  - `DropdownComponent` to `Dropdown`.
  - `Dropdown::MenuComponent` to `Dropdown::Menu`.
  - `Primer::ButtonMarketingComponent` to `Primer::Alpha::ButtonMarketing`.
  - `Primer::TextComponent` to `Primer::Beta::Text`.

    _Manuel Puyol_

- Removes `summary_classes` attribute in favor of the `summary` slot in `Dropdown`.

  _Manuel Puyol_

### Misc

- Replace Classify::Spacing class with pre-generated mappings.

  _Jon Rohan_

- Add linter suggestions for `Button` component.

  _Manuel Puyol_

- Sort documentation arguments.

  _Jon Rohan_

- Add validations for docs generation.

  _Manuel Puyol, Kate Higa_

- Change docs header order.

  _Manuel Puyol, Kate Higa_

- Add preliminary criteria for new `alpha` components.

  _Joel Hawksley_

## 0.0.43

### New

- Add `clearfix` and `container` system arguments.

  _Manuel Puyol_

### Updates

- Promote `TabNav` component to beta.

  _Manuel Puyol_

- Allow customizing `TabContainer` when using `TabNav` and `UnderlineNav` components.

  _Manuel Puyol_

### Breaking changes

- Restrict `col` system arguments to only accept values between 1 and 12.

  _Manuel Puyol_

### Misc

- Raise an error if `class` is used as a system argument.

  _Manuel Puyol_

- Don't commit auto-generated component previews.

  _Kate Higa_

- Provide linters for component migrations.

  _Manuel Puyol_

- Update docs to accept multiline descriptions.

  _Manuel Puyol_

- Upgrade primer/css to 17.2.1

  _Jon Rohan_

## 0.0.42

### New

- Add `font_family`, `font_style` and `text_transform` system arguments.

  _Manuel Puyol_

- Add more options for `font_size` and `font_weight`.

  _Manuel Puyol_

### Updates

- Add `align` option to the `TabNav` extra slot to allow HTML ordering.

  _Manuel Puyol_

### Misc

- Auto-generate component previews from doc examples and run integration test checks.

  _Kate Higa, Joel Hawksley_

- Configure previews controller to allow view helper usage in preview template.

  _Kate Higa_

- Only include `ViewComponent::SlotableV2` if `ViewComponent::Base` does not already include it.

  _Manuel Puyol_

- Add `force_system_arguments` option to raise an error if a class is used instead of using System Arguments.

  _Manuel Puyol_

### Breaking changes

- Restrict allowed tags for `Truncate`, `Markdown`, and `HiddenTextExpander`.

  _Kate Higa_

## 0.0.41

### New

- Create `LocalTime` component.

  _Kristján Oddsson_

- Create `Image` component.

  _Manuel Puyol_

- Add `extra` slot to `TabNav`.

  _Manuel Puyol_

- Do not raise error if Primer CSS class name is passed to component if `PRIMER_WARNINGS_DISABLED` is set.

  _Joel Hawksley_

### Accessibility

- Accept `aria-current="true"` in tabbed components.

  _Manuel Puyol_

### Changes

- Promote `Tooltip` component to beta.

  _Manuel Puyol_

### Bug fixes

- Ensure that `ClipboardCopy` behaviors only target ViewComponents.

  _Manuel Puyol_

- Ensure that the `rounded` attribute for `<image-crop>` is represented as a boolean attribute.

  _Kristján Oddsson_

### Breaking changes

- Rename `TooltipComponent` to `Tooltip`.

  _Manuel Puyol_

- Don't allow `OcticonComponent` height/width values under 16px

  _Jon Rohan_

- Remove `:large` size option from `OcticonComponent` and change `:medium` to 24px

  _Jon Rohan_

- Restrict `Label` tag to `span`, `div`, `a`, `summary`.

  _Kate Higa_

### Misc

- Add a CI check for changes to the CHANGELOG file.

  _Kristján Oddsson_

## 0.0.40

### New

- Create `ImageCrop` component.

  _Kristján Oddsson_

### Changes

- Promote `IconButton` to beta.

  _Manuel Puyol_

- Add `box` argument to `IconButton`.

  _Manuel Puyol_

- Promote `Markdown` to beta.

  _Manuel Puyol_

### Bug fixes

- Fix `IconButton` raising when `aria-label` was provided using an object.

  _Manuel Puyol_

- Fix disabling of default styles for `SpinnerComponent` via `nil` style parameter.

  _Chris Wilson_

### Deprecations

- Deprecate `Flex` in favor of `BoxComponent`.

  _Manuel Puyol_

### Breaking Changes

- Restrict `ButtonGroup` tag to `:div` and update docs for `Text` tag.

  _Kate Higa_

- Remove non-functional `width` and `height` `:fill` option.

  _Jon Rohan_, _Joel Hawksley_

- Restrict `Subhead` `heading` slot tag to `div` and `h1`-`h6`.

  _Kate Higa_

- Restrict `Blankslate` tag to `div`.

  _Kate Higa_

- Explicitly limit tag for `AvatarStack` to `:div` and `:span`.

  _Kate Higa_

- Rename `MarkdownComponent` to `Markdown`.

  _Manuel Puyol_

## 0.0.39

- Promote `CloseButton` to beta.

  _Manuel Puyol_

- Update `ClipboardCopy` to not toggle icons unless they both exist.

  _Kristján Oddsson_

- Add `icon` and `counter` slots to `ButtonComponent`.

  _Manuel Puyol_

- Create `IconButton` component.

  _Manuel Puyol_

- Removing trailing whitespace from output of `class=""` Classify generation.

  _Jon Rohan_

- Deprecate `FlexItem` in favor of `BoxComponent`.

  _Manuel Puyol_

- Dropping requirement of `octicons_helper` and updating `OcticonComponent` to use `octicon` gem directly.

  _Jon Rohan_

- **Breaking change:** Remove `:overlay` option from `border_color`.

  _Simon Luthi_

## 0.0.38

- Extract `BaseButton` component.

  _Manuel Puyol_

- Add default `aria-label` of "Close" to `CloseButton` component.

  _Kate Higa_

- Set button variants in the `ButtonGroup` parent.

  _Manuel Puyol_

- Create `ClipboardCopy` component.

  _Kristján Oddsson_

- **Breaking change:** Rename `ButtonGroupComponent` to `ButtonGroup` and promote it to beta.

  _Manuel Puyol_

- **Breaking change:** Do not provide default for `Heading` and improve documentation.

  _Kate Higa_

- **Breaking change:** Don't allow `StateComponent` to be a link.

  _Kate Higa_

## 0.0.37

- Update NPM package to include subdirectory JS files.

  _Manuel Puyol_

## 0.0.36

- Add `block` flag to `ButtonComponent`.

  _Manuel Puyol_

- Add `link` and `invisible` schemes to `ButtonComponent`.

  _Manuel Puyol_

- Create `CloseButton` and `HiddenTextExpander` component.

  _Manuel Puyol_

- **Breaking change:** Rename `AutoCompleteComponent` to `AutoComplete` and `AutoCompleteItemComponent` to `AutoComplete::Item`.

  _Manuel Puyol_

- **Breaking change:** Rename `TruncateComponent` to `Truncate` and promote it to beta.

  _Manuel Puyol_

## 0.0.35

- Promote `AutoCompleteComponent`, `AutoCompleteItemComponent`, `AvatarStackComponent` and `ButtonComponent` to beta.

  _Manuel Puyol_

- Allow `UnderlineNav` tabs to be rendered as a `<ul><li>` list.

  _Manuel Puyol_

- _Accessibility:_ Don't add tab roles when `UnderlineNav` or `TabNav` use link redirects.

  _Manuel Puyol_

- **Breaking change:** Make `label` required for `UnderlineNav` and `TabNav`.

  _Manuel Puyol_

## 0.0.34

- Add `p: :responsive` and `m: :auto` system arguments.

  _Manuel Puyol_

- Remove `my: :auto` and negative `m:` system arguments.

  _Manuel Puyol_

- **Breaking change:** Rename `FlashComponent` `variant` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `LinkComponent` `variant` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `ButtonComponent` `button_type` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `ButtonMarketing` `button_type` argument to `scheme`.

  _Manuel Puyol_

- **Breaking change:** Rename `StateComponent` `color` argument to `scheme`.

  _Manuel Puyol_

## 0.0.33

- Remove `TabbedComponent` validation requiring a tab to be selected.

  _Manuel Puyol_

## 0.0.32

- Allow passing the icon name as a positional argument to `OcticonComponent`.

  _Manuel Puyol_

- Promote `TimeAgoComponent` to beta.

  _Manuel Puyol_

- **Breaking change:** Update `TabNav#tab` API to accept the tab content as a block and panel content as a slot.

  _Manuel Puyol_

- **Breaking change:** Update `UnderlineNavComponent` API be more strict and support `TabContainer`.

  _Manuel Puyol_

## 0.0.31

- Fix `Popover` bug where body was only returning the last line of the HTML.

  _Manuel Puyol, Blake Williams_

## 0.0.30

- Make `color:`, `bg:` and `border_color:` accept string values.

  _Manuel Puyol_

## 0.0.29

- Add `primer_time_ago` helper.

  _Simon Taranto_

- Add `silence_deprecations` config to suppress deprecation warnings.

  _Manuel Puyol_

## 0.0.28

- Update `CounterComponent` to accept functional schemes `primary` and `secondary`. Deprecate `gray` and `light_gray` schemes.

  _Manuel Puyol_

- Add `force_functional_colors` option to convert colors to functional. This change includes a deprecation warning in non-production environments that warns about non functional color usage.

  _Manuel Puyol_

- Promote `DetailsComponent`, `HeadingComponent`, `TextComponent`, `TimelineItemComponent`, and
  `PopoverComponent` to beta status.

  _Simon Taranto_

- Update `LinkComponent`:

  - use `Link--muted` instead of `muted-link`.
  - accept `variant` and `underline` options.
  - accept `:span` as a tag.

    _Manuel Puyol_

- Add `AutoComplete` and `AutoCompleteItem` components.

  _Manuel Puyol_

- Publish types with npm package.

  _Keith Cirkel_ & _Clay Miller_

- Fix `AvatarComponent` to apply classes to the link wrapper if present.

  _Steve Richert_

- Fix `AvatarComponent` to apply the `avatar-small` class rather than `avatar--small`.

  _Steve Richert_

- **Breaking change:** Updates `PopoverComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.27

- Promote `BreadcrumbComponent` and `ProgressBarComponent` to beta status.

  _Simon Taranto_

- Fix `OcticonComponent` not rendering `data-test-selector` correctly.

  _Manuel Puyol_

- Add `TimeAgo` component.

  _Keith Cirkel_

- **Breaking change:** Updates `UnderlineNavComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Upgrade `LayoutComponent` to use Slots V2.

  _Simon Taranto_

## 0.0.26

- Fix `DetailsComponent` summary always being rendered as a `btn`.

  _Manuel Puyol_

- Promote `BlankslateComponent` and `BaseComponent` to beta status.

  _Simon Taranto_

## 0.0.25

- Promote `SubheadComponent` to beta.

  _Simon Taranto_

- Add deprecated `orange` and `purple` schemes to `LabelComponent`.

  _Manuel Puyol_

## 0.0.24

- Fix zeitwerk autoload integration.

  _Manuel Puyol_

- **Breaking change:** Upgrade `ProgressBarComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Upgrade `BreadcrumbComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.23

- Remove node and yarn version requirements from `@primer/view-components`.

  _Manuel Puyol_

- **Breaking change:** Upgrade `SubheadComponent` to use Slots V2.

  _Simon Taranto_

- **Breaking change:** Update `LabelComponent` to use only functional color
  supportive scheme keys. The component no longer accepts colors (`:gray`, for
  example) but only functional schemes (`primary`, for example).
  `LabelComponent` is promoted to beta status.

  _Simon Taranto_

## 0.0.22

- Add view helpers to easily render Primer components.

  _Manuel Puyol_

- Add `TabContainer` and `TabNav` components.

  _Manuel Puyol_

- Promote `StateComponent` to beta.

  _Simon Taranto_

- **Breaking change:** Upgrade `BorderBoxComponent` to use Slots V2.

  _Manuel Puyol_

- **Breaking change:** Upgrade `StateComponent` to support functional colors. This change requires using [@primer/css-next](https://www.npmjs.com/package/@primer/css-next). The required changes will be upstreamed to @primer/css at a later date.

  _Simon Taranto_

- **Breaking change:** Upgrade `DetailsComponent` to use Slots V2.

  _Simon Taranto_

## 0.0.21

- **Breaking change:** Upgrade `FlashComponent` to use Slots V2.

  _Joel Hawksley, Simon Taranto_

- **Breaking change:** Upgrade `BlankslateComponent` to use Slots V2.

  _Manuel Puyol_

- **Breaking change:** Upgrade `TimelineItemComponent` to use Slots V2.

  _Manuel Puyol_

## 0.0.20

- Fix bug when empty string was passed to Classify.

  _Manuel Puyol_

## 0.0.19

- Add support for functional colors to `color` system argument.

  _Jake Shorty_

- Add `AvatarStack`, `Dropdown`, `Markdown` and `Menu` components.

  _Manuel Puyol_

- Deprecate `DropdownMenuComponent`.

  _Manuel Puyol_

- Fix `Avatar` bug when used with links.

  _Manuel Puyol_

- Add cache for common Primer values.

  _Blake Williams_

- Add support for `octicons_helper` v12.

  _Cole Bemis_

- Add support for `border: true` to apply the `border` class.

  _Simon Taranto_

- Promote `Avatar`, `Link`, and `Counter` components to beta.

  _Simon Taranto_

- **Breaking change:** Drop support for Ruby 2.4.

  _Simon Taranto_

## 0.0.18

- Add `border_radius` system argument.

  _Ash Guillaume_

- Add `animation` system argument.

  _Manuel Puyol_

- Add `Truncate`, `ButtonGroup` and `ButtonMarketing` components.

  _Manuel Puyol_

- Add `Tooltip` component.

  _Simon Taranto_

## 0.0.17

- Ensure all components support inline styles.

  _Joel Hawksley_

## 0.0.16

- Adding a `spinner` slot to the `BlankslateComponent` that uses the `SpinnerComponent` added in `0.0.10`.

  _Jon Rohan_

- Bumping node engine to version `15.x`

  _Jon Rohan_

## 0.0.15

- Add ability to disable `limit` on Counter.

  _Christian Giordano_

- Rename `v` system argument to `visibility`.

  _Joel Hawksley_

## 0.0.14

- Add functional colors to Label.

  _Joel Hawksley_

## 0.0.13

- Add support for `xl` breakpoint.

  _Joel Hawksley_

## 0.0.12

- Adds support for disabling inline box-sizing style for `SpinnerComponent` via style parameter `Primer::SpinnerComponent.new(style: nil)`.

  _Chris Wilson_

## 0.0.11

- Renames DetailsComponent::OVERLAY_DEFAULT to DetailsComponent::NO_OVERLAY to more correctly describe its value.

  _Justin Kenyon_

## 0.0.10

- Add SpinnerComponent

  _Cole Bemis_

## 0.0.9

- BREAKING CHANGE: OcticonComponent no longer accepts `class` parameter; use `classes` instead.

  _heynan0_

## 0.0.8

- Add support for border margins, such as: `border_top: 0`.

  _Natasha Umer_

- Add FlashComponent and OcticonComponent.

  _Joel Hawksley_

- BREAKING CHANGE: BlankslateComponent accepts `icon_size` instead of `icon_height`.

  _Joel Hawksley_

## 0.0.7

- Use `octicons_helper` v11.0.0.

  _Joel Hawksley_

## 0.0.6

- Updated the invalid class name error message

  _emplums_

- Updated README with testing instructions

  _emplums_

- Add large and spacious option to BlankslateComponent

  _simurai_

- Add option for `ButtonComponent` to render a `summary` tag

  _Manuel Puyol_

- BREAKING CHANGE: Changed `DetailsComponent` summary and body to be slots

  _Manuel Puyol_

## 0.0.5

- Add support for box_shadow
- Add components:

  - Popover

    _Sarah Vessels_

## 0.0.4

- Added support for mx: and my: :auto.

  _Christian Giordano_

- Added support for custom layout sizes.

  _Manuel Puyol_

## 0.0.3

- Add support for responsive `float` system argument.

  _Joel Hawksley_

- Add components:

  - Avatar
  - Blankslate

    _Manuel Puyol, Ben Emdon_

## 0.0.1

- Add initial gem configuration.

  _Manuel Puyol, Joel Hawksley_

- Add demo app and storybook to test

  _Manuel Puyol_

- Add Classify, FetchOrFallback and ClassName helpers

  _Manuel Puyol_

- Add components:

  - BorderBox
  - Box
  - Breadcrumb
  - Button
  - Counter
  - Details
  - Dropdown
  - Flex
  - FlexItem
  - Heading
  - Label
  - Layout
  - Link
  - ProgressBar
  - State
  - Subhead
  - Text
  - TimelineItem
  - UnderlineNav

    _Manuel Puyol_
