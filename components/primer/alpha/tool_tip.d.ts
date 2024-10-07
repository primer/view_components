import '@oddbird/popover-polyfill';
type Direction = 'n' | 's' | 'e' | 'w' | 'ne' | 'se' | 'nw' | 'sw';
declare class ToolTipElement extends HTMLElement {
    #private;
    styles(): string;
    get showReason(): "focus" | "mouse";
    get htmlFor(): string;
    set htmlFor(value: string);
    get type(): 'description' | 'label';
    set type(value: 'description' | 'label');
    get direction(): Direction;
    set direction(value: Direction);
    get control(): HTMLElement | null;
    set hiddenFromView(value: true | false);
    get hiddenFromView(): true | false;
    connectedCallback(): void;
    disconnectedCallback(): void;
    handleEvent(event: Event): Promise<void>;
    static observedAttributes: string[];
    attributeChangedCallback(name: string): void;
}
declare global {
    interface Window {
        ToolTipElement: typeof ToolTipElement;
    }
}
export {};
