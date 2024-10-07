export declare class ModalDialogElement extends HTMLElement {
    #private;
    openButton: HTMLButtonElement | null;
    get open(): boolean;
    set open(value: boolean);
    get showButtons(): NodeList;
    connectedCallback(): void;
    show(): void;
    close(closedNotCancelled?: boolean): void;
}
declare global {
    interface Window {
        ModalDialogElement: typeof ModalDialogElement;
    }
    interface HTMLElementTagNameMap {
        'modal-dialog': ModalDialogElement;
    }
}
