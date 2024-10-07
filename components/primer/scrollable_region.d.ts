export declare class ScrollableRegionElement extends HTMLElement {
    hasOverflow: boolean;
    labelledBy: string;
    observer: ResizeObserver;
    connectedCallback(): void;
    disconnectedCallback(): void;
    attributeChangedCallback(name: string): void;
}
declare global {
    interface Window {
        ScrollableRegionElement: typeof ScrollableRegionElement;
    }
}
