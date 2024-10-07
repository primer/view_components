import { IncludeFragmentElement } from '@github/include-fragment-element';
import type { AnchorAlignment, AnchorSide } from '@primer/behaviors';
import '@oddbird/popover-polyfill';
type SelectVariant = 'none' | 'single' | 'multiple' | null;
type SelectedItem = {
    label: string | null | undefined;
    value: string | null | undefined;
    inputName: string | null | undefined;
};
export type SelectPanelItem = HTMLLIElement;
export type FilterFn = (item: SelectPanelItem, query: string) => boolean;
export declare class SelectPanelElement extends HTMLElement {
    #private;
    includeFragment: IncludeFragmentElement;
    dialog: HTMLDialogElement;
    filterInputTextField: HTMLInputElement;
    remoteInput: HTMLElement;
    list: HTMLElement;
    ariaLiveContainer: HTMLElement;
    noResults: HTMLElement;
    fragmentErrorElement: HTMLElement;
    bannerErrorElement: HTMLElement;
    bodySpinner: HTMLElement;
    filterFn?: FilterFn;
    get open(): boolean;
    get selectVariant(): SelectVariant;
    get ariaSelectionType(): string;
    set selectVariant(variant: SelectVariant);
    get dynamicLabelPrefix(): string;
    get dynamicAriaLabelPrefix(): string;
    set dynamicLabelPrefix(value: string);
    get dynamicLabel(): boolean;
    set dynamicLabel(value: boolean);
    get invokerElement(): HTMLButtonElement | null;
    get closeButton(): HTMLButtonElement | null;
    get invokerLabel(): HTMLElement | null;
    get selectedItems(): SelectedItem[];
    get align(): AnchorAlignment;
    get side(): AnchorSide;
    updateAnchorPosition(): void;
    connectedCallback(): void;
    disconnectedCallback(): void;
    handleEvent(event: Event): void;
    show(): void;
    hide(): void;
    get visibleItems(): SelectPanelItem[];
    get items(): SelectPanelItem[];
    get focusableItem(): HTMLElement | undefined;
    getItemById(itemId: string): SelectPanelItem | null;
    isItemDisabled(item: SelectPanelItem | null): boolean;
    disableItem(item: SelectPanelItem | null): void;
    enableItem(item: SelectPanelItem | null): void;
    isItemHidden(item: SelectPanelItem | null): boolean;
    isItemChecked(item: SelectPanelItem | null): boolean;
    checkItem(item: SelectPanelItem | null): void;
    uncheckItem(item: SelectPanelItem | null): void;
}
declare global {
    interface Window {
        SelectPanelElement: typeof SelectPanelElement;
    }
}
export {};
