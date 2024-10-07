export declare class ActionListTruncationObserver {
    resizeObserver: ResizeObserver;
    constructor(el: HTMLElement);
    unobserve(el: HTMLElement): void;
    update(el: HTMLElement): void;
}
export declare class ActionListElement extends HTMLElement {
    #private;
    connectedCallback(): void;
    disconnectedCallback(): void;
}
declare global {
    interface Window {
        ActionListElement: typeof ActionListElement;
    }
}
