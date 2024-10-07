declare class ToggleSwitchElement extends HTMLElement {
    switch: HTMLElement;
    loadingSpinner: HTMLElement;
    errorIcon: HTMLElement;
    turbo: boolean;
    private toggling;
    get src(): string | null;
    get csrf(): string | null;
    get csrfField(): string;
    isRemote(): boolean;
    toggle(): Promise<void>;
    turnOn(): void;
    turnOff(): void;
    isOn(): boolean;
    isOff(): boolean;
    isDisabled(): boolean;
    disable(): void;
    enable(): void;
    private performToggle;
    private setLoadingState;
    private setSuccessState;
    private setErrorState;
    private setFinishedState;
    private submitForm;
}
declare global {
    interface Window {
        ToggleSwitchElement: typeof ToggleSwitchElement;
        Turbo: {
            renderStreamMessage: (message: string) => void;
        };
    }
}
export {};
