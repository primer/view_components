import '@github/auto-check-element';
import type { AutoCheckErrorEvent, AutoCheckSuccessEvent } from '@github/auto-check-element';
declare global {
    interface HTMLElementEventMap {
        'auto-check-success': AutoCheckSuccessEvent;
        'auto-check-error': AutoCheckErrorEvent;
    }
}
export declare class PrimerTextFieldElement extends HTMLElement {
    #private;
    inputElement: HTMLInputElement;
    validationElement: HTMLElement;
    validationMessageElement: HTMLElement;
    validationSuccessIcon: HTMLElement;
    validationErrorIcon: HTMLElement;
    leadingVisual: HTMLElement;
    leadingSpinner: HTMLElement;
    connectedCallback(): void;
    disconnectedCallback(): void;
    clearContents(): void;
    clearError(): void;
    setValidationMessage(message: string): void;
    toggleValidationStyling(isError: boolean): void;
    setSuccess(message: string): void;
    setError(message: string): void;
    showLeadingSpinner(): void;
    hideLeadingSpinner(): void;
}
