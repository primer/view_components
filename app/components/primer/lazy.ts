import {lazyDefine} from '@github/catalyst'
import './shared_events'
import './utils'
import '@github/include-fragment-element'
import '@github/remote-input-element'

if (typeof document !== 'undefined') {
  lazyDefine({
    'action-list': () => import('./alpha/action_list'),
    'action-bar': () => import('./alpha/action_bar_element'),
    'details-menu': () => import('./alpha/dropdown'),
    'anchored-position': () => import('./anchored_position'),
    'dialog-helper': () => import('./dialog_helper'),
    'focus-group': () => import('./focus_group'),
    'scrollable-region': () => import('./scrollable_region'),
    'modal-dialog': () => import('./alpha/modal_dialog'),
    'nav-list': () => import('./beta/nav_list'),
    'nav-list-group': () => import('./beta/nav_list_group_element'),
    'segmented-control': () => import('./alpha/segmented_control'),
    'toggle-switch': () => import('./alpha/toggle_switch'),
    'tool-tip': () => import('./alpha/tool_tip'),
    'x-banner': () => import('./alpha/x_banner'),
    'auto-complete': () => import('./beta/auto_complete/auto_complete'),
    'clipboard-copy': () => import('./beta/clipboard_copy'),
    'relative-time': () => import('./beta/relative_time'),
    'tab-container': () => import('./alpha/tab_container'),
    'primer-multi-input': () => import('../../lib/primer/forms/primer_multi_input'),
    'primer-text-field': () => import('../../lib/primer/forms/primer_text_field'),
    'primer-text-area': () => import('../../lib/primer/forms/primer_text_area'),
    'toggle-switch-input': () => import('../../lib/primer/forms/toggle_switch_input'),
    'action-menu': () => import('./alpha/action_menu/action_menu_element'),
    'select-panel': () => import('./alpha/select_panel_element'),
    'details-toggle': () => import('./beta/details_toggle_element'),
    'tree-view': () => import('./alpha/tree_view/tree_view'),
    'tree-view-icon-pair': () => import('./alpha/tree_view/tree_view_icon_pair_element'),
    'tree-view-sub-tree-node': () => import('./alpha/tree_view/tree_view_sub_tree_node_element'),
    'tree-view-include-fragment': () => import('./alpha/tree_view/tree_view_include_fragment_element'),
    // [GENERATOR ANCHOR]
  })
}
