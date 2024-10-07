declare class SegmentedControlElement extends HTMLElement {
    #private;
    items: HTMLElement[];
    connectedCallback(): void;
    select(event: Event): void;
}
declare global {
    interface Window {
        SegmentedControlElement: typeof SegmentedControlElement;
    }
}
export {};
