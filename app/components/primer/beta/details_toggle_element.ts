import {controller, target} from '@github/catalyst'

/**
 * A companion Catalyst element for the Details view component. This element
 * ensures the <details> and <summary> elements markup is properly accessible by
 * updating the aria-label and aria-expanded attributes.
 *
 * aria-label values default to "Expand" and "Collapse". To override those
 * values, use the `data-aria-label-open` and `data-aria-label-closed`
 * attributes on the summary target.
 *
 * @example
 * ```html
 * <details-toggle>
 *   <details open=true data-target="details-toggle.detailsTarget">
 *     <summary
 *       aria-expanded="true"
 *       aria-label="Collapse me"
 *       data-target="details-toggle.summaryTarget"
 *       data-action="click:details-toggle#toggle"
 *       data-aria-label-closed="Expand me"
 *       data-aria-label-open="Collapse me"
 *     >
 *       Click me
 *     </summary>
 *     <div>Contents</div>
 *   </details>
 * </details-toggle>
 * ```
 */

@controller
class DetailsToggleElement extends HTMLElement {
  @target detailsTarget!: HTMLDetailsElement
  @target summaryTarget!: HTMLElement

  toggle() {
    const detailsIsOpen = this.detailsTarget.hasAttribute('open')
    if (detailsIsOpen) {
      const ariaLabelClosed = this.summaryTarget.getAttribute('data-aria-label-closed') || 'Expand'
      this.summaryTarget.setAttribute('aria-label', ariaLabelClosed)
      this.summaryTarget.setAttribute('aria-expanded', 'false')
    } else {
      const ariaLabelOpen = this.summaryTarget.getAttribute('data-aria-label-open') || 'Collapse'
      this.summaryTarget.setAttribute('aria-label', ariaLabelOpen)
      this.summaryTarget.setAttribute('aria-expanded', 'true')
    }
  }
}

declare global {
  interface Window {
    DetailsToggleElement: typeof DetailsToggleElement
  }
}

window.DetailsToggleElement = DetailsToggleElement
