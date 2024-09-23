var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
/* eslint-disable custom-elements/expose-class-on-global */
import { controller, targets } from '@github/catalyst';
let PrimerMultiInputElement = class PrimerMultiInputElement extends HTMLElement {
    activateField(name) {
        const fieldWithName = this.findField(name);
        if (!fieldWithName)
            return;
        for (const field of this.fields) {
            if (field === fieldWithName)
                continue;
            field.setAttribute('disabled', 'disabled');
            field.setAttribute('hidden', 'hidden');
            field.parentElement?.setAttribute('hidden', 'hidden');
        }
        fieldWithName.removeAttribute('disabled');
        fieldWithName.removeAttribute('hidden');
        fieldWithName.parentElement?.removeAttribute('hidden');
    }
    findField(name) {
        for (const field of this.fields) {
            if (field.getAttribute('data-name') === name) {
                return field;
            }
        }
        return null;
    }
};
__decorate([
    targets
], PrimerMultiInputElement.prototype, "fields", void 0);
PrimerMultiInputElement = __decorate([
    controller
], PrimerMultiInputElement);
export { PrimerMultiInputElement };
if (!window.customElements.get('primer-multi-input')) {
    Object.assign(window, { PrimerMultiInputElement });
    window.customElements.define('primer-multi-input', PrimerMultiInputElement);
}
