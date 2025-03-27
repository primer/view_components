import {controller, target} from '@github/catalyst'

@controller
class CollapsibleBorderBoxTriggerElement extends HTMLElement {
    container = null
    collapsed = false // Needs to be retrieved from the component call, to be set-able externally

    // eslint-disable-next-line custom-elements/no-constructor
    constructor() {
        super()

        this.container = this.closest('.Box')

        // Only to test as I couldn't get the action to trigger on click
        setTimeout(() => {
            this.toggle()
        }, 1000)
    }

    public toggle() {
        if (this.collapsed) {
            this.collapsed = false
            this.expandAll()
        } else {
            this.collapsed = true
            this.hideAll()
        }
    }

    private hideAll() {
        const rows = this.container.querySelectorAll('.Box-row, .Box-body, .Box-footer')

        rows.forEach(row => {
            row.style.display = 'none';
        })

        this.container.querySelector('.down-icon').style.display = 'block'
        this.container.querySelector('.up-icon').style.display = 'none'
    }

    private expandAll() {
        const rows = this.container.querySelectorAll('.Box-row, .Box-body, .Box-footer')

        rows.forEach(row => {
            row.style.display = 'block';
        })

        this.container.querySelector('.down-icon').style.display = 'none'
        this.container.querySelector('.up-icon').style.display = 'block'

    }
}

declare global {
    interface Window {
        CollapsibleBorderBoxTriggerElement: typeof CollapsibleBorderBoxTriggerElement
    }
}

if (!window.customElements.get('collapsible-border-box-trigger')) {
    window.CollapsibleBorderBoxTriggerElement = CollapsibleBorderBoxTriggerElement
    window.customElements.define('collapsible-border-box-trigger', CollapsibleBorderBoxTriggerElement)
}
