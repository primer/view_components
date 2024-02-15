/* eslint-disable custom-elements/expose-class-on-global */
import {controller} from '@github/catalyst'

@controller
export class ActionListElement extends HTMLElement {}

declare global {
  interface Window {
    ActionListElement: typeof ActionListElement
  }
}
