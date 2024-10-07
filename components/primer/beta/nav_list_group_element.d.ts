export declare class NavListGroupElement extends HTMLElement {
    #private;
    showMoreItem: HTMLElement;
    focusMarkers: HTMLElement[];
    connectedCallback(): void;
    get showMoreDisabled(): boolean;
    set showMoreDisabled(value: boolean);
    set currentPage(value: number);
    get currentPage(): number;
    get totalPages(): number;
    get paginationSrc(): string;
    private showMore;
    private setShowMoreItemState;
}
declare global {
    interface Window {
        NavListGroupElement: typeof NavListGroupElement;
    }
}
