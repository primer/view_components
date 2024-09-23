export declare class PrimerMultiInputElement extends HTMLElement {
    fields: HTMLInputElement[];
    activateField(name: string): void;
    private findField;
}
declare global {
    interface Window {
        PrimerMultiInputElement: typeof PrimerMultiInputElement;
    }
}
