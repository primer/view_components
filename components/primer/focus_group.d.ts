import '@oddbird/popover-polyfill';
export default class FocusGroupElement extends HTMLElement {
    #private;
    get nowrap(): boolean;
    set nowrap(value: boolean);
    get direction(): 'horizontal' | 'vertical' | 'both';
    set direction(value: 'horizontal' | 'vertical' | 'both');
    get retain(): boolean;
    set retain(value: boolean);
    get mnemonics(): boolean;
    connectedCallback(): void;
    disconnectedCallback(): void;
    handleEvent(event: Event): void;
}
declare global {
    interface Window {
        FocusGroupElement: typeof FocusGroupElement;
    }
}
