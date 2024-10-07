import { ActionMenuElement } from './action_menu/action_menu_element';
declare class ActionBarElement extends HTMLElement {
    #private;
    items: HTMLElement[];
    itemContainer: HTMLElement;
    moreMenu: ActionMenuElement;
    connectedCallback(): void;
    disconnectedCallback(): void;
    menuItemClick(event: Event): void;
    update(): void;
}
declare global {
    interface Window {
        ActionBarElement: typeof ActionBarElement;
    }
}
export {};
