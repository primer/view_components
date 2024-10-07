export declare class NavListElement extends HTMLElement {
    #private;
    items: HTMLElement[];
    topLevelList: HTMLElement;
    connectedCallback(): void;
    disconnectedCallback(): void;
    selectItemById(itemId: string | null): boolean;
    selectItemByHref(href: string | null): boolean;
    selectItemByCurrentLocation(): boolean;
    expandItem(item: HTMLElement): void;
    collapseItem(item: HTMLElement): void;
    itemIsExpanded(item: HTMLElement | null): boolean;
    handleItemWithSubItemClick(e: Event): void;
    handleItemWithSubItemKeydown(e: KeyboardEvent): void;
}
declare global {
    interface Window {
        NavListElement: typeof NavListElement;
    }
}
