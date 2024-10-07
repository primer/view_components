import '@oddbird/popover-polyfill';
import type { IncludeFragmentElement } from '@github/include-fragment-element';
type SelectVariant = 'none' | 'single' | 'multiple' | null;
type SelectedItem = {
    label: string | null | undefined;
    value: string | null | undefined;
    element: Element;
};
export declare class ActionMenuElement extends HTMLElement {
    #private;
    includeFragment: IncludeFragmentElement;
    get selectVariant(): SelectVariant;
    set selectVariant(variant: SelectVariant);
    get dynamicLabelPrefix(): string;
    set dynamicLabelPrefix(value: string);
    get dynamicLabel(): boolean;
    set dynamicLabel(value: boolean);
    get popoverElement(): HTMLElement | null;
    get invokerElement(): HTMLButtonElement | null;
    get invokerLabel(): HTMLElement | null;
    get selectedItems(): SelectedItem[];
    connectedCallback(): void;
    disconnectedCallback(): void;
    handleEvent(event: Event): void;
    get items(): HTMLElement[];
    getItemById(itemId: string): HTMLElement | null;
    isItemDisabled(item: Element | null): boolean;
    disableItem(item: Element | null): void;
    enableItem(item: Element | null): void;
    isItemHidden(item: Element | null): boolean;
    hideItem(item: Element | null): void;
    showItem(item: Element | null): void;
    isItemChecked(item: Element | null): boolean;
    checkItem(item: Element | null): void;
    uncheckItem(item: Element | null): void;
}
declare global {
    interface Window {
        ActionMenuElement: typeof ActionMenuElement;
    }
}
export {};
