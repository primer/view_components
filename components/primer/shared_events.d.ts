export type ItemActivatedEvent = {
    item: Element;
    checked: boolean;
    value: string | null;
};
declare global {
    interface HTMLElementEventMap {
        itemActivated: CustomEvent<ItemActivatedEvent>;
        beforeItemActivated: CustomEvent<ItemActivatedEvent>;
    }
}
