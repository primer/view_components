export declare class DialogHelperElement extends HTMLElement {
    #private;
    get dialog(): HTMLDialogElement | null;
    connectedCallback(): void;
    disconnectedCallback(): void;
    handleEvent(event: MouseEvent): void;
}
declare global {
    interface Window {
        DialogHelperElement: typeof DialogHelperElement;
    }
    interface HTMLElementTagNameMap {
        'dialog-helper': DialogHelperElement;
    }
}
