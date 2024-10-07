import type { AnchorAlignment, AnchorSide, PositionSettings } from '@primer/behaviors';
export default class AnchoredPositionElement extends HTMLElement implements PositionSettings {
    #private;
    get align(): AnchorAlignment;
    set align(value: AnchorAlignment);
    get side(): AnchorSide;
    set side(value: AnchorSide);
    get anchorOffset(): number;
    set anchorOffset(value: number | 'normal' | 'spacious');
    get anchor(): string;
    set anchor(value: string);
    get anchorElement(): HTMLElement | null;
    set anchorElement(value: HTMLElement | null);
    get alignmentOffset(): number;
    set alignmentOffset(value: number);
    get allowOutOfBounds(): boolean;
    set allowOutOfBounds(value: boolean);
    connectedCallback(): void;
    static observedAttributes: string[];
    attributeChangedCallback(): void;
    update(): void;
}
declare global {
    interface Window {
        AnchoredPositionElement: typeof AnchoredPositionElement;
    }
}
