/* eslint-disable custom-elements/expose-class-on-global */
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __classPrivateFieldGet = (this && this.__classPrivateFieldGet) || function (receiver, state, kind, f) {
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a getter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot read private member from an object whose class did not declare it");
    return kind === "m" ? f : kind === "a" ? f.call(receiver) : f ? f.value : state.get(receiver);
};
var __classPrivateFieldSet = (this && this.__classPrivateFieldSet) || function (receiver, state, value, kind, f) {
    if (kind === "m") throw new TypeError("Private method is not writable");
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a setter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot write private member to an object whose class did not declare it");
    return (kind === "a" ? f.call(receiver, value) : f ? f.value = value : state.set(receiver, value)), value;
};
var _PrimerTextFieldElement_abortController;
import '@github/auto-check-element';
import { controller, target } from '@github/catalyst';
let PrimerTextFieldElement = class PrimerTextFieldElement extends HTMLElement {
    constructor() {
        super(...arguments);
        _PrimerTextFieldElement_abortController.set(this, void 0);
    }
    connectedCallback() {
        __classPrivateFieldGet(this, _PrimerTextFieldElement_abortController, "f")?.abort();
        const { signal } = (__classPrivateFieldSet(this, _PrimerTextFieldElement_abortController, new AbortController(), "f"));
        this.addEventListener('auto-check-success', async (event) => {
            const message = await event.detail.response.text();
            if (message && message.length > 0) {
                this.setSuccess(message);
            }
            else {
                this.clearError();
            }
        }, { signal });
        this.addEventListener('auto-check-error', async (event) => {
            const errorMessage = await event.detail.response.text();
            this.setError(errorMessage);
        }, { signal });
    }
    disconnectedCallback() {
        __classPrivateFieldGet(this, _PrimerTextFieldElement_abortController, "f")?.abort();
    }
    clearContents() {
        this.inputElement.value = '';
        this.inputElement.focus();
        this.inputElement.dispatchEvent(new Event('input', { bubbles: true, cancelable: false }));
    }
    clearError() {
        this.inputElement.removeAttribute('invalid');
        this.validationElement.hidden = true;
        this.validationMessageElement.replaceChildren();
    }
    setValidationMessage(message) {
        const template = document.createElement('template');
        // eslint-disable-next-line github/no-inner-html
        template.innerHTML = message;
        const fragment = document.importNode(template.content, true);
        this.validationMessageElement.replaceChildren(fragment);
    }
    toggleValidationStyling(isError) {
        if (isError) {
            this.validationElement.classList.remove('FormControl-inlineValidation--success');
        }
        else {
            this.validationElement.classList.add('FormControl-inlineValidation--success');
        }
        this.validationSuccessIcon.hidden = isError;
        this.validationErrorIcon.hidden = !isError;
        this.inputElement.setAttribute('invalid', isError ? 'true' : 'false');
    }
    setSuccess(message) {
        this.toggleValidationStyling(false);
        this.setValidationMessage(message);
        this.validationElement.hidden = false;
    }
    setError(message) {
        this.toggleValidationStyling(true);
        this.setValidationMessage(message);
        this.validationElement.hidden = false;
    }
    showLeadingSpinner() {
        this.leadingSpinner?.removeAttribute('hidden');
        this.leadingVisual?.setAttribute('hidden', '');
    }
    hideLeadingSpinner() {
        this.leadingSpinner?.setAttribute('hidden', '');
        this.leadingVisual?.removeAttribute('hidden');
    }
};
_PrimerTextFieldElement_abortController = new WeakMap();
__decorate([
    target
], PrimerTextFieldElement.prototype, "inputElement", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "validationElement", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "validationMessageElement", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "validationSuccessIcon", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "validationErrorIcon", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "leadingVisual", void 0);
__decorate([
    target
], PrimerTextFieldElement.prototype, "leadingSpinner", void 0);
PrimerTextFieldElement = __decorate([
    controller
], PrimerTextFieldElement);
export { PrimerTextFieldElement };
