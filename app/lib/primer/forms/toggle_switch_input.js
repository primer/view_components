/* eslint-disable custom-elements/expose-class-on-global */
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
import { controller, target } from '@github/catalyst';
let ToggleSwitchInputElement = class ToggleSwitchInputElement extends HTMLElement {
    connectedCallback() {
        this.addEventListener('toggleSwitchError', (event) => {
            this.validationMessageElement.textContent = event.detail;
            this.validationElement.removeAttribute('hidden');
        });
        this.addEventListener('toggleSwitchSuccess', () => {
            this.validationMessageElement.textContent = '';
            this.validationElement.setAttribute('hidden', 'hidden');
        });
        this.addEventListener('toggleSwitchLoading', () => {
            this.validationMessageElement.textContent = '';
            this.validationElement.setAttribute('hidden', 'hidden');
        });
    }
};
__decorate([
    target
], ToggleSwitchInputElement.prototype, "validationElement", void 0);
__decorate([
    target
], ToggleSwitchInputElement.prototype, "validationMessageElement", void 0);
ToggleSwitchInputElement = __decorate([
    controller
], ToggleSwitchInputElement);
export { ToggleSwitchInputElement };
